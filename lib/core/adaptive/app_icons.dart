import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/app_platform.dart';

/// Icons picked per platform: SF-style (CupertinoIcons) on Apple,
/// outlined Material icons elsewhere.
abstract final class AppIcons {
  static IconData person(BuildContext context) =>
      AppPlatform.of(context).isApple
      ? CupertinoIcons.person
      : Icons.person_outline_rounded;

  static IconData lock(BuildContext context) => AppPlatform.of(context).isApple
      ? CupertinoIcons.lock
      : Icons.lock_outline_rounded;

  static IconData eye(BuildContext context) => AppPlatform.of(context).isApple
      ? CupertinoIcons.eye
      : Icons.visibility_outlined;

  static IconData eyeSlash(BuildContext context) =>
      AppPlatform.of(context).isApple
      ? CupertinoIcons.eye_slash
      : Icons.visibility_off_outlined;
}
