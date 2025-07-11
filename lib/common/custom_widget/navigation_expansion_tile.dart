import 'package:flutter/material.dart';

import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class NavigationExpansionTile extends StatefulWidget {
  final String iconPath;
  final String title;
  final List<Widget>? children;
  final Function(bool)? onExpansionChanged;
  final ExpansionTileController? controller;
  final bool initiallyExpanded;
  final double? width;
  final double? height;
  final Color? color;

  const NavigationExpansionTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.children,
    this.onExpansionChanged,
    this.controller,
    this.width, // Default width
    this.height, // Default height
    this.color, // Default color
    this.initiallyExpanded = false,
  });

  @override
  State<NavigationExpansionTile> createState() =>
      _NavigationExpansionTileState();
}

class _NavigationExpansionTileState extends State<NavigationExpansionTile> {
  bool _isExpanded = false; // Define _isExpanded here

  @override
  Widget build(BuildContext context) {
    int selectedTile = 0;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ExpansionTile(
          initiallyExpanded: selectedTile == 1,
          controller: widget.controller,
          onExpansionChanged: (newState) {
            if (newState) {
              setState(() {
                selectedTile = 1;
                _isExpanded = true;
              });
            } else {
              setState(() {
                selectedTile = 0;
                _isExpanded = false;
              });
            }
          },
          maintainState: true,
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
          backgroundColor: Colors.white24,
          leading: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Image.asset(
              widget.iconPath,
              width: widget.width,
              height: widget.height,
              color: _isExpanded ? Colors.white : dashboadrColor,
            ),
          ),
          title: Text(
            widget.title,
            style: AppStyle.titleLarge(context).copyWith(
                color: _isExpanded ? Colors.white : dashboadrColor,
                fontWeight: FontWeight.w400),
          ),
          children: widget.children ?? [],
        ),
      ),
    );
  }
}
