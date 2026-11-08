import 'package:flutter/widgets.dart';

/// Window size classes (Material 3). Breakpoints mirror the Figma variable
/// `breakpoint/min-width` in the Layout collection.
enum SizeClass {
  compact(0),
  medium(600),
  expanded(840),
  large(1200);

  const SizeClass(this.minWidth);

  /// Smallest width (dp) that belongs to this class.
  final double minWidth;

  /// Resolves the class for [width]. Boundaries belong to the larger class
  /// (600 → medium, 840 → expanded, 1200 → large).
  static SizeClass fromWidth(double width) {
    if (width >= large.minWidth) return large;
    if (width >= expanded.minWidth) return expanded;
    if (width >= medium.minWidth) return medium;
    return compact;
  }

  /// Window-level class. Use for structure only (panes, navigation type).
  /// Inside a pane, use `PaneScope.of(context)` so sizes follow the pane.
  static SizeClass ofWindow(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  bool get isCompact => this == compact;

  /// True from [expanded] up.
  bool get isExpandedUp => index >= expanded.index;
}
