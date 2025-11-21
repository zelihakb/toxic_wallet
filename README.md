# 💸 Cüzdan Canavarı (Toxic Wallet)

**"Harcadıkça laf yediğin, biriktirdikçe sevildiğin tek cüzdan uygulaması."**

Cüzdan Canavarı, sıradan ve sıkıcı bütçe takip uygulamalarına tepki olarak doğdu. Sen paranı çarçur ederken sessiz kalan uygulamalardan sıkılmadın mı? Bu uygulama, harcamalarına göre sana "toksik" yorumlar yapar, yüzüne acı gerçekleri vurur ve seni finansal disipline sokmak için duygusal manipülasyon (şaka şaka... ya da değil?) kullanır.

![App Screenshot](assets/screenshots/app_preview.png) *(Ekran görüntüsü eklenecek)*

## 🌑 Özellikler

*   **Toksik Geri Bildirimler:** Harcama limitlerini aştığında seni yargılayan, az harcadığında (nadiren) öven dinamik mesajlar.
*   **Canlı Karakter (İkon):** Harcama durumuna göre yüz ifadesi değişen (üzgün, kızgın, sinsi, mutlu) bir karakter.
*   **Parametre (Analiz) Sayfası:** Haftalık harcama karşılaştırması ve "Tahmini Aylık Erime Hızı" ile finansal çöküşünü saniye saniye izle.
*   **Utanç Tablosu (Profil):** Kendi harcama seviyeni gör ve "Finansal Enkaz" olup olmadığını öğren.
*   **Dark Mode:** Simsiyah ve Kan Kırmızısı tema ile tam bir "Villian" havası.
*   **Yerel Veri:** Tüm verilerin cihazında (Hive veritabanı) saklanır. İnternet gerektirmez, kimse (biz bile) neye para harcadığını bilmez.

## 🛠️ Kurulum

Bu projeyi kendi bilgisayarında çalıştırmak için:

1.  **Flutter SDK**'nın kurulu olduğundan emin ol.
2.  Projeyi klonla:
    ```bash
    git clone https://github.com/KULLANICI_ADIN/toxic_wallet.git
    ```
3.  Proje dizinine git:
    ```bash
    cd toxic_wallet
    ```
4.  Bağımlılıkları yükle:
    ```bash
    flutter pub get
    ```
5.  Uygulamayı çalıştır:
    ```bash
    flutter run
    ```

## 📂 Proje Yapısı

*   `lib/main.dart`: Uygulamanın ana giriş noktası ve sayfalar.
*   `lib/data/app_data.dart`: Uygulama ayarları, renk paleti ve o meşhur "toksik" lafların bulunduğu veri dosyası.
*   `lib/ui/pages/`: Sayfa tasarımları (Analiz, Profil vb.).
*   `lib/ui/widgets/`: Tekrar kullanılabilir bileşenler (Ticker vb.).

## 🤝 Katkıda Bulunma

Eğer sen de bu projeye daha fazla "toksiklik" katmak istersen, Pull Request göndermekten çekinme! Yeni laflar, yeni özellikler veya daha acımasız algoritmalar... Hepsine açığız.

## 📝 Lisans

Bu proje tamamen eğlence amaçlıdır. Finansal tavsiye içermez. Batarsanız sorumluluk kabul etmeyiz. 💸
