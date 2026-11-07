// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:convert';
import 'dart:html' as html;

/// Real-time live visitor counter service for Flutter Web (Organic Actual Count)
class VisitorService {
  static const String _storageKey = 'nq_real_visitors_v2';
  static const String _sessionKey = 'nq_real_visited_session';

  static Future<int> getAndIncrementCount() async {
    // 0. Clear any old baseline counter
    try {
      html.window.localStorage.remove('nq_visitor_count');
      html.window.sessionStorage.remove('nq_visited_session');
    } catch (_) {}

    int current = 1;

    // 1. Read cached count from local storage
    try {
      final cached = html.window.localStorage[_storageKey];
      if (cached != null) {
        final parsed = int.tryParse(cached);
        if (parsed != null && parsed > 0) {
          current = parsed;
        }
      }
    } catch (_) {}

    // 2. Increment count on session visit
    try {
      final hasVisited = html.window.sessionStorage[_sessionKey] == 'true';
      if (!hasVisited) {
        current += 1;
        html.window.localStorage[_storageKey] = current.toString();
        html.window.sessionStorage[_sessionKey] = 'true';

        // 3. Sync with cloud counter API for global real visitor tally
        _syncCloudCounter();
      }
    } catch (_) {}

    return current;
  }

  static void _syncCloudCounter() async {
    try {
      final request = await html.HttpRequest.getString(
        'https://api.counterapi.dev/v1/nazarulqudritrkj-portofolio/visitors/up',
      );
      final data = jsonDecode(request);
      if (data is Map && data['count'] != null) {
        final serverCount = int.tryParse(data['count'].toString());
        if (serverCount != null && serverCount > 0) {
          html.window.localStorage[_storageKey] = serverCount.toString();
        }
      }
    } catch (_) {
      // Fallback silently without throwing
    }
  }
}
