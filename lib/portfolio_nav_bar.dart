import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:html' as html;

class PortfolioNavBar extends StatelessWidget {
  final bool showHamburger;
  final bool drawerOpen;
  final VoidCallback? onHamburgerTap;
  final void Function(String section)? onNavTap;
  const PortfolioNavBar({super.key, this.showHamburger = false, this.drawerOpen = false, this.onHamburgerTap, this.onNavTap});

  static const Color mint = Color(0xFF64FFDA);
  static const Color navBg = Color(0xFF112240);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 700;
    final isMedium = screenWidth < 1100;
    final navPadding = isSmall ? 4.0 : isMedium ? 12.0 : 24.0;
    final navHeight = isSmall ? 44.0 : 60.0;
    final logoSize = isSmall ? 28.0 : 40.0;
    final logoFontSize = isSmall ? 14.0 : 20.0;
    final navFontSize = isSmall ? 11.0 : 15.0;
    final navSpacing = isSmall ? 8.0 : 24.0;
    final resumeBtnWidth = isSmall ? double.infinity : null;
    final resumeBtnFontSize = isSmall ? 12.0 : 15.0;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: navPadding, vertical: 0),
        margin: EdgeInsets.only(top: isSmall ? 8 : 24, left: 0, right: 0),
        height: navHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular mint logo
            GestureDetector(
              onTap: () => onNavTap?.call('hero'),
              child: Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  color: mint,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: navBg,
                      fontWeight: FontWeight.bold,
                      fontSize: logoFontSize,
                      fontFamily: 'FiraMono',
                    ),
                  ),
                ),
              ),
            ),
            if (showHamburger)
              IconButton(
                icon: Icon(drawerOpen ? Icons.close : Icons.menu, color: mint, size: 28),
                onPressed: onHamburgerTap,
                tooltip: drawerOpen ? 'Close navigation menu' : 'Open navigation menu',
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _NavLink('01. About', fontSize: navFontSize, onTap: () => onNavTap?.call('about')),
                  SizedBox(width: navSpacing),
                  _NavLink('02. Experience', fontSize: navFontSize, onTap: () => onNavTap?.call('experience')),
                  SizedBox(width: navSpacing),
                  _NavLink('03. Skills', fontSize: navFontSize, onTap: () => onNavTap?.call('skills')),
                  SizedBox(width: navSpacing),
                  _NavLink('04. Projects', fontSize: navFontSize, onTap: () => onNavTap?.call('projects')),
                  SizedBox(width: navSpacing),
                  _NavLink('05. Contact', fontSize: navFontSize, onTap: () => onNavTap?.call('contact')),
                  SizedBox(width: isMedium ? 20 : 40),
                  _ResumeButton(
                    width: resumeBtnWidth,
                    fontSize: resumeBtnFontSize,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PortfolioNavBar.mint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    final double w = size.width, h = size.height;
    final double r = w / 2 - 2;
    final double centerX = w / 2, centerY = h / 2;
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * 3.1415926535 / 180;
      final x = centerX + r * math.cos(angle);
      final y = centerY + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NavLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final VoidCallback? onTap;
  const _NavLink(this.text, {Key? key, this.fontSize = 15.0, this.onTap}) : super(key: key);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Split '01. About' into number and text
    final parts = widget.text.split('. ');
    final number = parts[0] + '. ';
    final label = parts.length > 1 ? parts[1] : '';
    final mint = PortfolioNavBar.mint;
    final textColor = _isHovering ? mint : Color(0xFFCCD6F6);
    final numberColor = mint;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: GoogleFonts.firaMono(
                    color: _isHovering ? mint : mint,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.1,
                  ),
                ),
                TextSpan(
                  text: label,
                  style: GoogleFonts.firaMono(
                    color: textColor.withOpacity(_isHovering ? 1.0 : 0.85),
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatelessWidget {
  final double? width;
  final double fontSize;
  const _ResumeButton({this.width, this.fontSize = 15.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 36,
      child: OutlinedButton(
        onPressed: () {
          html.window.open('assets/sunad_cv.pdf', '_blank');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: PortfolioNavBar.mint, width: 1.5),
          foregroundColor: PortfolioNavBar.mint,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          minimumSize: const Size(0, 36),
          maximumSize: const Size(double.infinity, 36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: GoogleFonts.firaMono(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: PortfolioNavBar.mint,
          ),
        ).copyWith(
          foregroundColor: MaterialStateProperty.all(PortfolioNavBar.mint),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return PortfolioNavBar.mint.withOpacity(0.08);
              }
              return null;
            },
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return const BorderSide(color: PortfolioNavBar.mint, width: 2);
              }
              return const BorderSide(color: PortfolioNavBar.mint, width: 1.5);
            },
          ),
        ),
        child: Text(
          'Resume',
          style: GoogleFonts.firaMono(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: PortfolioNavBar.mint,
          ),
        ),
      ),
    );
  }
} 