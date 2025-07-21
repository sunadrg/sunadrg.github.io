import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroSection extends StatelessWidget {
  final void Function()? onGetInTouch;
  const HeroSection({super.key, this.onGetInTouch});

  static const Color background = Color(0xFF0A192F);
  static const Color mint = Color(0xFF64FFDA);
  static const Color subtitle = Color(0xFFAEB6C3);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    final isVerySmall = screenWidth < 400;
    final isMedium = screenWidth < 1100;
    final sectionHeight = isSmall ? null : isMedium ? 600.0 : 700.0;
    final nameFontSize = isSmall ? 34.0 : isMedium ? 56.0 : 56.0;
    final secondaryFontSize = isSmall ? 22.0 : isMedium ? 38.0 : 28.0;
    final descFontSize = isSmall ? 14.0 : isMedium ? 16.0 : 16.0;
    final buttonWidth = isSmall ? 180.0 : isMedium ? 220.0 : 260.0;
    final buttonFontSize = isSmall ? 13.0 : isMedium ? 15.0 : 16.0;
    final accentColor = Color(0xFF64FFDA);
    final horizontalPadding = isSmall ? 18.0 : 0.0;

    // --- Cursor style logic ---
    final nameText = isSmall ? 'Sunad R\nGundagatti.. ' : 'Sunad R Gundagatti.. ';
    final nameTextStyle = TextStyle(
      fontFamily: 'Inter',
      color: Color(0xFFCCD6F6),
      fontSize: isVerySmall ? nameFontSize * 0.92 : nameFontSize,
      fontWeight: FontWeight.w900,
      height: 1.08,
      letterSpacing: -1.5,
      fontVariations: [
        FontVariation('wght', 900),
      ],
    );
    final availableWidth = screenWidth - 2 * horizontalPadding;
    final textPainter = TextPainter(
      text: TextSpan(text: nameText, style: nameTextStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);
    final nameTextWidth = textPainter.size.width;
    final cursorChar = nameTextWidth > availableWidth ? '|' : '_';
    // --- End cursor style logic ---

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hey, my name is',
          style: GoogleFonts.firaMono(
            color: accentColor,
            fontSize: isSmall ? 15 : 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: isSmall ? 18 : 28),
        // Name and cursor: typing effect, then blinking cursor at end
        _AnimatedTypingNameWithCursor(
          nameText: nameText,
          nameTextStyle: nameTextStyle,
          cursorChar: cursorChar,
        ),
        SizedBox(height: isSmall ? 10 : 18),
        Text(
          "I craft mobile-first experiences\nusing Android & Flutter.",
          style: TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFFAEB6C3),
            fontSize: secondaryFontSize,
            fontWeight: FontWeight.w700,
            height: 1.18,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: isSmall ? 24 : 32),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Mobile App Developer with 2+ years of experience building fast, reliable Android apps (Java/Kotlin)\nand cross-platform solutions using Flutter. I focus on mobile-first design and love turning\nsimple ideas into clean, high-impact apps that just work — across any device.\nAlways learning. Always building.\nLet’s bring great ideas to life.",
            style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF8892B0).withOpacity(0.95),
              fontSize: descFontSize,
              fontWeight: FontWeight.w400,
              height: 1.6,
              letterSpacing: 0.1,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: isSmall ? 32 : 40),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: isSmall ? Alignment.centerLeft : Alignment.centerLeft,
                child: SizedBox(
                  width: buttonWidth,
                  height: isSmall ? 36 : 44,
                  child: OutlinedButton(
                    onPressed: onGetInTouch,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: accentColor, width: 1.5),
                      foregroundColor: accentColor,
                      backgroundColor: Colors.transparent,
                      textStyle: GoogleFonts.firaMono(
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Get In Touch', style: GoogleFonts.firaMono(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isSmall ? 12 : 24),
      ],
    );
    
    // New: Wrap in Row for large screens
    Widget layout = isSmall
        ? content
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text content (left)
              Expanded(flex: 2, child: content),
              // Illustration (right)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _AnimatedFloatingSvg(
                    assetPath: 'assets/images/illustration.svg',
                    height: 320, // Adjust as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          );
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: isSmall
          ? SingleChildScrollView(
              child: SizedBox(
                height: sectionHeight,
                child: layout,
              ),
            )
          : SizedBox(
              height: sectionHeight,
              child: layout,
            ),
    );
  }
}

