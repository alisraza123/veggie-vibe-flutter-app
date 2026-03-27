import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'result_screen.dart';

// Global Data
List<Map<String, dynamic>> recentScans = [];
List<Map<String, dynamic>> favoriteItems = [];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();

  void toggleFavorite(Map<String, dynamic> scan) {
    setState(() {
      if (favoriteItems.contains(scan)) {
        favoriteItems.remove(scan);
      } else {
        if (favoriteItems.length < 5) {
          favoriteItems.add(scan);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF1B3B2F), Color(0xFF245841), Color(0xFF299C5B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 15),
                _buildGreeting(),
                const SizedBox(height: 30),
                
                // Recent Scans Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent Scans", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                    _buildNavButtons(),
                  ],
                ),
                const SizedBox(height: 15),
                _buildRecentScansPager(),

                const SizedBox(height: 30),
                
                // Favorites Section
                Text("Your Favorite Items", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 15),
                _buildFavoritesSection(),
                
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Good morning, Alex ✨", style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 5),
        Text("${recentScans.length} scans • ${favoriteItems.length} favorites", 
          style: GoogleFonts.poppins(color: const Color(0xFFd9ead3).withOpacity(0.8), fontSize: 13)),
      ],
    );
  }

  // Horizontal Paging for Recent Scans (3 items per page)
  Widget _buildRecentScansPager() {
    if (recentScans.isEmpty) {
      return Container(height: 100, alignment: Alignment.center, child: const Text("No scans yet", style: TextStyle(color: Colors.white54)));
    }

    // Split list into chunks of 3
    List<List<Map<String, dynamic>>> pages = [];
    for (var i = 0; i < recentScans.length; i += 3) {
      pages.add(recentScans.sublist(i, i + 3 > recentScans.length ? recentScans.length : i + 3));
    }

    return SizedBox(
      height: 280, // Height for 3 vertical items
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return Column(
            children: pages[index].map((scan) => _buildScanCard(scan)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildScanCard(Map<String, dynamic> scan) {
    bool isFav = favoriteItems.contains(scan);
    return Container(
      
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(scan['image'], height: 40, width: 40, fit: BoxFit.cover)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(scan['label'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                Text("${(scan['confidence'] * 100).toInt()}% Confidence", style: const TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
          // Add to Fav Button
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.redAccent : Colors.white70, size: 20),
            onPressed: () => toggleFavorite(scan),
          ),
          // View Details Button
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(imageFile: scan['image'], results: scan['allResults']))),
            style: TextButton.styleFrom(backgroundColor:Colors.lime),
            child: const Text("View", style: TextStyle(color:Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesSection() {
    if (favoriteItems.isEmpty) {
      return _buildFavoriteTile(null); // Show placeholder
    }
    return Column(
      children: favoriteItems.map((fav) => _buildFavoriteTile(fav)).toList(),
    );
  }

  Widget _buildFavoriteTile(Map<String, dynamic>? fav) {
    bool isEmpty = fav == null;
    return GestureDetector(
      onTap: () {
        if (!isEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(imageFile: fav['image'], results: fav['allResults'])));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left Image or Placeholder
            Container(
              height: 50, width: 50,
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
              child: isEmpty ? const Icon(Icons.eco, color: Colors.white24) : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(fav['image'], fit: BoxFit.cover)),
            ),
            const SizedBox(width: 15),
            // Middle Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isEmpty ? "Scanning..." : fav['label'], style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                  Text(isEmpty ? "0% Confidence" : "${(fav['confidence'] * 100).toInt()}% Confidence", style: const TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            // Right Circular Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 40, width: 40,
                  child: CircularProgressIndicator(
                    value: isEmpty ? 0.0 : fav['confidence'],
                    strokeWidth: 4,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFb4d455)),
                  ),
                ),
                Text(isEmpty ? "0%" : "${(fav['confidence'] * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Row(
      children: [
        _circleNavBtn(Icons.chevron_left, () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)),
        const SizedBox(width: 10),
        _circleNavBtn(Icons.chevron_right, () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)),
      ],
    );
  }

  Widget _circleNavBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white24), color: Colors.white10),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}