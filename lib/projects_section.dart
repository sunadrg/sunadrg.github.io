import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:visibility_detector/visibility_detector.dart';

class Project {
  final String imageUrl;
  final String title;
  final String description;
  final String readMoreUrl;
  final List<String> tags;

  Project({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.readMoreUrl,
    required this.tags,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      readMoreUrl: json['readMoreUrl'],
      tags: List<String>.from(json['tags']),
    );
  }
}

Future<List<Project>> loadProjectsFromAssets() async {
  final String jsonString = await rootBundle.loadString('assets/projects.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((json) => Project.fromJson(json)).toList();
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  final int _staggerMs = 120;
  List<Project>? _projects;
  bool _animationsStarted = false;
  bool _hasBeenVisible = false;

  @override
  void dispose() {
    if (_controllers.isNotEmpty) {
      for (final c in _controllers) {
        c.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _startAnimations() async {
    if (_projects == null) return;
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: _staggerMs));
      _controllers[i].forward();
    }
  }

  void _initAnimations(int count) {
    _controllers = List.generate(count, (i) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    ));
    _fadeAnimations = _controllers.map((c) => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOut),
    )).toList();
    _slideAnimations = _controllers.map((c) => Tween<Offset>(
      begin: const Offset(0, 0.12), end: Offset.zero).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOut),
    )).toList();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasBeenVisible && info.visibleFraction > 0.2 && !_animationsStarted) {
      _hasBeenVisible = true;
      _animationsStarted = true;
      _startAnimations();
    }
    // Optionally, reset animation if section is not visible
    // if (info.visibleFraction < 0.05 && _animationsStarted) {
    //   _animationsStarted = false;
    //   for (final c in _controllers) {
    //     c.reset();
    //   }
    //   _hasBeenVisible = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 3;
    if (screenWidth < 900) {
      crossAxisCount = 2;
    }
    if (screenWidth < 600) {
      crossAxisCount = 1;
    }
    final accentColor = const Color(0xFF64FFDA); // Mint accent for heading, title, tags
    final cardBgColor = Colors.white.withOpacity(0.07);
    final textColor = const Color(0xFFCCD6F6);
    final subtitleColor = const Color(0xFFAEB6C3);
    final tagBgColor = accentColor.withOpacity(0.13);
    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth < 700 ? 12.0 : 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restore original heading style
            Row(
              children: [
                Text(
                  '04. ',
                  style: GoogleFonts.firaMono(
                    color: accentColor,
                    fontSize: screenWidth < 700 ? 18 : 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Projects',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: textColor,
                    fontSize: screenWidth < 700 ? 22 : 28,
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
            FutureBuilder<List<Project>>(
              future: loadProjectsFromAssets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load projects', style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No projects found', style: TextStyle(color: textColor)));
                }
                final projects = snapshot.data!;
                if (_projects == null || _projects!.length != projects.length) {
                  _projects = projects;
                  _initAnimations(projects.length);
                  _animationsStarted = false;
                  _hasBeenVisible = false;
                }
                return Center(
                  child: SizedBox(
                    width: crossAxisCount == 1
                        ? double.infinity
                        : (crossAxisCount * 360.0) + ((crossAxisCount - 1) * 32),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32,
                        mainAxisExtent: 500,
                      ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimations[index],
                          child: SlideTransition(
                            position: _slideAnimations[index],
                            child: Center(
                              child: SizedBox(
                                width: 340,
                                child: ProjectCard(
                                  project: projects[index],
                                  accentColor: accentColor,
                                  cardBgColor: cardBgColor,
                                  textColor: textColor,
                                  subtitleColor: subtitleColor,
                                  tagBgColor: tagBgColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final Color accentColor;
  final Color cardBgColor;
  final Color textColor;
  final Color subtitleColor;
  final Color tagBgColor;
  const ProjectCard({
    required this.project,
    required this.accentColor,
    required this.cardBgColor,
    required this.textColor,
    required this.subtitleColor,
    required this.tagBgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: accentColor.withOpacity(0.08), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              project.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: screenWidth < 600 ? 15 : 16,
                      color: subtitleColor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Implement navigation or launch URL
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Read More',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_right_alt, color: accentColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: project.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: tagBgColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: accentColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 