class BlinkingCursor extends StatefulWidget {
  final double fontSize;
  final String cursorChar;
  const BlinkingCursor({super.key, required this.fontSize, this.cursorChar = '_'});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        margin: const EdgeInsets.only(left: 2),
        alignment: Alignment.bottomLeft,
        child: Text(
          widget.cursorChar,
          style: GoogleFonts.firaMono(
            color: Color(0xFF64FFDA),
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            height: 1.08,
            letterSpacing: -6,
          ),
        ),
      ),
    );
  }
}

class _AnimatedNameWithCursor extends StatefulWidget {
  final String nameText;
  final TextStyle nameTextStyle;
  final String cursorChar;
  const _AnimatedNameWithCursor({
    Key? key,
    required this.nameText,
    required this.nameTextStyle,
    required this.cursorChar,
  }) : super(key: key);

  @override
  State<_AnimatedNameWithCursor> createState() => _AnimatedNameWithCursorState();
}

class _AnimatedNameWithCursorState extends State<_AnimatedNameWithCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.nameText,
                style: widget.nameTextStyle,
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Opacity(
                  opacity: _controller.value,
                  child: Text(
                    widget.cursorChar,
                    style: widget.nameTextStyle.copyWith(
                      color: const Color(0xFF64FFDA),
                      fontWeight: FontWeight.bold,
                      letterSpacing: -6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedTypingNameWithCursor extends StatefulWidget {
  final String nameText;
  final TextStyle nameTextStyle;
  final String cursorChar;
  const _AnimatedTypingNameWithCursor({
    Key? key,
    required this.nameText,
    required this.nameTextStyle,
    required this.cursorChar,
  }) : super(key: key);

  @override
  State<_AnimatedTypingNameWithCursor> createState() => _AnimatedTypingNameWithCursorState();
}

class _AnimatedTypingNameWithCursorState extends State<_AnimatedTypingNameWithCursor> with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;
  late Animation<double> _cursorOpacity;
  int _currentLength = 0;
  bool _animationDone = false;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _startTyping();
  }

  Future<void> _startTyping() async {
    for (int i = 1; i <= widget.nameText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (!mounted) return;
      setState(() {
        _currentLength = i;
      });
    }
    setState(() {
      _animationDone = true;
    });
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_animationDone) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.nameText.substring(0, _currentLength),
            style: widget.nameTextStyle,
          ),
          FadeTransition(
            opacity: _cursorController,
            child: Text(
              widget.cursorChar,
              style: widget.nameTextStyle.copyWith(color: Color(0xFF64FFDA)),
            ),
          ),
        ],
      );
    } else {
      return _AnimatedNameWithCursor(
        nameText: widget.nameText,
        nameTextStyle: widget.nameTextStyle,
        cursorChar: widget.cursorChar,
      );
    }
  }
} 

// Animated floating and pulsing SVG widget
class _AnimatedFloatingSvg extends StatefulWidget {
  final String assetPath;
  final double height;
  final BoxFit fit;
  const _AnimatedFloatingSvg({
    Key? key,
    required this.assetPath,
    required this.height,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  State<_AnimatedFloatingSvg> createState() => _AnimatedFloatingSvgState();
}

class _AnimatedFloatingSvgState extends State<_AnimatedFloatingSvg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: 0, end: -18).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.045).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: child,
          ),
        );
      },
      child: SvgPicture.asset(
        widget.assetPath,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
} 