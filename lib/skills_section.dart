import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';

class SkillsSection extends StatefulWidget {
  SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with TickerProviderStateMixin {
  late final AnimationController _groupController;
  final int _groupCount = 4; // Number of groups
  final int _chipStaggerMs = 60;
  bool _animationStarted = false;

  final Map<String, List<_Skill>> skillGroups = const {
    'Languages': [
      _Skill('Dart', 'assets/images/skills/dart-original.svg'),
      _Skill('Java', 'assets/images/skills/java-original.svg'),
      _Skill('Kotlin', 'assets/images/skills/kotlin-original.svg'),
      _Skill('SQL (MySQL)', 'assets/images/skills/mysql-original.svg'),
      _Skill('PHP', 'assets/images/skills/php-original.svg'),
      _Skill('HTML5', 'assets/images/skills/html5-original.svg'),
      _Skill('CSS3', 'assets/images/skills/css3-original.svg'),
      _Skill('JavaScript', 'assets/images/skills/javascript-original.svg'),
      _Skill('XML', 'assets/images/skills/xml-original.svg'),
    ],
    'Frameworks & Libraries': [
      _Skill('Flutter', 'assets/images/skills/flutter-original.svg'),
      _Skill('Firebase', 'assets/images/skills/firebase-original.svg'),
      _Skill('Material UI', 'assets/images/skills/materialui-original.svg'),
      _Skill('Gradle', 'assets/images/skills/gradle-original.svg'),
      _Skill('Apache', 'assets/images/skills/apache-original.svg'),
      _Skill('MVVM', 'assets/images/skills/mvvm-custom.svg'),
      _Skill('MVC', 'assets/images/skills/mvc-custom.svg'),
      _Skill('Volley', 'assets/images/skills/volley-custom.svg'),
      _Skill('Retrofit', 'assets/images/skills/retrofit-custom.svg'),
    ],
    'Tools': [
      _Skill('Git', 'assets/images/skills/git-original.svg'),
      _Skill('GitHub', 'assets/images/skills/github-original.svg'),
      _Skill('VS Code', 'assets/images/skills/vscode-original-wordmark.svg'),
      _Skill('Android Studio', 'assets/images/skills/androidstudio-original.svg'),
      _Skill('Canva', 'assets/images/skills/canva-original.svg'),
      _Skill('CI/CD', 'assets/images/skills/cicd-custom.svg'),
    ],
    'Platforms': [
      _Skill('Android', 'assets/images/skills/android-original.svg'),
      _Skill('iOS', 'assets/images/skills/ios-original.svg'),
      _Skill('Web', 'assets/images/skills/web-original.svg'),
    ],
  };

  @override
  void initState() {
    super.initState();
    _groupController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _groupController.dispose();
    super.dispose();
  }

  void _handleVisibility(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_animationStarted) {
      setState(() {
        _animationStarted = true;
      });
      _groupController.forward();
    } else if (info.visibleFraction < 0.1 && _animationStarted) {
      setState(() {
        _animationStarted = false;
      });
      _groupController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    final accentColor = const Color(0xFF64FFDA);
    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: _handleVisibility,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: isSmall ? 8 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '03. ',
                  style: GoogleFonts.firaMono(
                    color: accentColor,
                    fontSize: isSmall ? 18 : 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Skills',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: const Color(0xFFCCD6F6),
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
            ...skillGroups.entries.toList().asMap().entries.map((entry) {
              final groupIndex = entry.key;
              final groupName = entry.value.key;
              final skills = entry.value.value;
              final groupAnimation = CurvedAnimation(
                parent: _groupController,
                curve: Interval(
                  (groupIndex / _groupCount).clamp(0.0, 1.0),
                  ((groupIndex + 1) / _groupCount).clamp(0.0, 1.0),
                  curve: Curves.easeOut,
                ),
              );
              return FadeTransition(
                opacity: groupAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.18),
                    end: Offset.zero,
                  ).animate(groupAnimation),
                  child: _SkillGroupWidget(
                    groupName: groupName,
                    skills: skills,
                    accentColor: accentColor,
                    isSmall: isSmall,
                    groupIndex: groupIndex,
                    chipStaggerMs: _chipStaggerMs,
                    animationStarted: _animationStarted,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _SkillGroupWidget extends StatelessWidget {
  final String groupName;
  final List<_Skill> skills;
  final Color accentColor;
  final bool isSmall;
  final int groupIndex;
  final int chipStaggerMs;
  final bool animationStarted;
  const _SkillGroupWidget({
    required this.groupName,
    required this.skills,
    required this.accentColor,
    required this.isSmall,
    required this.groupIndex,
    required this.chipStaggerMs,
    required this.animationStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupName,
          style: GoogleFonts.firaMono(
            color: accentColor,
            fontSize: isSmall ? 16 : 19,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: skills.asMap().entries.map((entry) {
            final i = entry.key;
            final skill = entry.value;
            return _AnimatedSkillChip(
              skill: skill,
              accentColor: accentColor,
              isSmall: isSmall,
              delay: Duration(milliseconds: (chipStaggerMs * i) + (groupIndex * 200)),
              animationStarted: animationStarted,
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _AnimatedSkillChip extends StatefulWidget {
  final _Skill skill;
  final Color accentColor;
  final bool isSmall;
  final Duration delay;
  final bool animationStarted;
  const _AnimatedSkillChip({
    required this.skill,
    required this.accentColor,
    required this.isSmall,
    required this.delay,
    required this.animationStarted,
  });

  @override
  State<_AnimatedSkillChip> createState() => _AnimatedSkillChipState();
}

class _AnimatedSkillChipState extends State<_AnimatedSkillChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(_opacity);
    if (widget.animationStarted) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedSkillChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationStarted && !_controller.isCompleted) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.13 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _slide,
            child: _SkillChip(
              skill: widget.skill,
              accentColor: widget.accentColor,
              isSmall: widget.isSmall,
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final _Skill skill;
  final Color accentColor;
  final bool isSmall;
  const _SkillChip({required this.skill, required this.accentColor, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    Widget avatarWidget;
    if (skill.iconPath != null) {
      avatarWidget = SvgPicture.asset(
        skill.iconPath!,
        colorFilter: (skill.name == 'Gradle' || skill.name == 'XML')
            ? ColorFilter.mode(accentColor, BlendMode.srcIn)
            : null,
      );
    } else {
      avatarWidget = Container(
        alignment: Alignment.center,
        child: Text(
          skill.name.substring(0, skill.name.length > 4 ? 4 : skill.name.length),
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.bold,
            fontSize: isSmall ? 13 : 16,
            letterSpacing: 0.5,
          ),
        ),
      );
    }
    return Chip(
      backgroundColor: accentColor.withOpacity(0.13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      avatar: Container(
        width: isSmall ? 28 : 36,
        height: isSmall ? 28 : 36,
        padding: const EdgeInsets.all(2),
        child: avatarWidget,
      ),
      label: Text(
        skill.name,
        style: TextStyle(
          fontFamily: 'Inter',
          color: const Color(0xFFCCD6F6),
          fontWeight: FontWeight.w600,
          fontSize: isSmall ? 14 : 17,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 14, vertical: isSmall ? 2 : 6),
    );
  }
}

class _Skill {
  final String name;
  final String? iconPath;
  const _Skill(this.name, this.iconPath);
} 