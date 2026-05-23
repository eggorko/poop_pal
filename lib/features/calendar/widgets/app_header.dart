import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({required this.onTodayPressed, super.key});

  final VoidCallback onTodayPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 188,
      child: ClipPath(
        clipper: const HeaderClipper(),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFDDF8F0), Color(0xFFBEEADF)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 44),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.poopPal,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'PoopPal',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF084B52),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: 'Today',
                    onPressed: onTodayPressed,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.76),
                      foregroundColor: const Color(0xFF149994),
                      fixedSize: const Size(58, 58),
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.insightsBars,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  const HeaderClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..lineTo(0, size.height - 45)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height + 18,
        size.width,
        size.height - 45,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
