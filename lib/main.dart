import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hero_section.dart';
import 'portfolio_nav_bar.dart';
import 'about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'experience_section.dart';
import 'skills_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunad-Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF64FFDA), // Mint accent
          brightness: Brightness.dark,
          background: const Color(0xFF0A192F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A192F),
          elevation: 0,
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  bool _drawerOpen = false;

  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _openDrawer() => setState(() => _drawerOpen = true);
  void _closeDrawer() => setState(() => _drawerOpen = false);

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'hero':
        key = _heroKey;
        break;
      case 'about':
        key = _aboutKey;
        break;
      case 'experience':
        key = _experienceKey;
        break;
      case 'skills':
        key = _skillsKey;
        break;
      case 'projects':
        key = _projectsKey;
        break;
      case 'contact':
        key = _contactKey;
        break;
    }
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 700 ? 16.0 : screenWidth < 1100 ? 32.0 : 120.0;
    final showSideEmail = screenWidth > 900;
    final isMobile = screenWidth < 700;
    final drawerWidth = screenWidth * 0.7;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: PortfolioNavBar(
          showHamburger: isMobile,
          drawerOpen: _drawerOpen,
          onHamburgerTap: _drawerOpen ? _closeDrawer : _openDrawer,
          onNavTap: _scrollToSection,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeyedSubtree(
                    key: _heroKey,
                    child: HeroSection(
                      onGetInTouch: () => _scrollToSection('contact'),
                    ),
                  ),
                  const SizedBox(height: 100),
                  KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                  const SizedBox(height: 100),
                  KeyedSubtree(key: _experienceKey, child: ExperienceSection()),
                  const SizedBox(height: 100),
                  KeyedSubtree(key: _skillsKey, child: SkillsSection()),
                  const SizedBox(height: 100),
                  KeyedSubtree(key: _projectsKey, child: const ProjectsSection()),
                  const SizedBox(height: 100),
                  KeyedSubtree(key: _contactKey, child: const ContactSection()),
                  const SizedBox(height: 60),
                  // Footer at the very end
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.1,
                              ),
                              children: [
                                const TextSpan(text: 'Crafted with '),
                                TextSpan(
                                  text: '❤️',
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
                                ),
                                const TextSpan(text: ' by '),
                                TextSpan(
                                  text: 'Sunad',
                                  style: TextStyle(
                                    color: Color(0xFF64FFDA),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const TextSpan(text: ' using '),
                                TextSpan(
                                  text: 'Flutter',
                                  style: TextStyle(
                                    color: Color(0xFF64FFDA),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.1,
                              ),
                              children: [
                                const TextSpan(text: 'Design inspiration from '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse('https://brittanychiang.com/'));
                                    },
                                    child: Text(
                                      'https://brittanychiang.com/',
                                      style: TextStyle(
                                        color: Color(0xFF64FFDA),
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Remove the old email display and add a new clickable vertical email bar
          if (showSideEmail)
            Positioned(
              right: 32, // Increased space from right edge
              bottom: 0,
              top: 0,
              child: Column(
                children: [
                  const Spacer(flex: 2), // Push email further down
                  InkWell(
                    onTap: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'sunadrgundagatti@gmail.com',
                      );
                      if (await canLaunchUrl(emailLaunchUri)) {
                        await launchUrl(emailLaunchUri);
                      }
                    },
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        'sunadrgundagatti@gmail.com',
                        style: GoogleFonts.firaMono(
                          color: const Color(0xFF64FFDA),
                          fontSize: 18, // Increased font size
                          fontWeight: FontWeight.w500, // Bolder font
                          letterSpacing: 4.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF64FFDA),
                    ),
                  ),
                ],
              ),
            ),
          // Custom right-side drawer overlay
          if (_drawerOpen && isMobile)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDrawer,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          if (_drawerOpen && isMobile)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: CustomPortfolioDrawer(
                width: drawerWidth,
                onClose: _closeDrawer,
                onNavTap: _scrollToSection,
              ),
            ),
        ],
      ),
    );
  }
}

class CustomPortfolioDrawer extends StatelessWidget {
  final double width;
  final VoidCallback onClose;
  final void Function(String section)? onNavTap;
  const CustomPortfolioDrawer({super.key, required this.width, required this.onClose, this.onNavTap});

  static const Color mint = Color(0xFF64FFDA);
  static const Color drawerBg = Color(0xFF172A45); // lighter navy

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: width,
      decoration: const BoxDecoration(
        color: drawerBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 24,
            offset: Offset(-8, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _DrawerNavLink(number: '01.', label: 'About', onTap: () { onNavTap?.call('about'); onClose(); }),
                const SizedBox(height: 18),
                _DrawerNavLink(number: '02.', label: 'Experience', onTap: () { onNavTap?.call('experience'); onClose(); }),
                const SizedBox(height: 18),
                _DrawerNavLink(number: '03.', label: 'Skills', onTap: () { onNavTap?.call('skills'); onClose(); }),
                const SizedBox(height: 18),
                _DrawerNavLink(number: '04.', label: 'Projects', onTap: () { onNavTap?.call('projects'); onClose(); }),
                const SizedBox(height: 18),
                _DrawerNavLink(number: '05.', label: 'Contact', onTap: () { onNavTap?.call('contact'); onClose(); }),
                const SizedBox(height: 32),
                _DrawerResumeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonLogo extends StatelessWidget {
  final double size;
  final String initial;
  final Color color;
  const HexagonLogo({required this.size, required this.initial, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _HexagonPainter(color),
        child: Center(
          child: Text(
            initial,
            style: GoogleFonts.firaMono(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: size * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  final Color color;
  _HexagonPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    final double w = size.width, h = size.height;
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60.0 - 30.0) * 3.1415926535 / 180.0;
      final x = w / 2 + w / 2 * 0.85 * math.cos(angle);
      final y = h / 2 + h / 2 * 0.85 * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    paint.color = color;
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawerNavLink extends StatelessWidget {
  final String number;
  final String label;
  final VoidCallback? onTap;
  const _DrawerNavLink({required this.number, required this.label, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.firaMono(
              color: CustomPortfolioDrawer.mint.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerResumeButton extends StatelessWidget {
  const _DrawerResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: double.infinity,
        height: isSmall ? 38 : 44,
        child: TextButton(
          onPressed: () {
            // TODO: Add your resume link
          },
          style: TextButton.styleFrom(
            foregroundColor: CustomPortfolioDrawer.mint,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: isSmall ? 4 : 8),
            textStyle: GoogleFonts.firaMono(
              fontSize: isSmall ? 15 : 18,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text('Resume'),
        ),
      ),
    );
  }
}
