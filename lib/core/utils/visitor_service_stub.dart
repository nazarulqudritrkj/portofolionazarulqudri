/// Stub implementation for non-web platforms
class VisitorService {
  static const int _baseCount = 1420;

  static Future<int> getAndIncrementCount() async {
    return _baseCount;
  }
}

