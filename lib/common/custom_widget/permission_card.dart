import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_expansion_tile.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class PermissionsCard extends StatefulWidget {
  final String title;
  final Widget child;
  final bool? isFromMenu;
  final AppExpansionTileController tileController;

  const PermissionsCard({
    Key? key,
    required this.title,
    required this.child,
    required this.tileController,
    this.isFromMenu,
  }) : super(key: key);

  @override
  State<PermissionsCard> createState() => _PermissionsCardState();
}

class _PermissionsCardState extends State<PermissionsCard> {
  Color tileColor = light_blue_color;
  @override
  Widget build(BuildContext context) {
    return AppExpansionTile(
      changeTileColor: (value) {
        if (value) {
          setState(() {
            tileColor = regular_blue;
          });
        } else {
          setState(() {
            tileColor = light_blue_color;
          });
        }
      },
      iconColor: primary_color,
      textColor: primary_text_color,
      tileController: widget.tileController,
      initiallyExpanded: widget.isFromMenu ?? false,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      showBorders: false,
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      childrenPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      //..
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: text_style_title8.copyWith(
                      color: Colors.black, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),

      // Expanded content
      children: [
        // Collapse expansion tile button
        widget.child,
      ],
    );
  }
}
