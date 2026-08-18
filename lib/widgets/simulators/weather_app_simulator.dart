import 'package:flutter/material.dart';

class WeatherAppSimulator extends StatefulWidget {
  const WeatherAppSimulator({super.key});

  @override
  State<WeatherAppSimulator> createState() => _WeatherAppSimulatorState();
}

class _WeatherAppSimulatorState extends State<WeatherAppSimulator>
    with SingleTickerProviderStateMixin {
  late AnimationController _skyAnim;

  String _selectedCity = 'Lucknow';
  bool _showBlocLogs = false;

  final Map<String, Map<String, dynamic>> _cityData = {
    'Lucknow': {
      'temp': '31°',
      'condition': 'Scattered Clouds',
      'icon': Icons.wb_cloudy,
      'humidity': '68%',
      'wind': '12 km/h',
      'uv': '7 High',
      'aqi': '84 (Moderate)',
      'sunrise': '05:32 AM',
      'sunset': '06:48 PM',
      'bgGradient': [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
      'hourly': [
        {'time': 'Now', 'temp': '31°', 'icon': Icons.wb_cloudy},
        {'time': '1 PM', 'temp': '33°', 'icon': Icons.wb_sunny},
        {'time': '3 PM', 'temp': '34°', 'icon': Icons.wb_sunny},
        {'time': '5 PM', 'temp': '30°', 'icon': Icons.wb_cloudy},
        {'time': '7 PM', 'temp': '27°', 'icon': Icons.nights_stay},
      ],
    },
    'Tokyo': {
      'temp': '22°',
      'condition': 'Gentle Rain',
      'icon': Icons.water_drop,
      'humidity': '84%',
      'wind': '18 km/h',
      'uv': '3 Low',
      'aqi': '28 (Good)',
      'sunrise': '04:58 AM',
      'sunset': '06:32 PM',
      'bgGradient': [Color(0xFF1F1C2C), Color(0xFF928DAB)],
      'hourly': [
        {'time': 'Now', 'temp': '22°', 'icon': Icons.water_drop},
        {'time': '1 PM', 'temp': '21°', 'icon': Icons.thunderstorm},
        {'time': '3 PM', 'temp': '20°', 'icon': Icons.water_drop},
        {'time': '5 PM', 'temp': '19°', 'icon': Icons.cloud},
        {'time': '7 PM', 'temp': '18°', 'icon': Icons.nights_stay},
      ],
    },
    'San Francisco': {
      'temp': '16°',
      'condition': 'Breezy Fog',
      'icon': Icons.air,
      'humidity': '78%',
      'wind': '24 km/h',
      'uv': '4 Moderate',
      'aqi': '32 (Good)',
      'sunrise': '06:18 AM',
      'sunset': '08:02 PM',
      'bgGradient': [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
      'hourly': [
        {'time': 'Now', 'temp': '16°', 'icon': Icons.air},
        {'time': '1 PM', 'temp': '18°', 'icon': Icons.wb_cloudy},
        {'time': '3 PM', 'temp': '17°', 'icon': Icons.wind_power},
        {'time': '5 PM', 'temp': '15°', 'icon': Icons.cloud},
        {'time': '7 PM', 'temp': '14°', 'icon': Icons.nights_stay},
      ],
    },
    'London': {
      'temp': '19°',
      'condition': 'Overcast',
      'icon': Icons.cloud,
      'humidity': '72%',
      'wind': '15 km/h',
      'uv': '2 Low',
      'aqi': '35 (Good)',
      'sunrise': '05:42 AM',
      'sunset': '08:44 PM',
      'bgGradient': [Color(0xFF232526), Color(0xFF414345)],
      'hourly': [
        {'time': 'Now', 'temp': '19°', 'icon': Icons.cloud},
        {'time': '1 PM', 'temp': '20°', 'icon': Icons.wb_cloudy},
        {'time': '3 PM', 'temp': '21°', 'icon': Icons.water_drop},
        {'time': '5 PM', 'temp': '18°', 'icon': Icons.thunderstorm},
        {'time': '7 PM', 'temp': '16°', 'icon': Icons.nights_stay},
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _skyAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _skyAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _cityData[_selectedCity]!;
    final List<Color> bgGrad = (current['bgGradient'] as List).cast<Color>();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgGrad,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
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
                        color: const Color(0xFF00F5A0).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud,
                        color: Color(0xFF00F5A0),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Aether Weather',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => setState(() => _showBlocLogs = !_showBlocLogs),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _showBlocLogs
                          ? const Color(0xFF7F00FF)
                          : const Color(0xFF1E293B).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF7F00FF).withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.code, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          _showBlocLogs ? 'Hide Bloc' : 'Bloc Logs',
                          style: const TextStyle(
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

          // City Selector Carousel Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: _cityData.keys.map((city) {
                final isSelected = _selectedCity == city;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCity = city),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF00F5A0)
                          : Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00F5A0)
                            : Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Text(
                      city,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Main Body
          Expanded(
            child: _showBlocLogs
                ? _buildBlocInspector()
                : _buildWeatherDashboard(current),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildWeatherDashboard(Map<String, dynamic> current) {
    final IconData icon = current['icon'] as IconData;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          // Main Temperature Hero
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 46,
                  color: const Color(0xFFFFD166),
                ),
                const SizedBox(height: 6),
                Text(
                  current['temp'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w200,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  current['condition'] as String,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$_selectedCity, India/Global',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Metric Badges Grid
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherStat(Icons.water_drop, 'Humidity',
                        current['humidity'] as String),
                    _buildWeatherStat(Icons.air, 'Wind',
                        current['wind'] as String),
                    _buildWeatherStat(Icons.wb_sunny, 'UV Index',
                        current['uv'] as String),
                  ],
                ),
                const Divider(color: Colors.white12, height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherStat(Icons.masks, 'Air Quality',
                        current['aqi'] as String),
                    _buildWeatherStat(Icons.wb_twilight, 'Sunrise',
                        current['sunrise'] as String),
                    _buildWeatherStat(Icons.bedtime, 'Sunset',
                        current['sunset'] as String),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Hourly Forecast Row
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HOURLY FORECAST',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: (current['hourly'] as List).map((hour) {
                    final hIcon = hour['icon'] as IconData;
                    return Column(
                      children: [
                        Text(
                          hour['time'] as String,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 10),
                        ),
                        const SizedBox(height: 4),
                        Icon(hIcon,
                            size: 14, color: const Color(0xFF00F5A0)),
                        const SizedBox(height: 4),
                        Text(
                          hour['temp'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 13, color: const Color(0xFF00F5A0)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBlocInspector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F19),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF7F00FF).withValues(alpha: 0.4)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.terminal, color: Color(0xFF7F00FF), size: 16),
                SizedBox(width: 6),
                Text(
                  'flutter_bloc State Stream',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildBlocLogLine(
                '[Event]', 'FetchWeatherEvent(city: "$_selectedCity")', Colors.cyan),
            _buildBlocLogLine(
                '[Transition]', 'WeatherInitialState → WeatherLoadingState', Colors.amber),
            _buildBlocLogLine(
                '[HTTP]', 'GET https://api.openweathermap.org/v2.5 (200 OK)', Colors.green),
            _buildBlocLogLine(
                '[State]', 'WeatherLoadedState(temp: ${_cityData[_selectedCity]!['temp']}, cached: true)', Colors.purpleAccent),
            const SizedBox(height: 10),
            const Text(
              'Bloc Architecture:',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const Text(
              '• Unidirectional Event-State mapping\n'
              '• Offline SQLite & Hive cache layer\n'
              '• Automated unit test coverage for weather bloc',
              style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 10, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlocLogLine(String tag, String text, Color tagColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontFamily: 'monospace', fontSize: 9.5),
          children: [
            TextSpan(
              text: '$tag ',
              style: TextStyle(color: tagColor, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: text,
              style: const TextStyle(color: Color(0xFFCBD5E1)),
            ),
          ],
        ),
      ),
    );
  }
}
