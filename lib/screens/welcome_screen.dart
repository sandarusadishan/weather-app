import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_center.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Stack(
          children: [
            
            // Main Content
            SafeArea(
              child: ResponsiveCenter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      
                      // Hero Section
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.white.withOpacity(0.4),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.2),
                              blurRadius: 50,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.wb_sunny_rounded, // Premium Sun Icon
                          size: 140,
                          color: AppTheme.accentColor,
                        ),
                      ),
                      
                      const SizedBox(height: 60),
                      
                      // Text Section
                      Column(
                        children: [
                          Text(
                            "Discover the",
                            style: AppTheme.titleLarge.copyWith(
                              color: AppTheme.mediumText, 
                              fontSize: 24,
                              letterSpacing: 1.2
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Weather",
                            style: AppTheme.displayLarge.copyWith(
                              color: AppTheme.primaryColor,
                              fontSize: 56,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Plan your day with accurate forecasts and real-time updates.",
                              textAlign: TextAlign.center,
                              style: AppTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
            
                      const Spacer(),
            
                      // Call to Action
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (_) => const HomeScreen())
                          ),
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Get Started",
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
