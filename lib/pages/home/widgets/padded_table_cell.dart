import 'package:flutter/widgets.dart';

class PaddedTableCell extends StatelessWidget {
  final Widget child;

  const PaddedTableCell({required this.child, super.key});

  @override
  Widget build(BuildContext context) => TableCell(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: child,
        ),
      );
}
