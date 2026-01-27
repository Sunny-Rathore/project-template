import 'package:flutter/material.dart';
import 'package:task/l10n/app_localizations.dart';

extension SnackBarExtension on BuildContext {
  ScaffoldFeatureController showSnackBar(String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Text(message)));
  }
}

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}

// extension NavigationExtension on BuildContext {
//   Future<T?> navigateNamed<T>(String routeName, {Object? arguments}) {
//     return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
//   }
//
//   Future<T?> navigateNamedAndRemoveUntil<T>(
//     String newRouteName,
//     bool Function(Route<dynamic>) predicate, {
//     Object? arguments,
//   }) {
//     return Navigator.of(
//       this,
//     ).pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
//   }
//
//   void navigateBack<T extends Object?>([T? result]) {
//     return Navigator.of(this).pop(result);
//   }
// }

/// Extension on String to add camelCase conversion and other string utilities
extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String toCamelcase() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
