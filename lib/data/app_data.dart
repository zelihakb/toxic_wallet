// lib/data/app_data.dart

// Bu dosyada Flutter Widget'ları veya Material kütüphanesi kullanılmadığı için import satırına gerek yok.

// Uygulama Ayarları (Global renkler ve para birimi)
final Map<String, dynamic> appSettings = {
  "currency": "₺",
  "base_asset_path": "assets/characters/",
  "primary_app_color": 0xFFD32F2F, // Kan Kırmızısı (Red 700)
  "secondary_app_color": 0xFFEF5350, // Açık Kırmızı (Red 400)
  "background_color": 0xFF121212, // Simsiyah (Material Dark Background)
  "card_color": 0xFF1E1E1E, // Koyu Gri (Dark Surface)
  "text_color": 0xFFFFFFFF, // Beyaz Metin
  "light_text_color": 0xFFB0BEC5, // Açık Gri Metin (Blue Grey 200)
};

// Kategori ve Alt Kategori Verileri
final List<Map<String, dynamic>> categoriesData = [
  {
    "id": "food_beverage",
    "display_name": "Gıda & Beslenme",
    "character_id": "barista_joe", // Bu kategoriye özel karakter ID'si
    "sub_categories": [
      {
        "id": "grocery",
        "display_name": "Market Alışverişi",
        "reactions": {
          "low_spend": {
            "threshold_max": 299.0,
            "emotion": "disappointed",
            "asset_image": "barista_sad.png", // Bu duyguya özel görsel
            "message": "Sepete sadece Ekmek + Yarım Ümit koymuşsun.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 649.0,
            "emotion": "neutral",
            "asset_image": "barista_neutral.png",
            "message":
                "Normal market. Ne fakirsin ne zenginsin… enflasyonla tokatlanıyorsun sadece.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "greedy_happy",
            "asset_image": "barista_happy.png",
            "message":
                "Bu alışveriş değil, kıtlık bölgesine yardım paketi. AFAD aradı, şaşırdı.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "dining_out",
        "display_name": "Dışarıda Yeme-İçme",
        "reactions": {
          "low_spend": {
            "threshold_max": 199.0,
            "emotion": "disappointed",
            "asset_image": "barista_sad.png",
            "message": "Simit + ayran kokusu alıyorum… öğrenci ruhu hortlamış.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 399.0,
            "emotion": "neutral",
            "asset_image": "barista_neutral.png",
            "message": "Tam kıvamında. Cüzdan üzülmüş ama ağlamamış.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "greedy_happy",
            "asset_image": "barista_happy.png",
            "message":
                "Bu fiyata evde tencere kaynardı. Ama sen şov yapmayı seçtin.",
            "animation_type": "bounce",
          },
        },
      },
    ],
  },
  {
    "id": "housing_bills",
    "display_name": "Barınma & Faturalar",
    "character_id": "greedy_landlord",
    "sub_categories": [
      {
        "id": "rent_dorm",
        "display_name": "Kira / Yurt Ücreti",
        "reactions": {
          "low_spend": {
            "threshold_max": 7499.0,
            "emotion": "suspicious",
            "asset_image": "landlord_sus.png",
            "message":
                "Burası ev değil… dönüştürülmüş depo gibi koktu buradan.",
            "animation_type": "fade_in",
          },
          "medium_spend": {
            "threshold_max": 19999.0,
            "emotion": "satisfied",
            "asset_image": "landlord_neutral.png",
            "message":
                "Bu fiyat ne tam ev, ne tam çadır… sanki iki boyut arasında sıkışmış bir yaşam alanı kiralamışsın..",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "evil_laugh",
            "asset_image": "landlord_happy.png",
            "message":
                "Bu kira değil, lüks hapishane ücreti. Ev sahibi seni varis ilan etmiş olabilir.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "bills",
        "display_name": "Faturalar",
        "reactions": {
          "low_spend": {
            "threshold_max": 349.0,
            "emotion": "suspicious",
            "asset_image": "landlord_sus.png",
            "message":
                "Işığı açmamışsın, suyu ısıtmamışsın, kombiyi görmemişsin. Zombi misin?",
            "animation_type": "fade_in",
          },
          "medium_spend": {
            "threshold_max": 699.0,
            "emotion": "satisfied",
            "asset_image": "landlord_neutral.png",
            "message":
                "Fatura seni tokatlamış ama ‘ölme de gel’ diyerek geri bırakmış. Bir nevi boss fight’ın 2. fazı...",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "evil_laugh",
            "asset_image": "landlord_happy.png",
            "message":
                "Kombiyi açmışsın… hem de köyde düğün var sanmış gibi açmışsın.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "dues",
        "display_name": "Aidat",
        "reactions": {
          "low_spend": {
            "threshold_max": 249.0,
            "emotion": "suspicious",
            "asset_image": "landlord_sus.png",
            "message": "Asansör çalışmıyor ama aidat ucuz, güzel.",
            "animation_type": "fade_in",
          },
          "medium_spend": {
            "threshold_max": 449.0,
            "emotion": "satisfied",
            "asset_image": "landlord_neutral.png",
            "message": "Soru: Ne hizmet aldın? Cevap: ALMADIN.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "evil_laugh",
            "asset_image": "landlord_happy.png",
            "message": "Bu aidat değil, apartman yönetiminin tatil fonu.",
            "animation_type": "bounce",
          },
        },
      },
    ],
  },
  {
    "id": "transportation",
    "display_name": "Ulaşım",
    "character_id": "taxi_driver_uncle",
    "sub_categories": [
      {
        "id": "public_transport",
        "display_name": "Toplu Taşıma",
        "reactions": {
          "low_spend": {
            "threshold_max": 59.0,
            "emotion": "angry",
            "asset_image": "taxi_angry.png",
            "message":
                "Bu ne? 1 durak mı gittin yoksa kartı makine yutmadı mı?",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 129.0,
            "emotion": "neutral",
            "asset_image": "taxi_neutral.png",
            "message": "Normal şehir içi sürünme ücreti.",
            "animation_type": "slide_in_right",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "happy",
            "asset_image": "taxi_happy.png",
            "message": "Toplu taşıma değil, gönüllü işkenceye para vermişsin.",
            "animation_type": "zoom_in",
          },
        },
      },
      {
        "id": "taxi_uber",
        "display_name": "Taksi / Uber",
        "reactions": {
          "low_spend": {
            "threshold_max": 119.0,
            "emotion": "angry",
            "asset_image": "taxi_angry.png",
            "message": "Yakın mesafe: Üşengeçlik kabul edildi.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 199.0,
            "emotion": "neutral",
            "asset_image": "taxi_neutral.png",
            "message": "Sadece biraz üşümüşsün, problem yok.",
            "animation_type": "slide_in_right",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "happy",
            "asset_image": "taxi_happy.png",
            "message":
                "Taksi lobisine aylık bağış yaptığın için teşekkür ederiz.",
            "animation_type": "zoom_in",
          },
        },
      },
      {
        "id": "fuel",
        "display_name": "Akaryakıt",
        "reactions": {
          "low_spend": {
            "threshold_max": 249.0,
            "emotion": "angry",
            "asset_image": "taxi_angry.png",
            "message": "Depoyu değil, sadece ruhunu biraz doldurmuşsun.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 549.0,
            "emotion": "neutral",
            "asset_image": "taxi_neutral.png",
            "message": "Araban var ama huzurun yok.",
            "animation_type": "slide_in_right",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "happy",
            "asset_image": "taxi_happy.png",
            "message": "Benzin değil… sıvı altın almışsın resmen.",
            "animation_type": "zoom_in",
          },
        },
      },
    ],
  },
  {
    "id": "shopping_personal_tech",
    "display_name": "Alışveriş, Kişisel Bakım & Teknoloji",
    "character_id": "fashion_influencer",
    "sub_categories": [
      {
        "id": "clothing_accessories",
        "display_name": "Giyim & Aksesuar",
        "reactions": {
          "low_spend": {
            "threshold_max": 299.0,
            "emotion": "judging",
            "asset_image": "fashion_judge.png",
            "message": "Bu ne? Çorap + umut paketi mi?",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 799.0,
            "emotion": "neutral",
            "asset_image": "fashion_cool.png",
            "message": "Tam orta sınıf moda hamlesi.",
            "animation_type": "slide_in_left",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "excited",
            "asset_image": "fashion_love.png",
            "message":
                "Kıyafet değil, kişilik satın almışsın. Yakıştı ama cüzdan öldü.",
            "animation_type": "confetti_pop",
          },
        },
      },
      {
        "id": "personal_care",
        "display_name": "Kişisel Bakım",
        "reactions": {
          "low_spend": {
            "threshold_max": 199.0,
            "emotion": "judging",
            "asset_image": "stylist_sad.png",
            "message": "Şampuan + tırnak makası, klasik.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 399.0,
            "emotion": "neutral",
            "asset_image": "stylist_neutral.png",
            "message": "Orta seviye bakım: insan gibi görünme çabası.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "excited",
            "asset_image": "stylist_happy.png",
            "message":
                "Tipini düzeltme fonu taşmış durumda. Kuaför seni seviyor.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "technology",
        "display_name": "Teknoloji",
        "reactions": {
          "low_spend": {
            "threshold_max": 299.0,
            "emotion": "bored",
            "asset_image": "tech_guy_bored.png",
            "message": "Şarj aleti + kablo… 2 haftada kırılır.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 899.0,
            "emotion": "neutral",
            "asset_image": "tech_guy_neutral.png",
            "message": "Mantıklı cihaz almışsın, tebrikler.",
            "animation_type": "slide_in_left",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "hyped",
            "asset_image": "tech_guy_happy.png",
            "message":
                "Cihaz değil, yatırım almışsın. Apple hissesi misin sen?",
            "animation_type": "confetti_pop",
          },
        },
      },
    ],
  },
  {
    "id": "entertainment_activity",
    "display_name": "Eğlence & Aktivite",
    "character_id": "gamer_dude",
    "sub_categories": [
      {
        "id": "social_activity",
        "display_name": "Sosyal Aktivite",
        "reactions": {
          "low_spend": {
            "threshold_max": 149.0,
            "emotion": "bored",
            "asset_image": "gamer_bored.png",
            "message": "Evde oturmuş gibi bir fiyat…",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 349.0,
            "emotion": "neutral",
            "asset_image": "gamer_neutral.png",
            "message": "Normal eğlence. Ne çok mutlu ne çok fakir.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "hyped",
            "asset_image": "gamer_hyped.png",
            "message": "Bu fiyat eğlence değil, finansal intihar.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "digital_subscriptions",
        "display_name": "Dijital Abonelikler",
        "reactions": {
          "low_spend": {
            "threshold_max": 79.0,
            "emotion": "bored",
            "asset_image": "gamer_bored.png",
            "message": "Deneme paketi taktiği…",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 149.0,
            "emotion": "neutral",
            "asset_image": "gamer_neutral.png",
            "message": "Klasik ay sonu sömürüsü.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "hyped",
            "asset_image": "gamer_hyped.png",
            "message": "Bu kadar aboneliğin varsa Netflix seni işe alır.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "hobby",
        "display_name": "Hobi",
        "reactions": {
          "low_spend": {
            "threshold_max": 149.0,
            "emotion": "bored",
            "asset_image": "gamer_bored.png",
            "message": "Aldın ama yapacak mısın? Emin değilim.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 299.0,
            "emotion": "neutral",
            "asset_image": "gamer_neutral.png",
            "message": "Hobim var diyebileceğin kıvamda.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "hyped",
            "asset_image": "gamer_hyped.png",
            "message": "Bu artık hobi değil, hayattan kaçış planı.",
            "animation_type": "bounce",
          },
        },
      },
    ],
  },
  {
    "id": "health_education",
    "display_name": "Sağlık & Eğitim",
    "character_id": "doctor_prof",
    "sub_categories": [
      {
        "id": "health",
        "display_name": "Sağlık",
        "reactions": {
          "low_spend": {
            "threshold_max": 149.0,
            "emotion": "disappointed",
            "asset_image": "doctor_sad.png",
            "message": "Vitamin + yara bandı kombosu.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 299.0,
            "emotion": "neutral",
            "asset_image": "doctor_neutral.png",
            "message": "Normal bakım… canın sağ olsun.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "shocked",
            "asset_image": "doctor_happy.png",
            "message": "Bu sağlık değil, finansal darbe.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "education",
        "display_name": "Eğitim",
        "reactions": {
          "low_spend": {
            "threshold_max": 79.0,
            "emotion": "disappointed",
            "asset_image": "prof_sad.png",
            "message": "Fotokopi + kalem klasik.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 199.0,
            "emotion": "neutral",
            "asset_image": "prof_neutral.png",
            "message": "Öğrenci modunda masraf.",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "shocked",
            "asset_image": "prof_happy.png",
            "message": "Bu kadar yatırım yaptın, bari mezun ol.",
            "animation_type": "bounce",
          },
        },
      },
    ],
  },
  {
    "id": "financial_other",
    "display_name": "Finansal & Diğer",
    "character_id": "banker_guy",
    "sub_categories": [
      {
        "id": "debt_credit",
        "display_name": "Borç / Kredi",
        "reactions": {
          "low_spend": {
            "threshold_max": 449.0,
            "emotion": "angry",
            "asset_image": "banker_sad.png",
            "message": "Geçmiş hataların minik taksidi.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 999.0,
            "emotion": "neutral",
            "asset_image": "banker_neutral.png",
            "message": "Borç döngüsü devam ediyor…",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "greedy_happy",
            "asset_image": "banker_happy.png",
            "message": "Bu ödeme değil, travma bedeli.",
            "animation_type": "bounce",
          },
        },
      },
      {
        "id": "other_expenses",
        "display_name": "Diğer",
        "reactions": {
          "low_spend": {
            "threshold_max": 199.0,
            "emotion": "confused",
            "asset_image": "banker_sad.png",
            "message": "Ufak saçmalıklar bütçesi.",
            "animation_type": "shake",
          },
          "medium_spend": {
            "threshold_max": 349.0,
            "emotion": "neutral",
            "asset_image": "banker_neutral.png",
            "message": "Kafaya göre harcamalar…",
            "animation_type": "slide_up",
          },
          "high_spend": {
            "threshold_max": double.infinity,
            "emotion": "greedy_happy",
            "asset_image": "banker_happy.png",
            "message": "Ne aldığını hatırlamıyorsan bu normal…",
            "animation_type": "bounce",
          },
        },
      },
    ],
  },
];
