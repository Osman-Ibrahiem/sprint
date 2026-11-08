import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/auth/presentation/login_layout.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_glow.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_icon.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_institution_badge.dart';

/// Start-side brand pane (right in RTL) shown from the Expanded class up:
/// glow, logo, name, tagline and the institution badge.
class LoginBrandPane extends StatelessWidget {
  const LoginBrandPane({super.key});

  @override
  Widget build(BuildContext context) {
    return PaneScope(
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          final tokens = PaneScope.tokensOf(context);
          final type = AdaptiveTypography.of(PaneScope.of(context));

          return ExcludeSemantics(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Figma: glow is a circle as wide as the pane, fading to the
                // background before the pane edge (no seam with the form pane).
                LayoutBuilder(
                  builder: (context, constraints) => Center(
                    child: SizedBox.square(
                      dimension: constraints.maxWidth,
                      child: const SplashGlow(
                        radius: LoginLayout.brandGlowRadius,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SplashIcon(size: tokens.splashLogoSize),
                      Text(
                        l10n.appName,
                        style: type.displayXl.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: LoginLayout.brandTitleGap),
                      Text(
                        l10n.splashTagline,
                        style: type.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: tokens.splashEdgeInset),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SplashInstitutionBadge(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
