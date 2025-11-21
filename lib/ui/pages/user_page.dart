import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toxic_wallet/data/app_data.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int primaryAppColor = appSettings['primary_app_color'] as int;
    final int cardColor = appSettings['card_color'] as int;
    final int textColor = appSettings['text_color'] as int;
    final int lightTextColor = appSettings['light_text_color'] as int;
    final String currency = appSettings['currency'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Utanç Tablosu"),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Yakında: Arkadaşlarını ekle ve onlarla batışını yarıştır!",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('expenseBox').listenable(),
        builder: (context, Box box, _) {
          // Calculate User's Total Spending
          double totalSpent = 0.0;
          for (var i = 0; i < box.length; i++) {
            totalSpent += box.getAt(i)['amount'] as double;
          }

          // Mock Data for "Global Shame List"
          // We will insert the user into this list dynamically
          List<Map<String, dynamic>> shameList = [
            {"name": "Mert K.", "amount": 45200.0, "title": "Finansal Enkaz"},
            {"name": "Ayşe Y.", "amount": 32150.0, "title": "AVM Sponsoru"},
            {"name": "Can B.", "amount": 12500.0, "title": "Masum Köylü"},
            {"name": "Elif D.", "amount": 8900.0, "title": "Cimri"},
          ];

          // Add User to the list
          shameList.add({
            "name": "Sen",
            "amount": totalSpent,
            "title": _getUserTitle(totalSpent),
            "isMe": true,
          });

          // Sort by amount descending
          shameList.sort(
            (a, b) => (b['amount'] as double).compareTo(a['amount'] as double),
          );

          // Take top 10 or all
          // shameList = shameList.take(10).toList();

          return Column(
            children: [
              const SizedBox(height: 20),
              // User Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(primaryAppColor).withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(primaryAppColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Anonim Harcamacı",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(textColor),
                      ),
                    ),
                    Text(
                      _getUserTitle(totalSpent),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(lightTextColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Leaderboard Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.leaderboard, color: Colors.orange),
                    const SizedBox(width: 10),
                    Text(
                      "GLOBAL UTANÇ LİSTESİ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(lightTextColor),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Leaderboard List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: shameList.length,
                  itemBuilder: (context, index) {
                    final item = shameList[index];
                    final bool isMe = item['isMe'] == true;
                    final double amount = item['amount'] as double;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Color(primaryAppColor).withOpacity(0.1)
                            : Color(cardColor),
                        borderRadius: BorderRadius.circular(12),
                        border: isMe
                            ? Border.all(color: Color(primaryAppColor))
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isMe
                              ? Color(primaryAppColor)
                              : Colors.grey.shade800, // Dark mode adjustment
                          foregroundColor: isMe
                              ? Colors.white
                              : Colors.grey.shade400,
                          child: Text("${index + 1}"),
                        ),
                        title: Text(
                          item['name'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(textColor),
                          ),
                        ),
                        subtitle: Text(
                          item['title'] as String,
                          style: TextStyle(
                            color: Color(lightTextColor),
                            fontSize: 12,
                          ),
                        ),
                        trailing: Text(
                          "${amount.toStringAsFixed(0)} $currency",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe
                                ? Color(primaryAppColor)
                                : Color(textColor),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getUserTitle(double amount) {
    if (amount < 1000) return "Masum Başlangıç";
    if (amount < 5000) return "Harcama Çırağı";
    if (amount < 10000) return "Orta Direk Yıkıcısı";
    if (amount < 20000) return "Kredi Kartı Gazisi";
    if (amount < 50000) return "Finansal Enkaz";
    return "Ekonomi Bakanı";
  }
}
