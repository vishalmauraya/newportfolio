import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class HeroSection extends StatefulWidget {
  final bool isDark;
  final VoidCallback onExploreProjects;
  final VoidCallback onContactMe;
  final VoidCallback onOpenResume;

  const HeroSection({
    super.key,
    required this.isDark,
    required this.onExploreProjects,
    required this.onContactMe,
    required this.onOpenResume,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);
    final horizontalPad = ResponsiveBreakpoints.contentPadding(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Ambient Particle & Glowing Canvas
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return CustomPaint(
                painter: AmbientGlowPainter(
                  progress: _particleController.value,
                  isDark: widget.isDark,
                ),
              );
            },
          ),
        ),

        // Main Hero Content
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPad,
            vertical: isDesktop ? 70 : 40,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Column: Headline & CTA
                    Expanded(
                      flex: 6,
                      child: _buildHeroText(isDesktop),
                    ),
                    const SizedBox(width: 40),
                    // Right Column: Interactive Profile Card & Floating Badges
                    Expanded(
                      flex: 5,
                      child: _buildFloatingVisual(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildHeroText(isDesktop),
                    const SizedBox(height: 40),
                    _buildFloatingVisual(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildHeroText(bool isDesktop) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Availability Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: widget.isDark
                ? const Color(0xFF00F5A0).withValues(alpha: 0.12)
                : const Color(0xFF00F5A0).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF00F5A0).withValues(alpha: 0.5),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
              Text(
                'Available for Software Engineering Roles',
                style: GoogleFonts.inter(
                  color: const Color(0xFF00F5A0),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Name & Dynamic Headline
        RichText(
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 54 : 36,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1.1,
              color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
            ),
            children: [
              const TextSpan(text: 'Hi, I’m '),
              TextSpan(
                text: PortfolioData.name,
                style: const TextStyle(
                  color: PortfolioTheme.primaryCyan,
                ),
              ),
              const TextSpan(text: '\nCrafting '),
              TextSpan(
                text: 'Pixel-Perfect\n',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        PortfolioTheme.primaryCyan,
                        PortfolioTheme.accentViolet,
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 400, 70)),
                ),
              ),
              const TextSpan(text: 'Flutter Experiences.'),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Summary Text
        Text(
          PortfolioData.tagline,
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 16 : 14,
            color: widget.isDark
                ? const Color(0xFF94A3B8)
                : const Color(0xFF475569),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),

        // CTA Buttons
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: widget.onExploreProjects,
              icon: const Icon(Icons.rocket_launch, size: 15),
              label: const Text('Explore Apps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PortfolioTheme.primaryCyan,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                textStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 8,
                shadowColor: PortfolioTheme.primaryCyan.withValues(alpha: 0.5),
              ),
            ),
            OutlinedButton.icon(
              onPressed: widget.onContactMe,
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Let’s Connect'),
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    widget.isDark ? Colors.white : const Color(0xFF0F172A),
                side: BorderSide(
                  color: widget.isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFCBD5E1),
                  width: 1.5,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                textStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Quick Social Links
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _buildSocialIcon(Icons.code, PortfolioData.github),
            _buildSocialIcon(Icons.business_center, PortfolioData.linkedin),
            _buildSocialIcon(Icons.chat, PortfolioData.whatsapp),
            _buildSocialIcon(
                Icons.email_outlined, 'mailto:${PortfolioData.email}'),
          ],
        ),
      ],
    );
  }

  Widget _buildFloatingVisual() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final floatOffset = sin(_floatController.value * 2 * pi) * 10;
        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Glowing Glass Backdrop Card
              Container(
                width: 360,
                padding: const EdgeInsets.all(22),
                decoration: PortfolioTheme.glassBoxDecoration(
                  isDark: widget.isDark,
                  radius: 28,
                  hasGlow: true,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Avatar / Badge
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: PortfolioTheme.violetGradient,
                        boxShadow: [
                          BoxShadow(
                            color: PortfolioTheme.accentViolet.withValues(alpha: 0.5),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.flutter_dash,
                        color: Colors.white,
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Vishal Kumar',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: widget.isDark
                            ? Colors.white
                            : const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Flutter Developer • Mobile Engineer',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: PortfolioTheme.primaryCyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            PortfolioData.location,
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: const Color(0xFF94A3B8),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFF1E293B)),
                    const SizedBox(height: 10),

                    // Quick Chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildTechChip('Riverpod', const Color(0xFF00F5A0)),
                        _buildTechChip('Bloc Pattern', const Color(0xFF7F00FF)),
                        _buildTechChip('Firebase', const Color(0xFFFFB300)),
                        _buildTechChip('Sensor Streams', const Color(0xFF00F2FE)),
                        _buildTechChip('Stripe Payments', const Color(0xFF635BFF)),
                      ],
                    ),
                  ],
                ),
              ),

              // Floating Badge 1 (Riverpod)
              Positioned(
                top: -12,
                left: -10,
                child: _buildFloatingBadge(
                  icon: Icons.account_tree,
                  label: 'Riverpod 2.0',
                  color: const Color(0xFF00F5A0),
                ),
              ),

              // Floating Badge 2 (60 FPS UI)
              Positioned(
                bottom: -12,
                right: -10,
                child: _buildFloatingBadge(
                  icon: Icons.bolt,
                  label: '60 FPS UI',
                  color: const Color(0xFF00F2FE),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          fontSize: 10.5,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: widget.isDark
              ? const Color(0xFF1E293B)
              : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: widget.isDark ? Colors.white70 : const Color(0xFF334155),
        ),
      ),
    );
  }
}

class AmbientGlowPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  AmbientGlowPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    if (!isDark) return;

    // Ambient radial glow top left
    final glowPaint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          PortfolioTheme.primaryCyan.withValues(alpha: 0.12),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.2, size.height * 0.3),
          radius: size.width * 0.35,
        ),
      );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      size.width * 0.35,
      glowPaint1,
    );

    // Ambient radial glow top right
    final glowPaint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          PortfolioTheme.accentViolet.withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.8, size.height * 0.4),
          radius: size.width * 0.4,
        ),
      );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      size.width * 0.4,
      glowPaint2,
    );
  }

  @override
  bool shouldRepaint(covariant AmbientGlowPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}
