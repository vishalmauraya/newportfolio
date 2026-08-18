import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';

class DeveloperTerminalDialog extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final VoidCallback? onOpenResume;

  const DeveloperTerminalDialog({
    super.key,
    this.onToggleTheme,
    this.onOpenResume,
  });

  @override
  State<DeveloperTerminalDialog> createState() =>
      _DeveloperTerminalDialogState();
}

class _DeveloperTerminalDialogState extends State<DeveloperTerminalDialog> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<Map<String, dynamic>> _history = [
    {
      'type': 'system',
      'text':
          '🚀 Vishal Kumar DevTools Terminal v2.4.0 [Dart 3.12.2 / Flutter 3.44.8]\n'
          'Type "help" to see available commands or try "projects", "skills", "flutter doctor".',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleCommand(String rawInput) {
    final cmd = rawInput.trim().toLowerCase();
    _inputController.clear();
    if (cmd.isEmpty) return;

    setState(() {
      _history.add({'type': 'input', 'text': '> $rawInput'});

      switch (cmd) {
        case 'help':
          _history.add({
            'type': 'output',
            'text':
                'Available Commands:\n'
                '  whoami       - Display developer summary & background\n'
                '  skills       - Show technical proficiency & tech stack\n'
                '  projects     - List flagship production applications\n'
                '  exp          - Career work experience timeline\n'
                '  education    - University & academic qualifications\n'
                '  contact      - Get direct phone, email, WhatsApp, socials\n'
                '  hire         - Summary for technical recruiters & hiring managers\n'
                '  flutter doctor - Run Flutter environment diagnosis check\n'
                '  resume       - Open formatted resume viewer\n'
                '  theme        - Toggle between Cyber Dark and Aurora Light\n'
                '  whatsapp     - Open direct WhatsApp chat session\n'
                '  github       - Open GitHub profile\n'
                '  linkedin     - Open LinkedIn profile\n'
                '  clear        - Clear console screen history',
          });
          break;

        case 'whoami':
          _history.add({
            'type': 'output',
            'text':
                '👤 Name: ${PortfolioData.name}\n'
                '💼 Role: ${PortfolioData.title}\n'
                '📍 Location: ${PortfolioData.location}\n'
                '🎯 Focus: Pixel-perfect UI, 60fps animations, Riverpod/Bloc reactive architectures, real-time sensor streams, and Firebase cloud integrations.',
          });
          break;

        case 'skills':
          _history.add({
            'type': 'output',
            'text':
                '⚡ TECHNICAL SKILLS MATRIX:\n'
                '• Languages: Dart (95%), JavaScript (88%), Java (85%), C++ (80%), Python (78%)\n'
                '• Frameworks: Flutter Mobile & Web (95%), Riverpod (92%), Bloc (88%), Provider (86%), Bootstrap CSS (84%)\n'
                '• Databases: Firebase Firestore/DB (92%), MongoDB (82%), MySQL (80%)\n'
                '• Cloud/APIs: REST APIs, WebSockets, FCM Push Notifications, Stripe, Google Maps API\n'
                '• Tools/IDEs: Git/GitHub, Android Studio, VS Code, Linux, Xcode',
          });
          break;

        case 'projects':
          _history.add({
            'type': 'output',
            'text':
                '🏆 FLAGSHIP PROJECTS:\n'
                '1. [Driver Quest] - Flutter + Riverpod + Stripe + Sensors + Maps\n'
                '   Real-time driver telematics, sensor stream processing & safety scoring.\n\n'
                '2. [Yatri Cabs] - Flutter + Riverpod + MongoDB + WebSockets + FCM\n'
                '   Dual-app ecosystem for riders & drivers with real-time socket tracking.\n\n'
                '3. [Aether Weather] - Flutter + Bloc + OpenWeather API\n'
                '   Dynamic atmospheric visualizer with live hourly weather forecasts.',
          });
          break;

        case 'exp':
        case 'experience':
          _history.add({
            'type': 'output',
            'text':
                '💼 WORK EXPERIENCE:\n'
                '1. The MetroMax Group (Flutter Developer | Oct 2025 – Jun 2026)\n'
                '   • Engineered Drive Safe telematics logic & background sensor stream architecture.\n'
                '   • Optimized screen refresh pipelines for seamless 60fps rendering.\n\n'
                '2. Aarsaar Technologies Pvt. Ltd. (Flutter Developer | Dec 2024 – Sept 2025)\n'
                '   • Built dynamic UI screens from Figma and integrated backend REST APIs.\n'
                '   • Collaborated in cross-functional agile sprints for customer rollouts.',
          });
          break;

        case 'education':
          _history.add({
            'type': 'output',
            'text':
                '🎓 EDUCATION:\n'
                '• B.Tech in Computer Science & Engineering (74.4%)\n'
                '  Central University of Haryana (2021 – 2025)\n\n'
                '• Class XII - Senior Secondary (89.6%)\n'
                '  Lucknow Public College, U.P. Board (2020 – 2021)',
          });
          break;

        case 'contact':
          _history.add({
            'type': 'output',
            'text':
                '📬 DIRECT CONTACT CHANNELS:\n'
                '• Email: ${PortfolioData.email}\n'
                '• Phone: ${PortfolioData.phone}\n'
                '• WhatsApp: Direct chat available at ${PortfolioData.phone}\n'
                '• GitHub: ${PortfolioData.github}\n'
                '• LinkedIn: ${PortfolioData.linkedin}\n'
                '• Location: ${PortfolioData.location}',
          });
          break;

        case 'hire':
          _history.add({
            'type': 'output',
            'text':
                '🚀 WHY HIRE VISHAL KUMAR?\n'
                '✓ Proven Flutter expertise delivering high-performance cross-platform apps.\n'
                '✓ Deep mastery of reactive state (Riverpod & Bloc) and clean architecture.\n'
                '✓ Experience with sensor telemetry, WebSockets, Stripe, and Google Maps.\n'
                '✓ Fast turnaround with 100% pixel-perfect UI execution.\n'
                '✓ Available for immediate high-impact frontend & mobile roles.',
          });
          break;

        case 'flutter doctor':
        case 'doctor':
          _history.add({
            'type': 'output',
            'text':
                '[✓] Flutter (Channel stable, 3.44.8, on Microsoft Windows, locale en-US)\n'
                '[✓] Windows Version (Installed version 10.0.19045.6466)\n'
                '[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)\n'
                '[✓] Chrome - develop for the web\n'
                '[✓] Visual Studio - develop Windows apps\n'
                '[✓] Android Studio (version 2024.1)\n'
                '[✓] VS Code (version 1.96.2)\n'
                '[✓] Connected device (3 available)\n'
                '[✓] Network resources\n'
                '• No issues found! Everything is ready for production.',
          });
          break;

        case 'resume':
          widget.onOpenResume?.call();
          _history.add({
            'type': 'output',
            'text': '📄 Opening formatted resume viewer modal...',
          });
          break;

        case 'theme':
          widget.onToggleTheme?.call();
          _history.add({
            'type': 'output',
            'text': '🎨 Portfolio theme toggled successfully.',
          });
          break;

        case 'whatsapp':
          launchUrl(Uri.parse(PortfolioData.whatsapp));
          _history.add({
            'type': 'output',
            'text': '📱 Launching direct WhatsApp conversation...',
          });
          break;

        case 'github':
          launchUrl(Uri.parse(PortfolioData.github));
          _history.add({
            'type': 'output',
            'text': '🐙 Opening GitHub profile in new tab...',
          });
          break;

        case 'linkedin':
          launchUrl(Uri.parse(PortfolioData.linkedin));
          _history.add({
            'type': 'output',
            'text': '💼 Opening LinkedIn profile in new tab...',
          });
          break;

        case 'clear':
        case 'cls':
          _history.clear();
          break;

        default:
          _history.add({
            'type': 'error',
            'text':
                'Command not recognized: "$rawInput". Type "help" for valid commands.',
          });
          break;
      }
    });

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 700;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: isCompact ? size.width * 0.95 : 720,
        height: isCompact ? size.height * 0.8 : 520,
        decoration: BoxDecoration(
          color: const Color(0xFF090D16),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF00F2FE).withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F2FE).withValues(alpha: 0.15),
              blurRadius: 30,
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
            // Terminal Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF121829),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFF1E293B), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5F56),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFBD2E),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27C93F),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'vishal@portfolio: ~/developer-console (zsh)',
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFF94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 18),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Quick Pill Shortcuts
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: const Color(0xFF0F1523),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildQuickPill('help'),
                    _buildQuickPill('whoami'),
                    _buildQuickPill('skills'),
                    _buildQuickPill('projects'),
                    _buildQuickPill('flutter doctor'),
                    _buildQuickPill('hire'),
                    _buildQuickPill('contact'),
                    _buildQuickPill('clear'),
                  ],
                ),
              ),
            ),

            // Console Output Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    final type = item['type'] as String;
                    final text = item['text'] as String;

                    Color textColor = const Color(0xFFE2E8F0);
                    if (type == 'system') textColor = const Color(0xFF00F2FE);
                    if (type == 'input') textColor = const Color(0xFF00F5A0);
                    if (type == 'error') textColor = const Color(0xFFFF4B72);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: SelectableText(
                        text,
                        style: GoogleFonts.firaCode(
                          color: textColor,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Command Input Line
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF101626),
                border: Border(
                  top: BorderSide(color: Color(0xFF1E293B), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'vishal@terminal:~\$ ',
                    style: GoogleFonts.firaCode(
                      color: const Color(0xFF00F5A0),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      focusNode: _focusNode,
                      style: GoogleFonts.firaCode(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      cursorColor: const Color(0xFF00F2FE),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'type command and press Enter...',
                        hintStyle: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 12,
                        ),
                      ),
                      onSubmitted: _handleCommand,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send,
                        color: Color(0xFF00F2FE), size: 16),
                    onPressed: () => _handleCommand(_inputController.text),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPill(String cmd) {
    return GestureDetector(
      onTap: () => _handleCommand(cmd),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white10),
        ),
        child: Text(
          cmd,
          style: GoogleFonts.firaCode(
            color: const Color(0xFF94A3B8),
            fontSize: 10.5,
          ),
        ),
      ),
    );
  }
}
