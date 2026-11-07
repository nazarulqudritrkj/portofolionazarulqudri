// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void triggerWebDownload(String url, String fileName) {
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..target = '_blank';
  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}
