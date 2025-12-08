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
            // Background Orbs/Glows for effect
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.5),
                      blurRadius: 100,
                      spreadRadius: 50,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentColor.withOpacity(0.4),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentColor.withOpacity(0.4),
                      blurRadius: 100,
                      spreadRadius: 50,
                    )
                  ],
                ),
              ),
            ),
            
            // Main Content
            SafeArea(
              child: ResponsiveCenter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Big Weather Icon/Image
                    const Icon(Icons.cloud_queue_rounded, size: 150, color: Colors.white),
                    // Or use an asset if available: Image.asset('lib/assets/weather_icons/sun_heavy_rain.png', height: 250),
                    
                    const SizedBox(height: 40),
                    
                    GlassContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                           Text("Weather", style: AppTheme.displayLarge),
                           Text("ForeCasts", style: AppTheme.displayLarge.copyWith(color: AppTheme.accentColor)),
                           const SizedBox(height: 20),
                           Text(
                            "Never get caught in the rain again. Stay ahead with accurate weather updates.", 
                            textAlign: TextAlign.center,
                            style: AppTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDB130),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFDDB130).withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Get Started", 
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}