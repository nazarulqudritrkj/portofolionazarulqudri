import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey academicKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey competitionsKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  NavigationController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = scrollController.offset;
    final isScrolledNow = offset > 40;
    if (isScrolledNow != _isScrolled) {
      _isScrolled = isScrolledNow;
      notifyListeners();
    }
  }

  GlobalKey getKeyForIndex(int index) {
    switch (index) {
      case 0:
        return homeKey;
      case 1:
        return aboutKey;
      case 2:
        return academicKey;
      case 3:
        return projectsKey;
      case 4:
        return competitionsKey;
      case 5:
        return certificatesKey;
      case 6:
        return skillsKey;
      case 7:
        return contactKey;
      default:
        return homeKey;
    }
  }

  void scrollToSection(int index) {
    _currentIndex = index;
    notifyListeners();

    final key = getKeyForIndex(index);
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  void setIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}

