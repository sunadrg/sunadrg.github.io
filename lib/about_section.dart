import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _hasAnimated = false;

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
    // Do not start animation here; wait for visibility
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    final sectionHeight = isSmall ? null : 400.0;
    final sectionPadding = isSmall ? 12.0 : 32.0;
    final accentColor = const Color(0xFF64FFDA);
    final textColor = const Color(0xFFCCD6F6);
    final subtitleColor = const Color(0xFFAEB6C3);
    final divider = Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        height: 1,
        color: Colors.white.withOpacity(0.08),
      ),
    );
    final profileImage = Container(
      width: isSmall ? 120 : 200,
      height: isSmall ? 120 : 200,
      decoration: BoxDecoration(
        border: Border.all(color: accentColor, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.05),
        image: const DecorationImage(
          image: AssetImage('assets/images/sunad.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
    final aboutTitle = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '01. ',
            style: GoogleFonts.firaMono(
              color: accentColor,
              fontSize: isSmall ? 18 : 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'About Me',
            style: TextStyle(
              fontFamily: 'Inter',
              color: textColor,
              fontSize: isSmall ? 22 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    final aboutText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        aboutTitle,
        const SizedBox(height: 8),
        Row(children: [divider]),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Inter',
              color: subtitleColor,
              fontSize: isSmall ? 15 : 16,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
            children: [
              const TextSpan(text: "Hey there! I’m Sunad R Gundagatti, a "),
              TextSpan(text: "mobile app developer", style: TextStyle(color: accentColor)),
              const TextSpan(text: " with "),
              TextSpan(text: "2.5+ years of experience", style: TextStyle(color: accentColor)),
              const TextSpan(text: " building user-centric, performance-driven mobile applications.\n\nMy journey began with "),
              TextSpan(text: "Android development", style: TextStyle(color: accentColor)),
              const TextSpan(text: " in Java, where I got my hands dirty crafting apps from scratch — from UI design and API integration to Play Store release. Over time, I expanded into "),
              TextSpan(text: "cross-platform development", style: TextStyle(color: accentColor)),
              const TextSpan(text: " using "),
              TextSpan(text: "Flutter", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", enabling me to build scalable solutions for both Android and iOS.\n\nI’ve led the development of "),
              TextSpan(text: "real-world apps", style: TextStyle(color: accentColor)),
              const TextSpan(text: " across domains like "),
              TextSpan(text: "agritech", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", "),
              TextSpan(text: "education", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", "),
              TextSpan(text: "finance", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", "),
              TextSpan(text: "logistics", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", "),
              TextSpan(text: "HR", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", and "),
              TextSpan(text: "healthcare", style: TextStyle(color: accentColor)),
              const TextSpan(text: ". One of my most exciting projects was a ₹1.8 million "),
              TextSpan(text: "government-funded", style: TextStyle(color: accentColor)),
              const TextSpan(text: " Cane Management System — a full-stack mobile solution that included GPS-based geofencing, cloud messaging, and even Bluetooth thermal printing.\n\nI enjoy writing clean, maintainable code and love seeing my work used by real people. I’m constantly learning — currently diving deeper into "),
              TextSpan(text: "Kotlin", style: TextStyle(color: accentColor)),
              const TextSpan(text: " and "),
              TextSpan(text: "Jetpack Compose", style: TextStyle(color: accentColor)),
              const TextSpan(text: " to keep up with modern Android development.\n\nOutside of code, I’ve conducted mobile development workshops, "),
              TextSpan(text: "co-founded a startup", style: TextStyle(color: accentColor)),
              const TextSpan(text: ", and enjoy experimenting with tech that solves real-world problems."),
            ],
          ),
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.all(sectionPadding),
      child: VisibilityDetector(
        key: const Key('about-section'),
        onVisibilityChanged: (info) {
          if (!_hasAnimated && info.visibleFraction > 0.2) {
            _hasAnimated = true;
            _controller.forward();
          } else if (_hasAnimated && info.visibleFraction < 0.1) {
            _hasAnimated = false;
            _controller.reset();
          }
        },
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: isSmall
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aboutTitle,
                      const SizedBox(height: 8),
                      Row(children: [divider]),
                      const SizedBox(height: 24),
                      Center(child: profileImage),
                      const SizedBox(height: 24),
                      ...aboutText.children!.sublist(3),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: aboutText),
                      const SizedBox(width: 40),
                      profileImage,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _AboutBullet extends StatelessWidget {
  final String text;
  const _AboutBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('▸ ', style: TextStyle(color: Color(0xFF64FFDA), fontWeight: FontWeight.bold)),
          Text(
            text,
            style: GoogleFonts.firaMono(
              color: const Color(0xFFCCD6F6),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
} 