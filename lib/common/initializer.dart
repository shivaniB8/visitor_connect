import 'package:flutter/widgets.dart';

class Initializer extends StatefulWidget {
  final Widget child;
  final Function(BuildContext)? init;

  const Initializer({
    Key? key,
    required this.child,
    this.init,
  }) : super(key: key);

  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  @override
  void initState() {
    super.initState();
    widget.init?.call(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
