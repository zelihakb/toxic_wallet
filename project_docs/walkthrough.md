# Toxic Wallet - Feature Walkthrough

I have implemented the requested features to make "Cüzdan Canavarı" more dynamic and toxic.

## 1. Dashboard & Peeking Animation
- **What Changed**: The character now "peeks" from the bottom of the screen instead of sliding from the side.
- **Asset Fallback**: Since we don't have the image files yet, the app now uses **Icons** (like 😠, 😐, 🤑) that match the emotion.
- **How to Verify**:
    1. Open the app.
    2. Select a category (e.g., "Ulaşım").
    3. Enter a small amount (e.g., 10).
    4. **Observe**: The character (Icon) should slide up from the bottom with a "Shake" or "Angry" expression.
    5. Enter a large amount (e.g., 5000).
    6. **Observe**: The character updates to a "Happy/Greedy" expression.

## 2. Analysis Page
- **What Changed**: Replaced the "Yakında" placeholder with a full Analysis dashboard.
- **Features**:
    - **Weekly Comparison**: Compares "This Week" vs "Last Week" spending.
    - **Toxic Commentary**: Gives you a sarcastic message based on your trend (e.g., "Batışın görkemli olacak").
- **How to Verify**:
    1. Add a few expenses in the Dashboard.
    2. Go to the "Analiz" tab (3rd tab).
    3. Check the "Bu Hafta" and "Geçen Hafta" cards.
    4. Read the message below (it should be judgmental).

## 3. Real-time Cost Ticker (Parametre)
- **What Changed**: Added a "Digital Ticker" at the top of the Analysis page.
- **Function**: It calculates your estimated "Monthly Burn Rate" and breaks it down to **spending per second**.
- **Visual**: You will see the numbers increasing in real-time (kuruş kuruş), showing how fast your money is melting.

## Next Steps
- **Add Assets**: When you have the character images, place them in `assets/characters/` and uncomment the `Image.asset` code in `lib/main.dart`.
