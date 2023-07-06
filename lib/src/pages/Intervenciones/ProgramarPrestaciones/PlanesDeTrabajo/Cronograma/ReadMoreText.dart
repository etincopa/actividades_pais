import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  ReadMoreText(this.text, {this.maxLength = 100});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText2;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.justify,
            isExpanded ? widget.text : widget.text.substring(0, widget.maxLength),
            style: textStyle,
          ),
          SizedBox(height: 4),
          if (widget.text.length > widget.maxLength)
            Text(
              textAlign: TextAlign.justify,
              isExpanded ? 'Ver menos' : 'Leer más',
              style: textStyle?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
