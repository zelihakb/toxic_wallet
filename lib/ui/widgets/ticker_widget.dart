import 'dart:async';
import 'package:flutter/material.dart';

class TickerWidget extends StatefulWidget {
  final double monthlyAmount;
  final String currency;
  final String label;

  const TickerWidget({
    super.key,
    required this.monthlyAmount,
    required this.currency,
    required this.label,
  });

  @override
  State<TickerWidget> createState() => _TickerWidgetState();
}

class _TickerWidgetState extends State<TickerWidget> {
  late Timer _timer;
  double _currentAmount = 0.0;
  double _costPerSecond = 0.0;
  final int _updateIntervalMs = 100; // Update every 100ms for smoothness

  @override
  void initState() {
    super.initState();
    _calculateCostPerSecond();
    _startTimer();
  }

  @override
  void didUpdateWidget(TickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.monthlyAmount != widget.monthlyAmount) {
      _calculateCostPerSecond();
    }
  }

  void _calculateCostPerSecond() {
    // Monthly amount / 30 days / 24 hours / 60 minutes / 60 seconds
    _costPerSecond = widget.monthlyAmount / (30 * 24 * 60 * 60);
    
    // Start from a calculated offset based on current time of day to make it look "live"
    // or just start from 0 for the "sensation" of watching it burn.
    // Let's start from 0 to emphasize the "burning" feeling as requested.
    _currentAmount = 0.0; 
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: _updateIntervalMs), (timer) {
      setState(() {
        // Add the cost for this interval
        _currentAmount += _costPerSecond * (_updateIntervalMs / 1000);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _currentAmount.toStringAsFixed(4), // Show 4 decimal places for "kuruş kuruş" effect
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier', // Monospaced font looks more "digital/ticker"
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 4),
                child: Text(
                  widget.currency,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Saniyede eriyor...",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
