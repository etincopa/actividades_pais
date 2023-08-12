import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final Color? color;
  final dynamic title;
  final dynamic subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
  const ColorTile(
      {Key? key,
      this.color = Colors.grey,
      this.title,
      this.subtitle,
      this.icon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: InkWell(
        splashColor: color,
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: color?.withOpacity(0.03),
          shadowColor: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: color),
                ),
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("solor widget"),
                      Text("solor widget1"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Transform.rotate(
                      angle: 90 * 23 / 180,
                      child: Icon(
                        Icons.chevron_left,
                        size: 18,
                        color: Colors.grey.shade200,
                      ),
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
