import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/navigation_provider.dart';

class NavigationBarBlur extends StatelessWidget {
  const NavigationBarBlur({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select(
      (NavigationProvider nav) => nav.selectedIndex,
    );
    final nav = context.read<NavigationProvider>();
    return Positioned(
      bottom: 30,
      left: 50,
      right: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey.withValues(alpha: 0.2)),
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottonBlur(
                  title: 'Главная',
                  iconButton: Icons.home,
                  index: 0,
                  suf: () {
                    nav.navigationBar(0);
                  },
                  isActive: selectedIndex,
                ),
                const SizedBox(width: 10),
                BottonBlur(
                  title: 'Полезное',
                  iconButton: Icons.local_hospital,
                  index: 1,
                  suf: () {
                    nav.navigationBar(1);
                  },
                  isActive: selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottonBlur extends StatelessWidget {
  const BottonBlur({
    super.key,
    required this.index,
    required this.title,
    required this.iconButton,
    required this.suf,
    required this.isActive,
  });
  final String title;
  final IconData iconButton;
  final int index;
  final VoidCallback suf;
  final int isActive;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: suf,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconButton,
                  color: isActive == index
                      ? const Color.fromRGBO(107, 109, 176, 1)
                      : Colors.blueGrey,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isActive == index
                          ? const Color.fromRGBO(107, 109, 176, 1)
                          : Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
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
