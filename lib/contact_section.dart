import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF64FFDA);
    final textColor = const Color(0xFFCCD6F6);
    final subtitleColor = const Color(0xFFAEB6C3);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 12.0 : 32.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          Row(
            children: [
              Text(
                '05. ',
                style: GoogleFonts.firaMono(
                  color: accentColor,
                  fontSize: isSmall ? 18 : 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Contact Me',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: textColor,
                  fontSize: isSmall ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  height: 1,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Container(
                  width: isSmall ? double.infinity : 480,
                  padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: accentColor.withOpacity(0.13), width: 1.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Let's connect!",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: accentColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision.\nLet's bring great ideas to life together!",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: subtitleColor,
                          fontSize: isSmall ? 16 : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SelectableText(
                        'sunadrgundagatti@gmail.com',
                        style: GoogleFonts.firaMono(
                          color: accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email, color: Colors.white),
                            tooltip: 'Email',
                            onPressed: () {
                              _launchUrl('mailto:sunadrgundagatti@gmail.com');
                            },
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/images/skills/linkedin-plain.svg',
                              width: 28,
                              height: 28,
                              color: Colors.white,
                            ),
                            tooltip: 'LinkedIn',
                            onPressed: () {
                              _launchUrl('https://www.linkedin.com/in/sunadrgundagatti/');
                            },
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/images/skills/github-original.svg',
                              width: 28,
                              height: 28,
                              color: Colors.white,
                            ),
                            tooltip: 'GitHub',
                            onPressed: () {
                              _launchUrl('https://github.com/sunadrg');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 