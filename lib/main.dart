import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/portfolio_controller.dart';
import 'pages/home_page.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable network font fetching — bundle fonts locally instead
  // to avoid macOS sandbox SocketException on fonts.gstatic.com
  GoogleFonts.config.allowRuntimeFetching = false;

  // Register services
  Get.put(ThemeService(), permanent: true);
  Get.put(PortfolioController(), permanent: true);

  // Configure flutter_animate
  Animate.restartOnHotReload = true;

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return Obx(
      () => GetMaterialApp(
        title: 'Parth Savaliya | Flutter Developer',
        debugShowCheckedModeBanner: false,
        themeMode: themeService.themeMode,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        defaultTransition: Transition.fadeIn,
        home: const HomePage(),
      ),
    );
  }
}
