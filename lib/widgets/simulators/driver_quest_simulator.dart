import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DriverQuestSimulator extends StatefulWidget {
  const DriverQuestSimulator({super.key});

  @override
  State<DriverQuestSimulator> createState() => _DriverQuestSimulatorState();
}

class _DriverQuestSimulatorState extends State<DriverQuestSimulator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  Timer? _telemetryTimer;

  double _speed = 54.0;
  double _score = 96.0;
  double _gForce = 0.22;
  double _gyro = 0.08;
  int _tabIndex = 0; // 0: Live Telematics, 1: Sensor Stream, 2: Stripe Billing
  bool _isRecording = true;
  bool _isPaymentSuccess = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _telemetryTimer =
        Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!mounted || !_isRecording) return;
      final rand = Random();
      setState(() {
        _speed = (50 + rand.nextDouble() * 18).clamp(40, 75);
        _gForce = (0.18 + rand.nextDouble() * 0.15);
        _gyro = (rand.nextDouble() * 0.2);
        _score = (94 + rand.nextDouble() * 5).clamp(90, 100);
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _telemetryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF090D16),
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
                        color: const Color(0xFF00F2FE).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.drive_eta,
                        color: Color(0xFF00F2FE),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Driver Quest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _isRecording
                        ? const Color(0xFF00F5A0).withValues(alpha: 0.15)
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isRecording
                          ? const Color(0xFF00F5A0)
                          : Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _isRecording
                              ? const Color(0xFF00F5A0)
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isRecording ? 'LIVE STREAM' : 'PAUSED',
                        style: TextStyle(
                          color: _isRecording
                              ? const Color(0xFF00F5A0)
                              : Colors.grey,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Segmented Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTabButton('Telematics', 0),
                _buildTabButton('Sensors', 1),
                _buildTabButton('Stripe Pay', 2),
              ],
            ),
          ),

          // Main View Content
          Expanded(
            child: _tabIndex == 0
                ? _buildTelematicsView()
                : _tabIndex == 1
                    ? _buildSensorsView()
                    : _buildStripeView(),
          ),

          // Bottom Bar Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF101626),
              border: Border(
                top: BorderSide(color: Color(0xFF1E293B), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isRecording = !_isRecording);
                  },
                  icon: Icon(
                    _isRecording ? Icons.pause : Icons.play_arrow,
                    size: 14,
                  ),
                  label: Text(_isRecording ? 'Pause Trip' : 'Resume Trip'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording
                        ? const Color(0xFFE76F51)
                        : const Color(0xFF00F5A0),
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    textStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Score: ${_score.toStringAsFixed(0)}/100',
                  style: const TextStyle(
                    color: Color(0xFF00F2FE),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _tabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00F2FE) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : const Color(0xFF94A3B8),
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTelematicsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          // Live Map Area with Animated Polyline
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF00F2FE).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Animated Map Grid & Route
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(double.infinity, 140),
                        painter: TelematicsMapPainter(
                          progress: _animController.value,
                        ),
                      );
                    },
                  ),
                  // Map Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.navigation,
                              size: 10, color: Color(0xFF00F2FE)),
                          SizedBox(width: 4),
                          Text(
                            'Hazratganj → Gomti Nagar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Speed and Score Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B2E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CURRENT SPEED',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _speed.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'km/h',
                            style: TextStyle(
                              color: Color(0xFF00F2FE),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B2E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SAFETY RATING',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _score.toStringAsFixed(0),
                            style: const TextStyle(
                              color: Color(0xFF00F5A0),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            '/100',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 10,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.verified,
                            color: Color(0xFF00F5A0),
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Driver Behavior Indicators
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BEHAVIOR BREAKDOWN',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildMetricBar(
                    'Smooth Acceleration', 0.94, const Color(0xFF00F5A0)),
                const SizedBox(height: 6),
                _buildMetricBar(
                    'Cornering G-Force', 0.88, const Color(0xFF00F2FE)),
                const SizedBox(height: 6),
                _buildMetricBar(
                    'Braking Regularity', 0.96, const Color(0xFF7F00FF)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSensorsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF00F2FE).withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.sensors, color: Color(0xFF00F2FE), size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Live Device Sensors (Stream)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildSensorRow('Accelerometer (X, Y, Z)',
                    '0.04g, 0.12g, ${_gForce.toStringAsFixed(2)}g'),
                const Divider(color: Color(0xFF1E293B)),
                _buildSensorRow('Gyroscope (Yaw/Pitch)',
                    '${_gyro.toStringAsFixed(3)} rad/s (Stable)'),
                const Divider(color: Color(0xFF1E293B)),
                _buildSensorRow('GPS Lat / Lng', '26.8467° N, 80.9462° E'),
                const Divider(color: Color(0xFF1E293B)),
                _buildSensorRow('Sampling Frequency', '50 Hz (Dart Stream)'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ALGORITHM METRIC',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '• Smooth curve polyline matching against Google Road API\n'
                  '• Anomaly filter ignores phone pocket vibrations\n'
                  '• Automatic trip start/stop background trigger',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStripeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF635BFF), Color(0xFF00D4FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stripe Checkout Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Icon(Icons.payment, color: Colors.white, size: 24),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Driver Pro Membership',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Includes unlimited driving telemetry & insurance audit certificate',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '₹ 499 / month',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (_isPaymentSuccess)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF00F5A0).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00F5A0)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF00F5A0), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Payment Verified! Driver Quest Pro Active.',
                      style: TextStyle(
                        color: Color(0xFF00F5A0),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ElevatedButton(
              onPressed: () {
                setState(() => _isPaymentSuccess = true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF635BFF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Simulate 1-Click Payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSensorRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF00F2FE),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 10),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: const Color(0xFF1E293B),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

class TelematicsMapPainter extends CustomPainter {
  final double progress;

  TelematicsMapPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B).withValues(alpha: 0.5)
      ..strokeWidth = 0.8;

    // Grid lines
    for (double i = 0; i < size.width; i += 24) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double j = 0; j < size.height; j += 24) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), gridPaint);
    }

    // Path
    final path = Path();
    path.moveTo(20, size.height * 0.8);
    path.cubicTo(
      size.width * 0.3,
      size.height * 0.2,
      size.width * 0.6,
      size.height * 0.9,
      size.width - 30,
      size.height * 0.3,
    );

    // Glowing Polyline
    final glowPaint = Paint()
      ..color = const Color(0xFF00F2FE).withValues(alpha: 0.3)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, glowPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF00F2FE)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);

    // Animated Car Marker along path
    final pathMetrics = path.computeMetrics().first;
    final markerOffset =
        pathMetrics.getTangentForOffset(pathMetrics.length * progress)?.position ??
            Offset(size.width / 2, size.height / 2);

    final carGlow = Paint()
      ..color = const Color(0xFF00F5A0).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(markerOffset, 10, carGlow);

    final carPaint = Paint()
      ..color = const Color(0xFF00F5A0)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(markerOffset, 4, carPaint);
  }

  @override
  bool shouldRepaint(covariant TelematicsMapPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
