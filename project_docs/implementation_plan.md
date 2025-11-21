# Implementation Plan - Toxic Wallet Refinement

The goal is to enhance the "Toxic Wallet" app with a more dynamic "peeking" character animation, a new Analysis page with spending comparisons, and a "Real-time Cost Ticker" that visualizes spending per second.

## User Review Required

> [!IMPORTANT]
> **Missing Assets**: The project currently lacks the `assets/characters/` directory and image files. I will implement the UI using **Icons and Colors** as placeholders so the app runs immediately. I will leave the code structure ready for you to drop in images later.

## Proposed Changes

### Configuration
#### [MODIFY] [pubspec.yaml](file:///c:/Users/zelia/toxic_wallet/pubspec.yaml)
- (Optional) I will NOT modify this to avoid build errors with missing files, but I will add comments on how to enable assets later.

### UI & Logic
#### [MODIFY] [lib/main.dart](file:///c:/Users/zelia/toxic_wallet/lib/main.dart)
- **DashboardPage**:
    - Refactor `SlideTransition` to a "peeking" animation (using `Stack` + `Positioned` with `Transform`).
    - Ensure the character appears from the bottom/side as if holding a curtain.
    - Add fallback logic: If image asset fails (or doesn't exist), show a large Emoji or Icon representing the emotion.
- **AnalysisPage**:
    - Implement `Hive` data aggregation.
    - Calculate "This Week" vs "Last Week" spending.
    - Add "Toxic Commentary" based on the trend (e.g., "You spent 20% more, congratulations on your bankruptcy").
    - **NEW**: Add `RealTimeCostTicker` widget.
        - Takes monthly/daily average of a category.
        - Animates a counter increasing every second (kuruş kuruş).

#### [NEW] [lib/ui/widgets/ticker_widget.dart](file:///c:/Users/zelia/toxic_wallet/lib/ui/widgets/ticker_widget.dart)
- Create a reusable `TickerWidget` that accepts a `dailyAmount` and animates the cumulative cost in real-time.

## Verification Plan

### Manual Verification
- **Dashboard**:
    1. Select "Transportation".
    2. Enter a low amount (e.g., 10 TL).
    3. Verify "Taxi Driver" appears (Icon/Placeholder) with "Angry" expression.
    4. Enter a high amount (e.g., 5000 TL).
    5. Verify expression changes to "Happy".
- **Analysis**:
    1. Add a few expenses with different dates (I will add a "Mock Data" button or just use current date).
    2. Go to Analysis tab.
    3. Check if "Weekly Comparison" shows correct percentage.
    4. Check if the "Ticker" is running and incrementing.
