import 'package:flutter/material.dart';

class SectionTitleFormField extends StatelessWidget {
  final String title;
  final bool topPadding;
  final Widget? trailing;
  const SectionTitleFormField({
    super.key,
    required this.title,
    this.trailing,
    this.topPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: (topPadding ? 16.0 : 0.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (trailing != null) trailing! else SizedBox.shrink(),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
