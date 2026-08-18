import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/portfolio_theme.dart';

class PortfolioNavBar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenTerminal;
  final VoidCallback onOpenResume;
  final Function(int) onNavigateToSection;
  final int activeSection;

  const PortfolioNavBar({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onOpenTerminal,
    required this.onOpenResume,
    required this.onNavigateToSection,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 1020;
    final isVerySmall = screenWidth < 480;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isVerySmall ? 12 : (isCompact ? 20 : 50),
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0A0E1A).withValues(alpha: 0.88)
            : Colors.white.withValues(alpha: 0.88),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          GestureDetector(
            onTap: () => onNavigateToSection(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: PortfolioTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: PortfolioTheme.primaryCyan.withValues(alpha: 0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'VK',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Vishal Kumar',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00F5A0),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Flutter Specialist',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: PortfolioTheme.primaryCyan,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Desktop Nav Links
          if (!isCompact)
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavLink('About', 0),
                    _buildNavLink('Skills', 1),
                    _buildNavLink('Projects', 2),
                    _buildNavLink('Experience', 3),
                    _buildNavLink('Education', 4),
                    _buildNavLink('Contact', 5),
                  ],
                ),
              ),
            ),

          // Right Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DevTools Terminal Button
              Tooltip(
                message: 'Open DevTools Terminal (CLI)',
                child: IconButton(
                  onPressed: onOpenTerminal,
                  icon: const Icon(
                    Icons.terminal,
                    size: 17,
                  ),
                  color: PortfolioTheme.primaryCyan,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              const SizedBox(width: 6),

              // Theme Switcher
              Tooltip(
                message: isDark ? 'Switch to Light Mode' : 'Switch to Cyber Dark',
                child: IconButton(
                  onPressed: onToggleTheme,
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    size: 17,
                  ),
                  color: isDark ? const Color(0xFFFFD166) : const Color(0xFF1E293B),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              const SizedBox(width: 6),

              // Resume Action
              if (!isVerySmall)
                ElevatedButton.icon(
                  onPressed: onOpenResume,
                  icon: const Icon(Icons.description, size: 13),
                  label: const Text('Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PortfolioTheme.primaryCyan,
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

              // Mobile Menu Button
              if (isCompact) ...[
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.menu, size: 20),
                  color: isDark ? Colors.white : Colors.black,
                  onPressed: () => _showMobileDrawer(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String label, int index) {
    final isActive = activeSection == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => onNavigateToSection(index),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive
                      ? PortfolioTheme.primaryCyan
                      : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 2,
                width: isActive ? 18 : 0,
                decoration: BoxDecoration(
                  color: PortfolioTheme.primaryCyan,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _buildMobileNavItem(context, 'About & Overview', 0, Icons.person),
              _buildMobileNavItem(context, 'Technical Skills', 1, Icons.code),
              _buildMobileNavItem(
                  context, 'Featured Projects', 2, Icons.folder_special),
              _buildMobileNavItem(
                  context, 'Work Experience', 3, Icons.work_history),
              _buildMobileNavItem(context, 'Education', 4, Icons.school),
              _buildMobileNavItem(context, 'Contact Me', 5, Icons.mail),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileNavItem(
      BuildContext context, String title, int index, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: PortfolioTheme.primaryCyan),
      title: Text(
        title,
        style: GoogleFonts.outfit(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onNavigateToSection(index);
      },
    );
  }
}
