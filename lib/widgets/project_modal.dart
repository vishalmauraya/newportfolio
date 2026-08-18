import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import 'interactive_phone_frame.dart';
import 'simulators/driver_quest_simulator.dart';
import 'simulators/yatri_cabs_simulator.dart';
import 'simulators/weather_app_simulator.dart';

class ProjectDetailModal extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 960;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        width: isDesktop ? 1000 : size.width * 0.95,
        height: size.height * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xFF0B0F19),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: project.themeColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: project.themeColor.withValues(alpha: 0.2),
              blurRadius: 35,
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 40,
            ),
          ],
        ),
        child: Column(
          children: [
            // Modal Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFF121829),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFF1E293B), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: project.themeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(project.icon,
                            color: project.themeColor, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            project.timeframe,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF94A3B8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white70, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Modal Body
            Expanded(
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Deep-Dive Technical Case Study
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: _buildDetailsContent(context),
                          ),
                        ),
                        // Divider
                        Container(
                          width: 1,
                          color: const Color(0xFF1E293B),
                        ),
                        // Right: Live Interactive Simulator
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: const Color(0xFF080C14),
                            alignment: Alignment.center,
                            child: _buildLiveSimulator(),
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildDetailsContent(context),
                          const SizedBox(height: 20),
                          const Divider(color: Color(0xFF1E293B)),
                          const SizedBox(height: 10),
                          Text(
                            '📱 LIVE INTERACTIVE DEMO',
                            style: GoogleFonts.outfit(
                              color: project.themeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _buildLiveSimulator(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.subtitle,
          style: GoogleFonts.outfit(
            color: project.themeColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project.description,
          style: GoogleFonts.inter(
            color: const Color(0xFFCBD5E1),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),

        // Key Engineering Highlights
        Text(
          'Engineering Architecture & Highlights',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...project.bulletPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline,
                      color: project.themeColor, size: 16),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF94A3B8),
                        fontSize: 13.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 20),

        // Tech Stack Chips
        Text(
          'Tech Stack & Integrations',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: project.themeColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                tech,
                style: GoogleFonts.firaCode(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse(project.githubUrl)),
              icon: const Icon(Icons.code, size: 16),
              label: const Text('View on GitHub'),
              style: ElevatedButton.styleFrom(
                backgroundColor: project.themeColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse(PortfolioData.whatsapp)),
              icon: const Icon(Icons.chat, size: 16),
              label: const Text('Discuss Project'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF334155)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveSimulator() {
    Widget simWidget;
    if (project.id == 'driver_quest') {
      simWidget = const DriverQuestSimulator();
    } else if (project.id == 'yatri_cabs') {
      simWidget = const YatriCabsSimulator();
    } else {
      simWidget = const WeatherAppSimulator();
    }

    return InteractivePhoneFrame(
      themeColor: project.themeColor,
      width: 290,
      height: 560,
      child: simWidget,
    );
  }
}
