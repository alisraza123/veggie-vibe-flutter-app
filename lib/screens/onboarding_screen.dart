import 'package:flutter/material.dart';
import 'package:veggie_vibe/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _currentPage == 1
                  ? Container(
                      key: const ValueKey(1),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF1F4035), Color(0xFF298453)],
                        ),
                      ),
                    )
                  : (_currentPage == 2)
                  ? Container(
                      key: const ValueKey(2),
                      color: const Color(0xFFd9ead3),
                    )
                  : Stack(
                      key: const ValueKey(0),
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/onboard_bg.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.1, 0.65],
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF1B3631).withOpacity(0.95),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    children: [
                      _buildSlide1(size, isLandscape),
                      _buildSlide2(size, isLandscape),
                      _buildSlide3(size, isLandscape),
                    ],
                  ),
                ),

                _buildBottomControls(size, isLandscape),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide1(Size size, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Welcome to\nVeggieVibe",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 40 : 40,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Snap any fruit or veggie →\ninstant AI classification",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isLandscape ? 18 : 18,
            ),
          ),
          SizedBox(height: isLandscape ? 10 : 40),
        ],
      ),
    );
  }

  Widget _buildSlide2(Size size, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF245841), Color(0xFF299C5B)],
              ),
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 15),
          const Text(
            "Powered by\nSmart AI",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Container(height: 1, width: 120, color: Colors.white24),

          const Spacer(),

          Image.asset(
            'assets/images/smart_ai.png',
            width: 80,
            color: Colors.white70,
          ),
          const SizedBox(height: 10),
          const Text(
            "Lightning-fast predictions\nusing TensorFlow Lite",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide3(Size size, bool isLandscape) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          SizedBox(height: isLandscape ? 10 : 30),
          Text(
            "Save & Explore",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: isLandscape ? 20 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Flexible(
            flex: isLandscape ? 4 : 8,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/images/dashboard_screen.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Track scans, discover\nnutrition, share with friends",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: isLandscape ? 14 : 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: isLandscape ? 5 : 20),
        ],
      ),
    );
  }

  Widget _buildBottomControls(Size size, bool isLandscape) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isLandscape ? 10 : 20,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildDot(index)),
            ),

            if (_currentPage == 2) ...[
              SizedBox(height: isLandscape ? 10 : 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  width: double.infinity,
                  height: isLandscape ? 45 : 56,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gradientStart.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: isLandscape ? 17 : 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ] else if (isLandscape)
              const SizedBox(height: 10)
            else
              const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == 2
            ? (index == _currentPage ? const Color(0xFF134f5c) : Colors.black12)
            : (index == _currentPage ? Colors.white : Colors.white38),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
