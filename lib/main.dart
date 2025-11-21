// lib/main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toxic_wallet/data/app_data.dart'; // PROJE ADIN FARKLIYSA DÜZELT! (toxic_wallet yerine kendi projenin adı)

import 'package:toxic_wallet/ui/pages/analysis_page.dart';
import 'package:toxic_wallet/ui/pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('expenseBox');
  runApp(
    const FunWalletApp(),
  ); // Buradaki sınıf adının kendi ana sınıf adınla (genelde MyApp) eşleştiğinden emin ol!
}

class FunWalletApp extends StatelessWidget {
  const FunWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    // appSettings değerlerini güvenli bir şekilde alalım
    final int primaryAppColor = appSettings['primary_app_color'] as int;
    final int secondaryAppColor = appSettings['secondary_app_color'] as int;
    final int backgroundColor = appSettings['background_color'] as int;
    final int cardColor = appSettings['card_color'] as int;
    final int textColor = appSettings['text_color'] as int;
    final int lightTextColor = appSettings['light_text_color'] as int;

    return MaterialApp(
      title: 'Cüzdan Canavarı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: Color(primaryAppColor),
              brightness: Brightness.light,
            ).copyWith(
              primary: Color(primaryAppColor),
              secondary: Color(secondaryAppColor),
            ),
        scaffoldBackgroundColor: Color(backgroundColor),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(cardColor),
          foregroundColor: Color(textColor),
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Color(textColor),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardTheme.of(context).copyWith(
          color: Color(cardColor),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(cardColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(primaryAppColor), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Color(lightTextColor)),
          prefixIconColor: Color(lightTextColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(primaryAppColor),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Color(cardColor),
          indicatorColor: Color(primaryAppColor).withOpacity(0.1),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: Color(primaryAppColor),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              );
            }
            return TextStyle(color: Color(lightTextColor), fontSize: 12);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: Color(primaryAppColor));
            }
            return IconThemeData(color: Color(lightTextColor));
          }),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DashboardPage(),
          HistoryPage(),
          AnalysisPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wallet_rounded),
            label: 'Harca',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            label: 'Geçmiş',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_rounded),
            label: 'Parametre',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final _expenseBox = Hive.box('expenseBox');
  final _amountController = TextEditingController();

  Map<String, dynamic> _selectedMainCategory = categoriesData.first;
  Map<String, dynamic> _selectedSubCategoryData =
      categoriesData.first['sub_categories'][0];

  bool _showCharacter = false;
  late AnimationController _characterAnimationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _characterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    // Slide from bottom (Offset(0, 1)) to visible position (Offset(0, 0))
    // "Peeking" effect: The character will slide up from the bottom.
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _characterAnimationController,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInBack,
          ),
        );
  }

  @override
  void dispose() {
    _characterAnimationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getReaction(double amount) {
    Map<String, dynamic> reactions =
        _selectedSubCategoryData['reactions'] as Map<String, dynamic>;

    final double lowThreshold =
        (reactions['low_spend']['threshold_max'] ?? 0.0) as double;
    final double mediumThreshold =
        (reactions['medium_spend']['threshold_max'] ?? 0.0) as double;

    if (amount <= lowThreshold) {
      return reactions['low_spend'] as Map<String, dynamic>;
    } else if (amount <= mediumThreshold) {
      return reactions['medium_spend'] as Map<String, dynamic>;
    } else {
      return reactions['high_spend'] as Map<String, dynamic>;
    }
  }

  void _updateCharacterPreview(String value) {
    double? amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      if (_showCharacter) {
        _characterAnimationController.reverse().then((_) {
          if (mounted) setState(() => _showCharacter = false);
        });
      }
      return;
    }

    if (!_showCharacter) {
      setState(() => _showCharacter = true);
      _characterAnimationController.forward();
    } else {
      // If already showing, maybe "shake" or update expression?
      // For now, just setState to trigger rebuild with new reaction
      setState(() {});
    }
  }

  void _addExpense() {
    double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Geçerli bir miktar gir!",
            style: TextStyle(color: Color(appSettings['card_color'] as int)),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    var reaction = _getReaction(amount);
    String toxicMsg = reaction['message'] as String;

    _expenseBox.add({
      'amount': amount,
      'main_category_id': _selectedMainCategory['id'] as String,
      'main_category_name': _selectedMainCategory['display_name'] as String,
      'sub_category_id': _selectedSubCategoryData['id'] as String,
      'sub_category_name': _selectedSubCategoryData['display_name'] as String,
      'message': toxicMsg,
      'date': DateTime.now().toIso8601String(),
    });

    _amountController.clear();
    _characterAnimationController.reverse().then((_) {
      if (mounted) setState(() => _showCharacter = false);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          toxicMsg,
          style: TextStyle(color: Color(appSettings['card_color'] as int)),
        ),
        backgroundColor: Color(appSettings['primary_app_color'] as int),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  IconData _getIconForEmotion(String emotion) {
    switch (emotion) {
      case 'disappointed':
        return Icons.sentiment_dissatisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      case 'greedy_happy':
      case 'happy':
      case 'hyped':
      case 'excited':
        return Icons.sentiment_very_satisfied;
      case 'suspicious':
        return Icons.visibility;
      case 'satisfied':
        return Icons.sentiment_satisfied;
      case 'evil_laugh':
        return Icons.mood_bad;
      case 'angry':
        return Icons.flash_on;
      case 'judging':
        return Icons.remove_red_eye;
      case 'bored':
        return Icons.bedtime;
      case 'shocked':
        return Icons.bolt;
      default:
        return Icons.face;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int primaryAppColor = appSettings['primary_app_color'] as int;
    final int cardColor = appSettings['card_color'] as int;
    final int textColor = appSettings['text_color'] as int;
    final int lightTextColor = appSettings['light_text_color'] as int;
    final String currency = appSettings['currency'] as String;

    var currentReaction = _getReaction(
      double.tryParse(_amountController.text) ?? 0.0,
    );
    String emotion = currentReaction['emotion'] as String;
    // Asset path logic kept for future, but we use Icon fallback primarily now
    String characterAssetPath =
        '${appSettings['base_asset_path']}${currentReaction['asset_image'] as String}';

    return Scaffold(
      appBar: AppBar(title: const Text("Cüzdan Canavarı")),
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Ne kadar bayıldın?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(textColor),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textInputAction:
                      TextInputAction.done, // Klavye "Tamam" butonu
                  onSubmitted: (_) => _addExpense(), // Enter'a basınca ekle
                  onChanged: _updateCharacterPreview,
                  decoration: InputDecoration(
                    hintText: '0.00 $currency',
                    // prefixIcon removed as requested
                    hintStyle: TextStyle(color: Color(lightTextColor)),
                  ),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(textColor),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(cardColor),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, dynamic>>(
                      value: _selectedMainCategory,
                      isExpanded: true,
                      dropdownColor: Color(
                        cardColor,
                      ), // Fix for dark mode visibility
                      style: TextStyle(color: Color(textColor), fontSize: 16),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(lightTextColor),
                      ),
                      items: categoriesData.map((data) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: data,
                          child: Text(data['display_name']! as String),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedMainCategory = newValue!;
                          _selectedSubCategoryData =
                              (_selectedMainCategory['sub_categories']
                                      as List<dynamic>)[0]
                                  as Map<String, dynamic>;
                          _updateCharacterPreview(_amountController.text);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(cardColor),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, dynamic>>(
                      value: _selectedSubCategoryData,
                      isExpanded: true,
                      dropdownColor: Color(
                        cardColor,
                      ), // Fix for dark mode visibility
                      style: TextStyle(color: Color(textColor), fontSize: 16),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(lightTextColor),
                      ),
                      items:
                          (_selectedMainCategory['sub_categories']
                                  as List<dynamic>)
                              .map((subData) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: subData as Map<String, dynamic>,
                                  child: Text(
                                    subData['display_name']! as String,
                                  ),
                                );
                              })
                              .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSubCategoryData = newValue!;
                          _updateCharacterPreview(_amountController.text);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _addExpense,
                  child: const Text("HARCAMAYI GÖM"),
                ),
                const SizedBox(height: 20),
                // --- MESAJ ALANI (BUTON ALTINDA) ---
                if (_amountController.text.isNotEmpty &&
                    double.tryParse(_amountController.text) != null &&
                    double.parse(_amountController.text) > 0)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(primaryAppColor).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(primaryAppColor).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Color(primaryAppColor)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            currentReaction['message'] as String,
                            style: TextStyle(
                              color: Color(textColor),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // --- KARAKTER ANİMASYON ALANI (SADECE İKON - SOL ALT) ---
          Align(
            alignment: Alignment.bottomLeft,
            child: SlideTransition(
              position: _slideAnimation,
              child: _showCharacter
                  ? Container(
                      width: 80, // Daha küçük, sadece ikon
                      height: 80,
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(cardColor),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Color(primaryAppColor),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child:
                            currentReaction != null &&
                                currentReaction['asset_image'] != null
                            ? ClipOval(
                                child: Image.asset(
                                  'assets/characters/${currentReaction['asset_image']}',
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      _getIconForEmotion(emotion),
                                      size: 40,
                                      color: Color(primaryAppColor),
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                _getIconForEmotion(emotion),
                                size: 40,
                                color: Color(primaryAppColor),
                              ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. SAYFA: GEÇMİŞ LİSTESİ
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('expenseBox');
    final int primaryAppColor = appSettings['primary_app_color'] as int;
    final int textColor = appSettings['text_color'] as int;
    final int lightTextColor = appSettings['light_text_color'] as int;
    final String currency = appSettings['currency'] as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Geçmiş Harcamalar")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text(
                "Henüz harcama yok, cüzdanın nefes alıyor...",
                style: TextStyle(color: Color(lightTextColor), fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              var data = box.getAt(box.length - 1 - index);
              String mainCategoryName =
                  data['main_category_name'] as String? ??
                  'Bilinmeyen Kategori';
              String subCategoryName =
                  data['sub_category_name'] as String? ??
                  'Bilinmeyen Alt Kategori';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(primaryAppColor).withOpacity(0.1),
                    child: Icon(
                      Icons.receipt_long,
                      color: Color(primaryAppColor),
                    ),
                  ),
                  title: Text(
                    '${data['amount']} $currency - $mainCategoryName ($subCategoryName)', // unnecessary braces removed
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(textColor),
                    ),
                  ),
                  subtitle: Text(
                    data['message'] as String? ?? 'Mesaj yok.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(lightTextColor),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => box.deleteAt(box.length - 1 - index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
