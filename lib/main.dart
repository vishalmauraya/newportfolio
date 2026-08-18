import 'package:flutter/material.dart';
import 'theme/portfolio_theme.dart';
import 'widgets/navigation_bar.dart';
import 'widgets/developer_terminal.dart';
import 'widgets/resume_dialog.dart';
import 'sections/hero_section.dart';
import 'sections/stats_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VishalPortfolioApp());
}

class VishalPortfolioApp extends StatefulWidget {
  const VishalPortfolioApp({super.key});

  @override
  State<VishalPortfolioApp> createState() => _VishalPortfolioAppState();
}

class _VishalPortfolioAppState extends State<VishalPortfolioApp> {
  bool _isDark = true;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vishal Kumar | Flutter Developer & Mobile Engineer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: PortfolioTheme.lightTheme,
      darkTheme: PortfolioTheme.darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: PortfolioHomePage(
        isDark: _isDark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const PortfolioHomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _activeSection = 0;
  bool _showBackToTop = false;

  // Global Keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 400 && !_showBackToTop) {
        setState(() => _showBackToTop = true);
      } else if (_scrollController.offset <= 400 && _showBackToTop) {
        setState(() => _showBackToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    setState(() => _activeSection = index);

    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _skillsKey;
        break;
      case 2:
        targetKey = _projectsKey;
        break;
      case 3:
      case 4:
        targetKey = _experienceKey;
        break;
      case 5:
        targetKey = _contactKey;
        break;
      default:
        targetKey = _heroKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openDevTerminal() {
    showDialog(
      context: context,
      builder: (context) => DeveloperTerminalDialog(
        onToggleTheme: widget.onToggleTheme,
        onOpenResume: _openResumeModal,
      ),
    );
  }

  void _openResumeModal() {
    showDialog(
      context: context,
      builder: (context) => const ResumeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDark
          ? PortfolioTheme.darkBg
          : PortfolioTheme.lightBg,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 70), // Offset for sticky navbar

                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    isDark: widget.isDark,
                    onExploreProjects: () => _scrollToSection(2),
                    onContactMe: () => _scrollToSection(5),
                    onOpenResume: _openResumeModal,
                  ),
                ),

                // Key Achievements & Stats
                StatsSection(isDark: widget.isDark),

                // Skills Section
                Container(
                  key: _skillsKey,
                  child: SkillsSection(isDark: widget.isDark),
                ),

                // Projects Showcase
                Container(
                  key: _projectsKey,
                  child: ProjectsSection(isDark: widget.isDark),
                ),

                // Experience & Education Section
                Container(
                  key: _experienceKey,
                  child: ExperienceSection(isDark: widget.isDark),
                ),

                // Contact Section & Footer
                Container(
                  key: _contactKey,
                  child: ContactSection(
                    isDark: widget.isDark,
                    onOpenResume: _openResumeModal,
                  ),
                ),
              ],
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              isDark: widget.isDark,
              onToggleTheme: widget.onToggleTheme,
              onOpenTerminal: _openDevTerminal,
              onOpenResume: _openResumeModal,
              onNavigateToSection: _scrollToSection,
              activeSection: _activeSection,
            ),
          ),

          // Floating Back To Top Button
          if (_showBackToTop)
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton.small(
                onPressed: () => _scrollToSection(0),
                backgroundColor: PortfolioTheme.primaryCyan,
                foregroundColor: Colors.black,
                elevation: 6,
                tooltip: 'Back to top',
                child: const Icon(Icons.keyboard_arrow_up, size: 20),
              ),
            ),
        ],
      ),
    );
  }
}
