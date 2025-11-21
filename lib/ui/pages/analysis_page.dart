import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toxic_wallet/data/app_data.dart';
import 'package:toxic_wallet/ui/widgets/ticker_widget.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  Map<String, dynamic> _calculateData(Box box) {
    if (box.isEmpty) {
      return {
        'thisWeek': 0.0,
        'lastWeek': 0.0,
        'monthlyAverage': 0.0,
        'toxicMsg': "Veri yok, henüz masumsun.",
      };
    }

    DateTime now = DateTime.now();
    DateTime startOfThisWeek = now.subtract(const Duration(days: 7));
    DateTime startOfLastWeek = now.subtract(const Duration(days: 14));

    double thisWeek = 0.0;
    double lastWeek = 0.0;
    double totalAllTime = 0.0;

    // Iterate through all expenses
    for (var i = 0; i < box.length; i++) {
      var data = box.getAt(i);
      DateTime date = DateTime.parse(data['date']);
      double amount = data['amount'];

      totalAllTime += amount;

      if (date.isAfter(startOfThisWeek)) {
        thisWeek += amount;
      } else if (date.isAfter(startOfLastWeek) &&
          date.isBefore(startOfThisWeek)) {
        lastWeek += amount;
      }
    }

    // Calculate Monthly Average
    int daysActive = 1;
    if (box.isNotEmpty) {
      var firstData = box.getAt(0);
      DateTime firstDate = DateTime.parse(firstData['date']);
      daysActive = now.difference(firstDate).inDays;
      if (daysActive == 0) daysActive = 1;
    }

    double dailyAverage = totalAllTime / daysActive;
    double monthlyAverage = dailyAverage * 30;

    // Toxic Commentary
    String msg = "";
    if (thisWeek > lastWeek) {
      double increase = lastWeek == 0
          ? 100
          : ((thisWeek - lastWeek) / lastWeek) * 100;
      if (increase > 50) {
        msg =
            "Geçen haftaya göre %${increase.toStringAsFixed(1)} daha fazla harcadın. Batışın görkemli olacak.";
      } else {
        msg = "Harcamalar artıyor... İpin ucu kaçtı.";
      }
    } else if (thisWeek < lastWeek) {
      msg = "Bu hafta daha az harcadın. Kesin evden çıkmadın.";
    } else {
      msg = "İstikrarını koruyorsun. Fakirlikte istikrar.";
    }

    return {
      'thisWeek': thisWeek,
      'lastWeek': lastWeek,
      'monthlyAverage': monthlyAverage,
      'toxicMsg': msg,
    };
  }

  @override
  Widget build(BuildContext context) {
    final int primaryAppColor = appSettings['primary_app_color'] as int;
    final int cardColor = appSettings['card_color'] as int;
    final int textColor = appSettings['text_color'] as int;
    final int lightTextColor = appSettings['light_text_color'] as int;
    final String currency = appSettings['currency'] as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Parametre")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('expenseBox').listenable(),
        builder: (context, Box box, _) {
          final data = _calculateData(box);
          final double monthlyAverage = data['monthlyAverage'] as double;
          final double lastWeekTotal = data['lastWeek'] as double;
          final double thisWeekTotal = data['thisWeek'] as double;
          final String toxicAnalysisMsg = data['toxicMsg'] as String;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ticker Widget
                TickerWidget(
                  monthlyAmount: monthlyAverage,
                  currency: currency,
                  label: "TAHMİNİ AYLIK ERİME HIZI",
                ),
                const SizedBox(height: 30),

                // Comparison Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        "Geçen Hafta",
                        lastWeekTotal,
                        currency,
                        lightTextColor,
                        cardColor,
                        textColor,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildInfoCard(
                        "Bu Hafta",
                        thisWeekTotal,
                        currency,
                        primaryAppColor, // Highlight current week
                        cardColor,
                        textColor,
                        isBold: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Toxic Commentary Area
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.redAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ACIMASIZ GERÇEKLER",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        toxicAnalysisMsg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(textColor),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    double amount,
    String currency,
    int colorInt,
    int cardColorInt,
    int textColorInt, {
    bool isBold = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(cardColorInt),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isBold ? Border.all(color: Color(colorInt), width: 2) : null,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(textColorInt).withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${amount.toStringAsFixed(1)} $currency",
            style: TextStyle(
              color: Color(isBold ? colorInt : textColorInt),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
