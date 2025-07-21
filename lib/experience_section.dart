import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:visibility_detector/visibility_detector.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _timelineController;
  late List<AnimationController> _cardControllers;
  final int _staggerMs = 180;
  bool _hasAnimated = false;

  final List<_ExperienceJob> jobs = [
    _ExperienceJob(
      company: 'Gem Ventures LLP',
      location: 'Bangalore, IN',
      title: 'Software Developer',
      period: 'Oct 2023 – Present',
      bullets: [
        'Developed and maintained Mobile apps using Android Java, Flutter and Firebase (FCM, Crashlytics).',
        'Integrated RESTful APIs to enable real-time features and improve app functionality.',
        'Designed and implemented MySQL databases and built PHP-based REST APIs to power core application features.',
        'Optimized app performance and stability for production environments by 30%.',
        'Collaborated with designers to implement clean, responsive UI aligned with Material Design.',
        'Worked in Agile teams with Git and CI/CD for frequent, high-quality releases.',
        'Led migration of 2 Android apps to Flutter/Dart, reducing development effort by 40% and enabling simultaneous iOS support.',
        'Handled bug fixing, performance tuning, and ensured compatibility across various screen sizes and OS versions.',
        'Coordinated with cross-functional teams to define project milestones, ensuring 100% on-time delivery across sprint cycles.',
      ],
    ),
    _ExperienceJob(
      company: 'Linkable Technologies',
      location: 'Davanagere, IN',
      title: 'Co-Founder and Chief Managing Director',
      period: 'Mar 2023 – Present',
      bullets: [
        'Founded and scaled a startup that won ₹1.8M in Elevate-23 funding by developing full-cycle mobile solutions in agritech and edutech domains.',
        'Led development and rollout of high-impact projects that generated several lakhs in revenue within the first 6 months of launch.',
        'Managed end-to-end delivery of 10+ apps, aligning product goals with client needs while leading an 8-member engineering team.',
        'Coordinated with multiple stakeholders across departments to streamline requirements and feedback loops — improving delivery efficiency by 40%.',
        'Ensured projects were delivered on time and within budget, while opening up new revenue channels through value-added modules.',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _timelineController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900 + jobs.length * _staggerMs), // Faster, more visible
    );
    _cardControllers = List.generate(jobs.length, (i) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    ));
    // Do not run animations here; wait for visibility
  }

  Future<void> _runAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _timelineController.forward();
    for (int i = 0; i < _cardControllers.length; i++) {
      await Future.delayed(Duration(milliseconds: _staggerMs));
      _cardControllers[i].forward();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timelineController.dispose();
    for (final c in _cardControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    final accentColor = const Color(0xFF64FFDA);
    final cardBg = Colors.white.withOpacity(0.10);
    final textColor = const Color(0xFFCCD6F6);
    final subtitleColor = const Color(0xFFAEB6C3);
    final borderRadius = BorderRadius.circular(18);
    final timelineColor = accentColor.withOpacity(0.18);

    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction < 0.1 && _hasAnimated) {
          // Reset animations when section is mostly out of view
          _hasAnimated = false;
          _titleController.reset();
          _timelineController.reset();
          for (final c in _cardControllers) {
            c.reset();
          }
        } else if (!_hasAnimated && info.visibleFraction > 0.2) {
          _hasAnimated = true;
          _runAnimations();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: isSmall ? 8 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero)
                    .animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut)),
                child: Row(
                  children: [
                    Text(
                      '02. ',
                      style: GoogleFonts.firaMono(
                        color: accentColor,
                        fontSize: isSmall ? 18 : 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Experience',
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
              ),
            ),
            const SizedBox(height: 36),
            isSmall
                ? Column(
                    children: List.generate(jobs.length, (i) {
                      return _AnimatedExperienceTimelineCard(
                        job: jobs[i],
                        accentColor: accentColor,
                        cardBg: cardBg,
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        borderRadius: borderRadius,
                        timelineColor: timelineColor,
                        isFirst: i == 0,
                        isLast: i == jobs.length - 1,
                        isSmall: true,
                        controller: _cardControllers[i],
                        slideFromLeft: i % 2 == 0,
                      );
                    }),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline
                      Column(
                        children: List.generate(jobs.length * 2 - 1, (i) {
                          if (i.isEven) {
                            // Dot
                            return _AnimatedTimelineDot(
                              accentColor: accentColor,
                              controller: _timelineController,
                              index: i ~/ 2,
                              total: jobs.length,
                              staggerMs: _staggerMs,
                            );
                          } else {
                            // Line
                            return _AnimatedTimelineLine(
                              color: timelineColor,
                              controller: _timelineController,
                              index: (i - 1) ~/ 2,
                              staggerMs: _staggerMs,
                            );
                          }
                        }),
                      ),
                      const SizedBox(width: 32),
                      // Cards
                      Expanded(
                        child: Column(
                          children: List.generate(jobs.length, (i) {
                            return _AnimatedExperienceTimelineCard(
                              job: jobs[i],
                              accentColor: accentColor,
                              cardBg: cardBg,
                              textColor: textColor,
                              subtitleColor: subtitleColor,
                              borderRadius: borderRadius,
                              timelineColor: timelineColor,
                              isFirst: i == 0,
                              isLast: i == jobs.length - 1,
                              isSmall: false,
                              controller: _cardControllers[i],
                              slideFromLeft: i % 2 == 0,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedTimelineDot extends StatelessWidget {
  final Color accentColor;
  final AnimationController controller;
  final int index;
  final int total;
  final int staggerMs;
  const _AnimatedTimelineDot({required this.accentColor, required this.controller, required this.index, required this.total, required this.staggerMs});

  @override
  Widget build(BuildContext context) {
    final start = (index * staggerMs) / (controller.duration?.inMilliseconds ?? 1);
    final end = start + 0.3;
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOutBack),
    );
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.25),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.work_outline, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }
}

class _AnimatedTimelineLine extends StatelessWidget {
  final Color color;
  final AnimationController controller;
  final int index;
  final int staggerMs;
  const _AnimatedTimelineLine({required this.color, required this.controller, required this.index, required this.staggerMs});

  @override
  Widget build(BuildContext context) {
    final start = ((index + 0.5) * staggerMs) / (controller.duration?.inMilliseconds ?? 1);
    final end = start + 0.25;
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // print('Timeline animation value (index $index): ${animation.value}');
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 4,
            height: 120 * animation.value, // Increased height for visibility
            color: color,
          ),
        );
      },
    );
  }
}

class _AnimatedExperienceTimelineCard extends StatelessWidget {
  final _ExperienceJob job;
  final Color accentColor;
  final Color cardBg;
  final Color textColor;
  final Color subtitleColor;
  final BorderRadius borderRadius;
  final Color timelineColor;
  final bool isFirst;
  final bool isLast;
  final bool isSmall;
  final AnimationController controller;
  final bool slideFromLeft;

  const _AnimatedExperienceTimelineCard({
    required this.job,
    required this.accentColor,
    required this.cardBg,
    required this.textColor,
    required this.subtitleColor,
    required this.borderRadius,
    required this.timelineColor,
    required this.isFirst,
    required this.isLast,
    required this.isSmall,
    required this.controller,
    required this.slideFromLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    final offsetTween = Tween<Offset>(
      begin: slideFromLeft ? const Offset(-0.4, 0) : const Offset(0.4, 0),
      end: Offset.zero,
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetTween.animate(animation),
        child: Container(
          margin: EdgeInsets.only(bottom: isLast ? 0 : 48, left: isSmall ? 0 : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accentColor.withOpacity(0.08), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isSmall ? 18 : 24,
                  horizontal: isSmall ? 16 : 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: isSmall
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.title,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: textColor,
                                        fontSize: isSmall ? 17 : 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: accentColor.withOpacity(0.13),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        job.company,
                                        style: GoogleFonts.firaMono(
                                          color: accentColor,
                                          fontSize: isSmall ? 13 : 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        job.title,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: textColor,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.13),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          job.company,
                                          style: GoogleFonts.firaMono(
                                            color: accentColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${job.location} • ${job.period}',
                      style: GoogleFonts.firaMono(
                        color: subtitleColor,
                        fontSize: isSmall ? 13 : 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: job.bullets.map((b) => _ExperienceBullet(text: b)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceJob {
  final String company;
  final String location;
  final String title;
  final String period;
  final List<String> bullets;
  _ExperienceJob({
    required this.company,
    required this.location,
    required this.title,
    required this.period,
    required this.bullets,
  });
}

class _ExperienceBullet extends StatelessWidget {
  final String text;
  const _ExperienceBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ', style: TextStyle(color: Color(0xFF64FFDA), fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Inter',
                color: const Color(0xFFAEB6C3),
                fontSize: isSmall ? 15 : 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 