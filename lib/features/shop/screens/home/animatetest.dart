import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class animatedtest extends StatefulWidget {
  @override
  _animatedtestState createState() => _animatedtestState();
}

class _animatedtestState extends State<animatedtest> {
  bool _isSnackbarVisible = false;

  // Function to toggle Snackbar visibility
  void toggleSnackbar() {
    setState(() {
      _isSnackbarVisible = true;
    });

    // Automatically hide the Snackbar after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isSnackbarVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Snackbar'),
      ),
      body: Stack(
        children: [
          // Main content with a button
          Center(
            child: ElevatedButton(
              onPressed: toggleSnackbar,
              child: const Text('Show Snackbar'),
            ),
          ),

          // Custom Snackbar animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            bottom: _isSnackbarVisible
                ? 20
                : -100, // Animate from outside screen to bottom
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _isSnackbarVisible ? 1 : 0, // Fade in/out animation
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 90.w, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'wishlist Removed!',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
