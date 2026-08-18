import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDark;

  const ExperienceSection({super.key, required this.isDark});

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
            tag: 'CAREER & ACADEMICS',
            title: 'Experience & Academic Journey',
            subtitle:
                'Hands-on engineering roles building telematics pipelines, reactive UI architectures, and academic achievements in Computer Science & Engineering.',
          ),
          const SizedBox(height: 36),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Work Experience
                    Expanded(
                      flex: 6,
                      child: _buildWorkExperienceColumn(),
                    ),
                    const SizedBox(width: 40),
                    // Right Column: Education
                    Expanded(
                      flex: 4,
                      child: _buildEducationColumn(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildWorkExperienceColumn(),
                    const SizedBox(height: 40),
                    _buildEducationColumn(),
                  ],
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
            color: const Color(0xFF00F5A0).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF00F5A0).withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.firaCode(
              color: const Color(0xFF00F5A0),
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

  Widget _buildWorkExperienceColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.work_history,
                color: PortfolioTheme.primaryCyan, size: 18),
            const SizedBox(width: 10),
            Text(
              'Commercial Experience',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Experience Cards
        ...PortfolioData.experiences.map((exp) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: PortfolioTheme.glassBoxDecoration(
                isDark: isDark,
                radius: 20,
                borderColor: exp.badgeColor.withValues(alpha: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.role,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              exp.company,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: exp.badgeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          exp.period,
                          style: GoogleFonts.firaCode(
                            fontSize: 10.5,
                            color: isDark
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Highlights
                  ...exp.highlights.map((point) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('▹ ',
                                style: TextStyle(
                                    color: PortfolioTheme.primaryCyan,
                                    fontSize: 14)),
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
                  const SizedBox(height: 12),

                  // Tech badges
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: exp.skills.map((s) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF131B2E)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isDark ? Colors.white10 : Colors.black12,
                          ),
                        ),
                        child: Text(
                          s,
                          style: GoogleFonts.firaCode(
                            fontSize: 11,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF475569),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEducationColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.school,
                color: Color(0xFF7F00FF), size: 18),
            const SizedBox(width: 10),
            Text(
              'Education',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        ...PortfolioData.education.map((edu) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: PortfolioTheme.glassBoxDecoration(
                isDark: isDark,
                radius: 20,
                borderColor: const Color(0xFF7F00FF).withValues(alpha: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              edu.degree,
                              style: GoogleFonts.outfit(
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              edu.institution,
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF7F00FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00F5A0).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          edu.score,
                          style: GoogleFonts.firaCode(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00F5A0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${edu.location} • ${edu.period}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xFF64748B)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    edu.details,
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
