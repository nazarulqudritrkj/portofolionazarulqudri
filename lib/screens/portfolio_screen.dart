import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../core/constants/app_colors.dart';
import '../widgets/background/clean_island_background.dart';
import '../sections/navigation/floating_navbar.dart';
import '../sections/navigation/mobile_drawer.dart';
import '../sections/hero/hero_section.dart';
import '../sections/about/about_section.dart';
import '../sections/projects/projects_section.dart';
import '../sections/certifications/certifications_section.dart';
import '../sections/skills/skills_section.dart';
import '../sections/contact/contact_section.dart';
import '../sections/contact/footer.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late final NavigationController _navController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _navController = NavigationController();
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: MobileDrawer(navController: _navController),
      body: CleanIslandBackground(
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _navController.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Top spacing for floating navbar
                    const SizedBox(height: 90),

                    // 1. Hero Section
                    KeyedSubtree(
                      key: _navController.homeKey,
                      child: HeroSection(navController: _navController),
                    ),

                    // 2. About Section
                    KeyedSubtree(
                      key: _navController.aboutKey,
                      child: const AboutSection(),
                    ),

                    // 3. Projects Showcase
                    KeyedSubtree(
                      key: _navController.projectsKey,
                      child: const ProjectsSection(),
                    ),

                    // 4. Official Certifications & Training (11 Pelatihan Asli)
                    KeyedSubtree(
                      key: _navController.certificatesKey,
                      child: const CertificationsSection(),
                    ),

                    // 5. Skills & Tech Stack
                    KeyedSubtree(
                      key: _navController.skillsKey,
                      child: const SkillsSection(),
                    ),

                    // 6. Contact Section
                    KeyedSubtree(
                      key: _navController.contactKey,
                      child: const ContactSection(),
                    ),

                    // 7. Footer
                    Footer(
                      onScrollToTop: () => _navController.scrollToSection(0),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed Floating Glass Navbar at the Top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FloatingNavbar(
                navController: _navController,
                onOpenDrawer: _openDrawer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
