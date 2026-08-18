import 'package:flutter/material.dart';

class InteractivePhoneFrame extends StatelessWidget {
  final Widget child;
  final String appTitle;
  final Color themeColor;
  final double width;
  final double height;

  const InteractivePhoneFrame({
    super.key,
    required this.child,
    this.appTitle = 'Flutter App',
    this.themeColor = const Color(0xFF00F2FE),
    this.width = 320,
    this.height = 620,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(44),
          border: Border.all(
            color: themeColor.withValues(alpha: 0.4),
            width: 3.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: themeColor.withValues(alpha: 0.2),
              blurRadius: 40,
              spreadRadius: -8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: Stack(
            children: [
              // Screen Body
              Positioned.fill(
                child: child,
              ),

              // Dynamic Island / Phone Notch
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.black.withValues(alpha: 0.35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '9:41',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Pill island
                      Container(
                        width: 76,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E293B),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: themeColor.withValues(alpha: 0.8),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.wifi, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Icon(Icons.battery_full, size: 12, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Home Indicator Bar
              Positioned(
                bottom: 6,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
