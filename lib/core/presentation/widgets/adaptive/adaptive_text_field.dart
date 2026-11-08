import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_metrics.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/app_platform.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';

/// Filled text field with a platform look.
/// Apple: squircle, 50 dp, no border at rest, lime 1 dp border + elevated fill
/// when focused. Material: 56 dp, 1 dp border, 2 dp lime border when focused.
/// Error state uses the error colour border and a caption below.
///
/// [leading] sits at the start side (right in RTL), [trailing] at the end.
class AdaptiveTextField extends StatefulWidget {
  const AdaptiveTextField({
    required this.hintText,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.errorText,
    this.leading,
    this.trailing,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.semanticLabel,
    super.key,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;

  /// Decorative start icon; excluded from semantics.
  final IconData? leading;

  /// Interactive end widget (e.g. visibility toggle). The caller sizes it to
  /// `FieldMetrics.trailingBox`; no extra padding is added around it.
  final Widget? trailing;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final String? semanticLabel;

  @override
  State<AdaptiveTextField> createState() => _AdaptiveTextFieldState();
}

class _AdaptiveTextFieldState extends State<AdaptiveTextField> {
  FocusNode? _ownedNode;
  bool _focused = false;

  FocusNode get _node => widget.focusNode ?? (_ownedNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _node.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(AdaptiveTextField old) {
    super.didUpdateWidget(old);
    if (old.focusNode != widget.focusNode) {
      (old.focusNode ?? _ownedNode)?.removeListener(_onFocus);
      _node.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _node.removeListener(_onFocus);
    _ownedNode?.dispose();
    super.dispose();
  }

  void _onFocus() {
    if (_node.hasFocus != _focused) {
      setState(() => _focused = _node.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final platform = AppPlatform.of(context);
    final m = FieldMetrics.of(platform);
    final type = AdaptiveTypography.of(PaneScope.of(context));
    final textStyle = (platform.isApple ? type.bodyLg : type.body).copyWith(
      color: AppColors.textPrimary,
    );
    final hasError = widget.errorText != null;

    final Color borderColor;
    final double borderWidth;
    if (hasError) {
      borderColor = AppColors.error;
      borderWidth = m.borderWidth;
    } else if (_focused) {
      borderColor = AppColors.accent;
      borderWidth = m.focusedBorderWidth;
    } else {
      borderColor = m.hasRestingBorder ? AppColors.border : Colors.transparent;
      borderWidth = m.borderWidth;
    }
    final fill = platform.isApple && _focused && !hasError
        ? AppColors.bgElevated
        : AppColors.bgSurface;
    final side = BorderSide(color: borderColor, width: borderWidth);
    final ShapeBorder shape = platform.isApple
        ? RoundedSuperellipseBorder(borderRadius: AppRadius.mdAll, side: side)
        : RoundedRectangleBorder(borderRadius: AppRadius.mdAll, side: side);

    const iconColor = AppColors.textSecondary;
    final leading = widget.leading;
    final hasBox = m.leadingBox > 0;

    final input = TextField(
      controller: widget.controller,
      focusNode: _node,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      style: textStyle,
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textStyle.copyWith(color: AppColors.textMuted),
        isCollapsed: true,
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );

    final row = Row(
      children: [
        if (leading != null)
          ExcludeSemantics(
            child: hasBox
                ? SizedBox.square(
                    dimension: m.leadingBox,
                    child: Icon(leading, size: m.iconSize, color: iconColor),
                  )
                : Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: m.edgePadding,
                      end: m.gap,
                    ),
                    child: Icon(leading, size: m.iconSize, color: iconColor),
                  ),
          )
        else
          SizedBox(width: m.edgePadding),
        Expanded(child: input),
        if (widget.trailing != null)
          IconTheme(
            data: IconThemeData(size: m.iconSize, color: iconColor),
            child: widget.trailing!,
          )
        else
          SizedBox(width: m.edgePadding),
      ],
    );

    return Semantics(
      label: widget.semanticLabel,
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: m.height,
            decoration: ShapeDecoration(color: fill, shape: shape),
            child: row,
          ),
          if (hasError) ...[
            const SizedBox(height: FieldMetrics.captionGap),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: FieldMetrics.captionInset,
              ),
              child: Text(
                widget.errorText!,
                style: type.xs.copyWith(color: AppColors.error),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
