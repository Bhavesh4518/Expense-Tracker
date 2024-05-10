

import 'package:expense_tracker/common/widgets/circular_widget.dart';
import 'package:expense_tracker/common/widgets/custom_edges.dart';
import 'package:flutter/material.dart';

class MyCurvedEdgeWidget extends StatelessWidget {
  const MyCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomCurvedEdges(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.yellow
        ),
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                  top: -150,
                  right: -250,
                  child: MyCircularWidget(backgroundColor: Colors.white.withOpacity(0.1),)),
              Positioned(
                  top: 100,
                  right: -300,
                  child: MyCircularWidget(backgroundColor: Colors.white.withOpacity(0.1),)),
              child,
            ],
          ),
        ),

      ),
    );
  }
}