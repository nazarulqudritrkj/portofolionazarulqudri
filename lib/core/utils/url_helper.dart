import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'web_downloader_stub.dart'
    if (dart.library.html) 'web_downloader_web.dart';

class UrlHelper {
  UrlHelper._();

  static Future<void> downloadCv({BuildContext? context}) async {
    const fileName = 'CV_Nazarul_Qudri_STRT.pdf';
    const relativeUrl = 'CV_Nazarul_Qudri_STRT.pdf';

    if (kIsWeb) {
      try {
        triggerWebDownload(relativeUrl, fileName);
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mengunduh berkas resmi CV Nazarul Qudri, S.Tr.T....'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      } catch (e) {
        debugPrint('Web download error: $e');
      }
    }

    await openUrl(relativeUrl, context: context);
  }

  static Future<void> openUrl(String url, {BuildContext? context}) async {
    // If it's a PDF on Web, trigger native direct file download
    if (kIsWeb && url.toLowerCase().endsWith('.pdf')) {
      final fileName = url.split('/').last;
      try {
        triggerWebDownload(url, fileName);
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mengunduh $fileName...'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        }
        return;
      } catch (e) {
        debugPrint('Direct web download error: $e');
      }
    }

    Uri uri = Uri.parse(url);
    if (!uri.hasScheme && kIsWeb) {
      uri = Uri.base.resolve(url);
    }

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (kIsWeb) {
          // Force launch on Web
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open link: $url'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static Future<void> sendEmail(String email, {String subject = '', String body = ''}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      debugPrint('Error sending email: $e');
    }
  }
}
