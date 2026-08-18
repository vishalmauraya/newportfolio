import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/portfolio_theme.dart';

class ContactSection extends StatefulWidget {
  final bool isDark;
  final VoidCallback onOpenResume;

  const ContactSection({
    super.key,
    required this.isDark,
    required this.onOpenResume,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;
  bool _isSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    // Simulate sending network request
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      _isSending = false;
      _isSent = true;
    });

    // Also offer mailto fallback
    final Uri mailUri = Uri(
      scheme: 'mailto',
      path: PortfolioData.email,
      queryParameters: {
        'subject': _subjectController.text,
        'body': 'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\n${_messageController.text}',
      },
    );
    launchUrl(mailUri);
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
            tag: 'GET IN TOUCH',
            title: 'Let’s Build Something Exceptional Together',
            subtitle:
                'I am available for engineering roles, technical consultations, and high-impact mobile & web application developments. Reach out directly via WhatsApp, email, or send a message below.',
          ),
          const SizedBox(height: 36),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Direct Contact Cards
                    Expanded(
                      flex: 4,
                      child: _buildDirectContactCards(),
                    ),
                    const SizedBox(width: 40),
                    // Right Column: Interactive Contact Form
                    Expanded(
                      flex: 5,
                      child: _buildContactForm(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildDirectContactCards(),
                    const SizedBox(height: 30),
                    _buildContactForm(),
                  ],
                ),

          const SizedBox(height: 60),

          // Footer
          _buildFooter(),
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

  Widget _buildDirectContactCards() {
    return Column(
      children: [
        // WhatsApp Direct Card
        _buildContactItem(
          icon: Icons.chat,
          title: 'Direct WhatsApp',
          value: PortfolioData.phone,
          color: const Color(0xFF25D366),
          onTap: () => launchUrl(Uri.parse(PortfolioData.whatsapp)),
        ),
        const SizedBox(height: 12),

        // Email Card
        _buildContactItem(
          icon: Icons.email_outlined,
          title: 'Email Address',
          value: PortfolioData.email,
          color: PortfolioTheme.primaryCyan,
          onTap: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
        ),
        const SizedBox(height: 12),

        // LinkedIn Card
        _buildContactItem(
          icon: Icons.business_center,
          title: 'LinkedIn Profile',
          value: 'vishal-kumar-600438257',
          color: const Color(0xFF0A66C2),
          onTap: () => launchUrl(Uri.parse(PortfolioData.linkedin)),
        ),
        const SizedBox(height: 12),

        // GitHub Card
        _buildContactItem(
          icon: Icons.code,
          title: 'GitHub Repositories',
          value: 'vishalmauraya',
          color: const Color(0xFFE2E8F0),
          onTap: () => launchUrl(Uri.parse(PortfolioData.github)),
        ),
        const SizedBox(height: 16),

        // Resume Button
        ElevatedButton.icon(
          onPressed: widget.onOpenResume,
          icon: const Icon(Icons.download, size: 16),
          label: const Text('View & Download Printable Resume'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isDark
                ? const Color(0xFF1E293B)
                : const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 46),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: PortfolioTheme.primaryCyan.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: PortfolioTheme.glassBoxDecoration(
          isDark: widget.isDark,
          radius: 16,
          borderColor: color.withValues(alpha: 0.25),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: widget.isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.outfit(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark
                          ? Colors.white
                          : const Color(0xFF0F172A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: widget.isDark
                  ? const Color(0xFF64748B)
                  : const Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: PortfolioTheme.glassBoxDecoration(
        isDark: widget.isDark,
        radius: 22,
        borderColor: PortfolioTheme.primaryCyan.withValues(alpha: 0.3),
        hasGlow: true,
      ),
      child: _isSent
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00F5A0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.black, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  'Message Sent Successfully!',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark
                        ? Colors.white
                        : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Thank you for reaching out! I will respond to your message promptly.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => setState(() => _isSent = false),
                  child: const Text('Send Another Message'),
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Message Form',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark
                          ? Colors.white
                          : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name & Email
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _nameController,
                          label: 'Your Name',
                          hint: 'John Doe',
                          validator: (v) =>
                              v!.trim().isEmpty ? 'Name is required' : null,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildTextField(
                          controller: _emailController,
                          label: 'Your Email',
                          hint: 'john@example.com',
                          validator: (v) => v!.contains('@')
                              ? null
                              : 'Valid email required',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Subject
                  _buildTextField(
                    controller: _subjectController,
                    label: 'Subject',
                    hint: 'Exciting Opportunity / Project Inquiry',
                    validator: (v) =>
                        v!.trim().isEmpty ? 'Subject is required' : null,
                  ),
                  const SizedBox(height: 14),

                  // Message
                  _buildTextField(
                    controller: _messageController,
                    label: 'Message',
                    hint: 'Hi Vishal, I’d love to discuss...',
                    maxLines: 4,
                    validator: (v) =>
                        v!.trim().isEmpty ? 'Message cannot be empty' : null,
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _isSending ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PortfolioTheme.primaryCyan,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'Send Message via Mail / Direct',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: widget.isDark
                ? const Color(0xFFCBD5E1)
                : const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: widget.isDark ? Colors.white : Colors.black87,
            fontSize: 13.5,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
            filled: true,
            fillColor: widget.isDark
                ? const Color(0xFF0F172A)
                : const Color(0xFFF1F5F9),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: PortfolioTheme.primaryCyan,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widget.isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Text(
            '© 2026 Vishal Kumar • Built with Flutter Web & Dart',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lucknow, UP, India 📍',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
