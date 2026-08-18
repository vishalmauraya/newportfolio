import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class SkillsSection extends StatefulWidget {
  final bool isDark;

  const SkillsSection({super.key, required this.isDark});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Languages',
    'Frameworks & State',
    'Cloud & Databases',
    'Tools & IDEs',
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPad = ResponsiveBreakpoints.contentPadding(context);
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    final filteredSkills = _selectedCategory == 'All'
        ? PortfolioData.skills
        : PortfolioData.skills
            .where((s) => s.category == _selectedCategory)
            .toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isDesktop ? 60 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildSectionHeader(
            tag: 'TECHNICAL ARSENAL',
            title: 'Skills & Architecture Expertise',
            subtitle:
                'Production-tested engineering competencies across cross-platform frameworks, state management paradigms, real-time backend pipelines, and developer tooling.',
          ),
          const SizedBox(height: 24),

          // Category Filter Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: widget.isDark
                        ? const Color(0xFF131B2E)
                        : const Color(0xFFE2E8F0),
                    selectedColor: PortfolioTheme.primaryCyan,
                    labelStyle: GoogleFonts.outfit(
                      color: isSelected
                          ? Colors.black
                          : (widget.isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF475569)),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? PortfolioTheme.primaryCyan
                            : Colors.transparent,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              if (constraints.maxWidth < 650) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 1000) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredSkills.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: crossAxisCount == 1 ? 2.6 : 1.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return _buildSkillCard(filteredSkills[index]);
                },
              );
            },
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
            color: PortfolioTheme.primaryCyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: PortfolioTheme.primaryCyan.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.firaCode(
              color: PortfolioTheme.primaryCyan,
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
            color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
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
              color: widget.isDark
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCard(SkillItem skill) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: PortfolioTheme.glassBoxDecoration(
        isDark: widget.isDark,
        radius: 18,
        borderColor: skill.color.withValues(alpha: 0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: skill.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(skill.icon, color: skill.color, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  skill.name,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark
                        ? Colors.white
                        : const Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${(skill.proficiency * 100).toInt()}%',
                style: GoogleFonts.firaCode(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: skill.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            skill.description,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: widget.isDark
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF64748B),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: skill.proficiency,
              backgroundColor: widget.isDark
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation(skill.color),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}
