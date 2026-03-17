import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      const AssetImage('assets/images/logo_carrot.png'),
      context,
    ).then((_) {
      if (mounted) setState(() => _isImageLoaded = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isImageLoaded) {
      return const Scaffold(backgroundColor: AppTheme.primary);
    }

    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double h = constraints.maxHeight;
          final double w = constraints.maxWidth;
          final bool isLandscape = w > h;

          final double logoSize = isLandscape ? h * 0.25 : h * 0.25;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: logoSize,
                      width: logoSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: ClipOval(
                        child: Padding(
                          padding: EdgeInsets.all(logoSize * 0.15),
                          child: Image.asset(
                            'assets/images/logo_carrot.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.04),

                    Text(
                      "VeggieVibe",
                      style: GoogleFonts.poppins(
                        fontSize: isLandscape ? h * 0.04 : h * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: h * 0.05),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            double opacity = ((_controller.value * 3) - i)
                                .clamp(0.3, 1.0);
                            return Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(opacity),
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    SizedBox(height: h * 0.04),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                      child: Text(
                        "Loading your fresh vibes...\nIdentify. Learn. Vibe.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isLandscape ? h * 0.02 : h * 0.02,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
