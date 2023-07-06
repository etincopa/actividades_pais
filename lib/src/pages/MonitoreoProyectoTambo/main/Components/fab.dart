import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class FabItem {
  const FabItem(this.title, this.icon, {this.onPress});

  final IconData icon;
  final VoidCallback? onPress;
  final String title;
}

class FabMenuItem extends StatelessWidget {
  const FabMenuItem(this.item, {Key? key}) : super(key: key);

  final FabItem item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 16),
      color: const Color.fromARGB(255, 216, 216, 248),
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 0,
      highlightElevation: 2,
      disabledColor: Colors.white,
      onPressed: item.onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(item.title),
          const SizedBox(width: 8),
          Icon(item.icon, color: color_06),
        ],
      ),
    );
  }
}

class ExpandedAnimationFab extends AnimatedWidget {
  const ExpandedAnimationFab({super.key, 
    required this.items,
    required this.onPress,
    required Animation animation,
  }) : super(listenable: animation);

  final List<FabItem> items;
  final VoidCallback onPress;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final transform = Matrix4.translationValues(
      -(screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: FabMenuItem(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 9),
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        FloatingActionButton(
          backgroundColor: color_06,
          onPressed: onPress,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
          ),
        ),
      ],
    );
  }
}
