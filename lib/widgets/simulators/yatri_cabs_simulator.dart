import 'dart:async';
import 'package:flutter/material.dart';

class YatriCabsSimulator extends StatefulWidget {
  const YatriCabsSimulator({super.key});

  @override
  State<YatriCabsSimulator> createState() => _YatriCabsSimulatorState();
}

class _YatriCabsSimulatorState extends State<YatriCabsSimulator>
    with SingleTickerProviderStateMixin {
  late AnimationController _carAnim;
  int _roleIndex = 0; // 0: Rider View, 1: Driver Partner View
  String _selectedCab = 'Sedan';
  String _status = 'IDLE'; // IDLE, SEARCHING, ACCEPTED, ON_TRIP, COMPLETED
  String? _fcmNotification;
  Timer? _notificationTimer;

  final List<Map<String, dynamic>> _cabTiers = [
    {
      'name': 'Sedan',
      'fare': '₹ 280',
      'eta': '3 min',
      'icon': Icons.directions_car,
    },
    {
      'name': 'Prime SUV',
      'fare': '₹ 420',
      'eta': '5 min',
      'icon': Icons.airport_shuttle,
    },
    {
      'name': 'Auto',
      'fare': '₹ 140',
      'eta': '2 min',
      'icon': Icons.electric_rickshaw,
    },
  ];

  @override
  void initState() {
    super.initState();
    _carAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _carAnim.dispose();
    _notificationTimer?.cancel();
    super.dispose();
  }

  void _triggerFCM(String message) {
    setState(() => _fcmNotification = message);
    _notificationTimer?.cancel();
    _notificationTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _fcmNotification = null);
    });
  }

  void _startRideFlow() {
    setState(() => _status = 'SEARCHING');
    _triggerFCM('🔍 Searching nearby drivers on WebSocket...');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _status = 'ACCEPTED');
      _triggerFCM('🎉 Driver Assigned: Ramesh K. (White Honda City - UP32-AB-9821)');
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _status = 'ON_TRIP');
      _triggerFCM('🚀 Trip Started! Route live-synchronized.');
    });
  }

  void _resetRide() {
    setState(() {
      _status = 'IDLE';
      _fcmNotification = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1117),
      child: Column(
        children: [
          const SizedBox(height: 38),
          // App Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB300).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_taxi,
                        color: Color(0xFFFFB300),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Yatri Cabs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Role Switcher Pill
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B22),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildRolePill('Rider', 0),
                      _buildRolePill('Driver', 1),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Simulated FCM Banner
          if (_fcmNotification != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFFB300), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFB300).withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active,
                      color: Color(0xFFFFB300), size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _fcmNotification!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          // Map & Live Track Canvas
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _carAnim,
                  builder: (context, child) {
                    return CustomPaint(
                      size: const Size(double.infinity, double.infinity),
                      painter: YatriMapPainter(
                        progress: _carAnim.value,
                        status: _status,
                        isDriver: _roleIndex == 1,
                      ),
                    );
                  },
                ),

                // Destination Card Overlay
                Positioned(
                  top: 10,
                  left: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161B22).withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00F5A0),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Pick: Lucknow Charbagh Railway Station',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF4B72),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Drop: Chaudhary Charan Singh Airport (LKO)',
                              style: TextStyle(
                                color: Color(0xFFCBD5E1),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Ride Details / Booking Area
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF161B22),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                top: BorderSide(color: Color(0xFF30363D), width: 1),
              ),
            ),
            child: _roleIndex == 0 ? _buildRiderControls() : _buildDriverControls(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRolePill(String title, int index) {
    final isSelected = _roleIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _roleIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFB300) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : const Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRiderControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cab options selector
        Row(
          children: _cabTiers.map((cab) {
            final isSelected = _selectedCab == cab['name'];
            final icon = cab['icon'] as IconData;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedCab = cab['name']),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFFB300).withValues(alpha: 0.2)
                        : const Color(0xFF0D1117),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFFB300)
                          : const Color(0xFF30363D),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(icon,
                          size: 14,
                          color: isSelected
                              ? const Color(0xFFFFB300)
                              : Colors.white70),
                      const SizedBox(height: 3),
                      Text(
                        cab['name'] as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Text(
                        cab['fare'] as String,
                        style: const TextStyle(
                          color: Color(0xFFFFB300),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),

        // Action Button
        if (_status == 'IDLE')
          ElevatedButton(
            onPressed: _startRideFlow,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB300),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Book $_selectedCab (Live Demo)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F5A0).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Status: $_status',
                    style: const TextStyle(
                      color: Color(0xFF00F5A0),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: _resetRide,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Color(0xFF30363D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Reset', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDriverControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Driver Partner Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              'Today: ₹ 2,450',
              style: TextStyle(
                color: Color(0xFF00F5A0),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Socket Connection: Connected to Lucknow Central Node (MongoDB Live)',
          style: TextStyle(color: Color(0xFF8B949E), fontSize: 9),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _triggerFCM('🔔 New Ride Request: Airport → ₹ 420'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF238636),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Simulate Incoming Ride Request',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class YatriMapPainter extends CustomPainter {
  final double progress;
  final String status;
  final bool isDriver;

  YatriMapPainter({
    required this.progress,
    required this.status,
    required this.isDriver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF0D1117);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final roadPaint = Paint()
      ..color = const Color(0xFF21262D)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final roadCenter = Paint()
      ..color = const Color(0xFF30363D)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Curved City Route
    final route = Path();
    route.moveTo(30, size.height * 0.3);
    route.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.35,
      size.width * 0.5,
      size.height * 0.65,
    );
    route.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.85,
      size.width - 40,
      size.height * 0.8,
    );

    canvas.drawPath(route, roadPaint);
    canvas.drawPath(route, roadCenter);

    // Active Route Polyline
    final activePaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawPath(route, activePaint);

    // Car Position along route
    final metrics = route.computeMetrics().first;
    final carPos =
        metrics.getTangentForOffset(metrics.length * progress)?.position ??
            Offset(size.width / 2, size.height / 2);

    // Draw Pin at Start
    final startPin = Paint()..color = const Color(0xFF00F5A0);
    canvas.drawCircle(const Offset(30, 40), 6, startPin);

    // Draw Pin at End
    final endPin = Paint()..color = const Color(0xFFFF4B72);
    canvas.drawCircle(Offset(size.width - 40, size.height * 0.8), 6, endPin);

    // Draw Moving Car
    final carGlow = Paint()
      ..color = const Color(0xFFFFB300).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(carPos, 12, carGlow);

    final carMarker = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(carPos, 5, carMarker);
  }

  @override
  bool shouldRepaint(covariant YatriMapPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.status != status ||
      oldDelegate.isDriver != isDriver;
}
