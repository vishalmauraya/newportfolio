import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class StatsSection extends StatelessWidget {
  final bool isDark;

  const StatsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final horizontalPad = ResponsiveBreakpoints.contentPadding(context);
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 20),
      child: isMobile
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: PortfolioData.stats.length,
              itemBuilder: (context, index) {
                return _buildStatCard(PortfolioData.stats[index]);
              },
            )
          : Row(
              children: PortfolioData.stats.map((stat) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildStatCard(stat),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    final Color color = stat['color'] as Color;
    final IconData icon = stat['icon'] as IconData;
    final String value = stat['value'] as String;
    final String label = stat['label'] as String;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: PortfolioTheme.glassBoxDecoration(
        isDark: isDark,
        radius: 18,
        borderColor: color.withValues(alpha: 0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
