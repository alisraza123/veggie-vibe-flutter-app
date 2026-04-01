import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 40 : 20,
              vertical: 20,
            ),
            children: [
              _sectionHeader("Preferences"),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                value: _darkMode,
                activeThumbColor: Colors.green,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: const Text("Notifications"),
                value: _notifications,
                activeThumbColor: Colors.green,

                onChanged: (v) => setState(() => _notifications = v),
              ),
              const Divider(),
              _sectionHeader("Account"),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile Settings"),
                trailing: Icon(Icons.arrow_forward_ios, size: 14),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Language"),
                trailing: Icon(Icons.arrow_forward_ios, size: 14),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Help & Support"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => {Navigator.pushNamed(context, '/help')},
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF1B3B2F), // Darkest green (bottom-left)
                      Color(0xFF245841), // Medium green
                      Color(0xFF299C5B), // Lightest green (top-right)
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFFb4d455), // Lime color
                     foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},

                  child: const Text(
                    "Save Changes",
                    
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF45818e),
          fontSize: 16,
        ),
      ),
    );
  }
}
