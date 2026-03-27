import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart'; // Import your api file

class ResultScreen extends StatelessWidget {
  final File imageFile;
  final List<dynamic> results;

  const ResultScreen({
    super.key,
    required this.imageFile,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryDark = Color(0xFF134f5c);
    const Color accentTeal = Color(0xFF45818e);
    const Color limeGreen = Color(0xFFb4d455);
    const Color bgCanvas = Color(0xFFF0F4F3);

    final String topLabel = results.isNotEmpty ? results[0]['label'] : "Unknown";
    final double topConf = results.isNotEmpty ? results[0]['confidence'] : 0.0;
    bool hasSuggestions = results.length > 1;

    return Scaffold(
      backgroundColor: bgCanvas,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = constraints.maxWidth > constraints.maxHeight;

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: isLandscape ? 250.h : 400.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          bgCanvas,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: isLandscape ? 180.h : 320.h),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        color: bgCanvas,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: _buildHandle()),
                          SizedBox(height: 20.h),
                          _buildAIBadge(limeGreen, primaryDark),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  topLabel,
                                  style: GoogleFonts.poppins(
                                    fontSize: isLandscape ? 24.sp : 32.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryDark,
                                  ),
                                ),
                              ),
                              _buildCircularConfidence(
                                topConf,
                                limeGreen,
                                primaryDark,
                              ),
                            ],
                          ),
                          
                          // --- NUTRITION SECTION ADDED HERE ---
                          SizedBox(height: 25.h),
                          Text(
                            "Nutritional Values (per 100g)",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: primaryDark,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          _buildNutritionSection(topLabel, primaryDark),
                          // ------------------------------------

                          SizedBox(height: 30.h),
                          Text(
                            "Other Suggestions",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: primaryDark.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          if (!hasSuggestions)
                            _buildEmptyState(primaryDark)
                          else
                            _buildSuggestionsList(
                              results,
                              limeGreen,
                              primaryDark,
                            ),
                          SizedBox(height: 40.h),
                          _buildGradientButton(
                            context,
                            primaryDark,
                            accentTeal,
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40.h,
                left: 20.w,
                child: _buildBackButton(context),
              ),
            ],
          );
        },
      ),
    );
  }

  // API Integration Widget
  Widget _buildNutritionSection(String foodName, Color darkColor) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: NutritionService.getNutrition(foodName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Text("Nutrition info not available for this item.", 
                 style: TextStyle(color: Colors.grey, fontSize: 12.sp));
        }

        final nutra = snapshot.data!;
        return Column(
          children: [
            // Circular Progress Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildNutraCircle("Size", "${nutra['serving_size_g']}g", Colors.orange, 1.0),
                  _buildNutraCircle("Carbs", "${nutra['carbohydrates_total_g']}g", Colors.blue, 0.6),
                  _buildNutraCircle("Fat", "${nutra['fat_total_g']}g", Colors.red, 0.4),
                  _buildNutraCircle("Fiber", "${nutra['fiber_g']}g", Colors.green, 0.5),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Additional list info
            _buildNutraTile("Cholesterol", "${nutra['cholesterol_mg']} mg", Icons.local_fire_department),
            _buildNutraTile("Sugar", "${nutra['sugar_g']}g", Icons.bubble_chart),
            _buildNutraTile("Potassium", "${nutra['potassium_mg']}mg", Icons.waves),
          ],
        );
      },
    );
  }

  Widget _buildNutraCircle(String title, String value, Color color, double progress) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 55.h, width: 55.h,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(value, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          SizedBox(height: 5.h),
          Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildNutraTile(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Color(0xFF134f5c)),
          SizedBox(width: 10.w),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  // --- AAPKE PURANE WIDGETS (UNCHANGED) ---
  Widget _buildEmptyState(Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: color.withOpacity(0.5)),
          SizedBox(width: 10.w),
          Text(
            "No alternative matches found",
            style: TextStyle(color: color.withOpacity(0.6), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList(List results, Color lime, Color dark) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          for (int i = 1; i < results.length; i++) ...[
            _buildProgressMatch(
              results[i]['label'],
              results[i]['confidence'],
              lime,
              dark,
            ),
            if (i < results.length - 1) const Divider(),
          ],
        ],
      ),
    );
  }

  Widget _buildCircularConfidence(double val, Color lime, Color dark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 65.h,
          width: 65.h,
          child: CircularProgressIndicator(
            value: val,
            strokeWidth: 7,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(lime),
          ),
        ),
        Text(
          "${(val * 100).toInt()}%",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(BuildContext context, Color dark, Color teal) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(colors: [dark, teal]),
      ),
      child: Center(
        child: Text(
          "SAVE REPORT",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressMatch(String name, double percent, Color lime, Color dark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: dark, fontSize: 13.sp)),
              Text("${(percent * 100).toInt()}%", style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
            ],
          ),
          SizedBox(height: 5.h),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey.shade100,
            color: lime,
            minHeight: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildAIBadge(Color lime, Color dark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(color: dark, borderRadius: BorderRadius.circular(6.r)),
      child: Text("AI ANALYSIS", style: TextStyle(color: lime, fontSize: 9.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHandle() => Container(
    width: 40.w, height: 4.h,
    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
  );
  Widget _buildBackButton(BuildContext context) => InkWell(
    onTap: () => Navigator.pop(context),
    child: CircleAvatar(
      backgroundColor: Colors.black26,
      child: const Icon(Icons.arrow_back, color: Colors.white),
    ),
  );
}