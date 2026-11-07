import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portofolio/main.dart';
import 'package:portofolio/core/localization/app_locale.dart';

void main() {
  testWidgets('Portfolio app smoke and localization test',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const NazarulPortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    // Verify name appears
    expect(find.textContaining('Nazarul Qudri'), findsWidgets);

    // Verify certifications and Indonesian default
    expect(find.textContaining('Sertifikasi'), findsWidgets);

    // Test language switcher toggle to English
    LocaleController.instance.setLanguage(AppLanguage.en);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('Certifications'), findsWidgets);

    // Reset language to Indonesian
    LocaleController.instance.setLanguage(AppLanguage.id);
    await tester.pump(const Duration(milliseconds: 500));

    // Dispose
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 2));
  });
}
