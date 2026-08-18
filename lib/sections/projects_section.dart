import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';
import '../widgets/project_modal.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDark;

  const ProjectsSection({super.key, required this.isDark});

  void _openProjectModal(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPad = ResponsiveBreakpoints.contentPadding(context);
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isDesktop ? 60 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildSectionHeader(
            tag: 'FEATURED PORTFOLIO',
            title: 'Flagship Production Projects',
            subtitle:
                'Explore full-scale applications developed with Flutter, Riverpod, Bloc, WebSockets, real-time sensor streams, and cloud APIs. Click "Launch Live Simulator" to test the apps directly in your browser!',
          ),
          const SizedBox(height: 36),

          // Projects List Cards
          Column(
            children: PortfolioData.projects.map((project) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: _buildProjectShowcaseCard(context, project, isDesktop),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String tag,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF7F00FF).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF7F00FF).withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.firaCode(
              color: const Color(0xFFE100FF),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14.5,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectShowcaseCard(
      BuildContext context, ProjectModel project, bool isDesktop) {
    return Container(
      decoration: PortfolioTheme.glassBoxDecoration(
        isDark: isDark,
        radius: 24,
        borderColor: project.themeColor.withValues(alpha: 0.35),
        hasGlow: true,
      ),
      padding: const EdgeInsets.all(24),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Info & Tech
                Expanded(
                  flex: 3,
                  child: _buildProjectInfo(context, project),
                ),
                const SizedBox(width: 24),
                // Right: Interactive Preview & Launch Card
                Expanded(
                  flex: 2,
                  child: _buildProjectPreviewBox(context, project),
                ),
              ],
            )
          : Column(
              children: [
                _buildProjectInfo(context, project),
                const SizedBox(height: 20),
                _buildProjectPreviewBox(context, project),
              ],
            ),
    );
  }

  Widget _buildProjectInfo(BuildContext context, ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header info with wrap/expanded protection
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.outfit(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    project.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: project.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                project.timeframe,
                style: GoogleFonts.firaCode(
                  fontSize: 10.5,
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Description
        Text(
          project.description,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 14),

        // Bullet Highlights
        ...project.bulletPoints.take(2).map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline,
                      color: project.themeColor, size: 15),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),

        // Tech Stack Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF131B2E)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                ),
              ),
              child: Text(
                tech,
                style: GoogleFonts.firaCode(
                  fontSize: 11.5,
                  color: isDark
                      ? const Color(0xFFCBD5E1)
                      : const Color(0xFF334155),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openProjectModal(context, project),
              icon: const Icon(Icons.play_circle_fill, size: 16),
              label: const Text('Launch Live Simulator'),
              style: ElevatedButton.styleFrom(
                backgroundColor: project.themeColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                textStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse(project.githubUrl)),
              icon: const Icon(Icons.code, size: 16),
              label: const Text('GitHub'),
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? Colors.white : Colors.black,
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFCBD5E1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectPreviewBox(BuildContext context, ProjectModel project) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1523) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: project.themeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LIVE TELEMETRY & SPECS',
                style: GoogleFonts.firaCode(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: project.themeColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF00F5A0).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'INTERACTIVE',
                  style: TextStyle(
                    color: Color(0xFF00F5A0),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dynamic Metrics
          ...project.metrics.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    entry.value.toString(),
                    style: GoogleFonts.firaCode(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),

          // Clickable Simulator Trigger Banner
          InkWell(
            onTap: () => _openProjectModal(context, project),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    project.themeColor.withValues(alpha: 0.2),
                    project.themeColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: project.themeColor.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, size: 16, color: project.themeColor),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Launch Interactive Simulator',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
