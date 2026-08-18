import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';

class ResumeDialog extends StatelessWidget {
  const ResumeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 768;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 40,
        vertical: 24,
      ),
      child: Container(
        width: isCompact ? size.width * 0.95 : 850,
        height: size.height * 0.88,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF00F2FE).withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Modal Top Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(19),
                  topRight: Radius.circular(19),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.picture_as_pdf,
                          color: Color(0xFFFF4B72), size: 18),
                      const SizedBox(width: 10),
                      Text(
                        'Vishal_Kumar_Resume.pdf',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Clipboard.setData(
                            const ClipboardData(
                              text:
                                  'Vishal Kumar - Flutter Developer\nmaurayavishal47@gmail.com | +91 92649 24169\nGitHub: https://github.com/vishalmauraya\nLinkedIn: https://linkedin.com/in/vishal-kumar-600438257',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Resume info copied to clipboard!'),
                              backgroundColor: Color(0xFF00F5A0),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 14),
                        label: const Text('Copy Info'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF334155),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          textStyle: const TextStyle(fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(PortfolioData.whatsapp));
                        },
                        icon: const Icon(Icons.chat, size: 14),
                        label: const Text('Request PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Resume Document Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isCompact ? 16 : 32),
                child: Container(
                  padding: EdgeInsets.all(isCompact ? 16 : 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Vishal Kumar',
                              style: GoogleFonts.outfit(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '+91 92649 24169  |  maurayavishal47@gmail.com  |  linkedin.com/in/vishal-kumar-600438257  |  github.com/vishalmauraya',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                color: const Color(0xFF475569),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Lucknow, Uttar Pradesh, India',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Divider(color: Color(0xFFCBD5E1), thickness: 1.5),

                      // Professional Summary
                      _buildSectionTitle('PROFESSIONAL SUMMARY'),
                      Text(
                        'Flutter Developer with 1+ years of experience in Flutter and Firebase, specializing in creating pixel-perfect UIs and optimizing applications for better performance across multiple platforms.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Technical Skills
                      _buildSectionTitle('TECHNICAL SKILLS'),
                      _buildSkillRow('Languages', 'Dart, Java, JavaScript, C++, Python'),
                      _buildSkillRow('Frameworks/Libraries', 'Flutter, Riverpod, Provider, Getx, Firebase, Bootstrap CSS'),
                      _buildSkillRow('Databases', 'MySQL, MongoDB, Firebase DB'),
                      _buildSkillRow('Tools', 'Git, GitHub, Linux'),
                      _buildSkillRow('IDEs', 'Android Studio, VS Code, Eclipse, Xcode'),
                      const SizedBox(height: 14),

                      // Experience
                      _buildSectionTitle('PROFESSIONAL EXPERIENCE'),
                      _buildExperienceBlock(
                        role: 'Flutter Developer',
                        company: 'The MetroMax Group',
                        location: 'Remote',
                        period: 'Oct 2025 – Jun 2026',
                        points: [
                          'Developed and built Logics for Drive Safe application.',
                          'Collaborated with cross-functional teams for feature rollouts and realtime screen update using stream and background sensors monitoring.',
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildExperienceBlock(
                        role: 'Flutter Developer',
                        company: 'Aarsaar Technologies Pvt. Ltd.',
                        location: 'Remote',
                        period: 'Dec 2024 – Sept 2025',
                        points: [
                          'Developed dynamic UI screens and integrated backend REST APIs in Flutter.',
                          'Collaborated with cross-functional teams for feature rollouts.',
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Projects
                      _buildSectionTitle('PROJECTS'),
                      _buildProjectBlock(
                        title: 'Driver Quest – Flutter + RiverPod + Stripe Payment',
                        period: 'Oct, 2025 - June, 2026',
                        points: [
                          'Monitoring Driver driving behavior.',
                          'Realtime monitoring of driving skills using google map api and sensor data.',
                          'Handling sensors data using stream and handling polyline and calculating driver score.',
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildProjectBlock(
                        title: 'Yatri Cabs App',
                        period: 'Dec, 2024 - Oct, 2024',
                        points: [
                          'Built ride-sharing app using Flutter, Riverpod, REST APIs, and MongoDB.',
                          'Developed both user and driver apps with custom styling and dark mode UI.',
                          'Integrated real-time notification (FCM) and socket-based live updates.',
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildProjectBlock(
                        title: 'Weather App – Flutter + Bloc + API',
                        period: '2025',
                        points: [
                          'Displayed real-time weather, temperature, and humidity using live APIs.',
                          'Included sunrise/sunset details and animated icons for a polished UI.',
                          'Adaptive design with location-aware forecasts.',
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Education
                      _buildSectionTitle('EDUCATION'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Central University of Haryana',
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Mahendragarh, India | 2021 – 2025',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Bachelor of Technology - Computer Science & Engineering (74.4%)',
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          color: const Color(0xFF334155),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lucknow Public College (Class XII)',
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Lucknow, India | 2020 – 2021',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'U.P. Board - 89.6%',
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          color: const Color(0xFF334155),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        const Divider(color: Color(0xFF0F172A), thickness: 1),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSkillRow(String category, String skills) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFF334155)),
          children: [
            TextSpan(
              text: '$category: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: skills),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceBlock({
    required String role,
    required String company,
    required String location,
    required String period,
    required List<String> points,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              company,
              style: GoogleFonts.inter(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              '$location | $period',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Text(
          role,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            color: const Color(0xFF2563EB),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 2),
        ...points.map((p) => Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(color: Color(0xFF334155), fontSize: 11.5)),
                  Expanded(
                    child: Text(
                      p,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildProjectBlock({
    required String title,
    required String period,
    required List<String> points,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              period,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        ...points.map((p) => Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(color: Color(0xFF334155), fontSize: 11.5)),
                  Expanded(
                    child: Text(
                      p,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
