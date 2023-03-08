import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/card_type.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:flutter/material.dart';

String _formattedPokeIndex(int index) {
  return "";
}

String capitalizeFirstChar(String text) {
  if (text == null || text.length <= 1) {
    return text.toUpperCase();
  }

  return text[0].toUpperCase() + text.substring(1);
}

class TiteCard extends StatelessWidget {
  const TiteCard(
    this.homeOption, {
    required this.index,
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final int index;
  final VoidCallback onPress;
  final HomeOptions homeOption;

  List<Widget> _buildTypes() {
    final widgetTypes = homeOption.types!
        .map(
          (type) => Hero(
            tag: homeOption.name! + type,
            child: CardType(
              capitalizeFirstChar(type),
            ),
          ),
        )
        .expand(
          (item) => [
            item,
            const SizedBox(height: 6),
          ],
        );

    if (homeOption.aOnPress.isNotEmpty) {}

    return widgetTypes.take(widgetTypes.length - 1).toList();
  }

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: homeOption.name!,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  homeOption.name!,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 0.9,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 17, 17),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ..._buildTypes(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDecorations(double itemHeight) {
    return [
      Positioned(
        bottom: 8,
        right: 12,
        child: Hero(
          tag: homeOption.image!,
          child: Image.asset(
            homeOption.image!,
            fit: BoxFit.contain,
            width: itemHeight * 0.5,
            height: itemHeight * 0.5,
            alignment: Alignment.center,
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 14,
        child: Text(
          "x",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.12),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: homeOption.color!.withOpacity(0.12),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: homeOption.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildCardContent(),
                    ..._buildDecorations(itemHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
