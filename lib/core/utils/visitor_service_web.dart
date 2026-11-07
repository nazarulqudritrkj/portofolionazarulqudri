// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:convert';
import 'dart:html' as html;

/// Real-time live visitor counter service for Flutter Web
class VisitorService {
  static const int _baseCount = 1420;
  static const String _storageKey = 'nq_visitor_count';
  static const String _sessionKey = 'nq_visited_session';

  static Future<int> getAndIncrementCount() async {
    int current = _baseCount;

    // 1. Read cached count from local storage
    try {
      final cached = html.window.localStorage[_storageKey];
      if (cached != null) {
        final parsed = int.tryParse(cached);
        if (parsed != null && parsed >= _baseCount) {
          current = parsed;
        }
      }
    } catch (_) {}

    // 2. Increment count once per session
    try {
      final hasVisited = html.window.sessionStorage[_sessionKey] == 'true';
      if (!hasVisited) {
        current += 1;
        html.window.localStorage[_storageKey] = current.toString();
        html.window.sessionStorage[_sessionKey] = 'true';

        // 3. Sync with cloud counter API in background
        _syncCloudCounter(current);
      }
    } catch (_) {}

    return current;
  }

  static void _syncCloudCounter(int localCount) async {
    try {
      final request = await html.HttpRequest.getString(
        'https://api.counterapi.dev/v1/nazarulqudritrkj-portofolio/visitors/up',
      );
      final data = jsonDecode(request);
      if (data is Map && data['count'] != null) {
        final serverCount = int.tryParse(data['count'].toString());
        if (serverCount != null) {
          final total = _baseCount + serverCount;
          html.window.localStorage[_storageKey] = total.toString();
        }
      }
    } catch (_) {
      // Fallback silently without throwing
    }
  }
}

