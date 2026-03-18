import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _emailValid = false;
  bool _passMatch = false;

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final bool isLandscape = size.height < 500;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F1),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            
                            Spacer(flex: isLandscape ? 1 : 2),
                            
                            Column(
                              children: [
                                Text(
                                  "Join the",
                                  style: GoogleFonts.poppins(
                                    fontSize: isLandscape ? 22 : 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "VeggieVibe",
                                  style: GoogleFonts.poppins(
                                    fontSize: isLandscape ? 22 : 32,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E773F),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            
                            Spacer(flex: isLandscape ? 1 : 2),
          
                            
                            _buildTextField(_nameController, "Full Name", Icons.person_outline, null, isLandscape),
                            SizedBox(height: isLandscape ? 8 : 12),
                            _buildTextField(_emailController, "Email", Icons.email_outlined, _emailValid, isLandscape),
                            SizedBox(height: isLandscape ? 8 : 12),
                            _buildTextField(_passController, "Password", Icons.lock_outline, null, isLandscape, obscure: true),
                            SizedBox(height: isLandscape ? 8 : 12),
                            _buildTextField(_confirmPassController, "Confirm Password", Icons.lock_reset_outlined, _passMatch, isLandscape, obscure: true),
          
                            const Spacer(),
                            SizedBox(height: 10),
          
                            
                            _buildCreateAccountButton(isLandscape),
          
                            const Spacer(),
                            SizedBox(height: 5),
          
                            
                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Or continue with",
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[600], 
                                      fontSize: isLandscape ? 11 : 13,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
          
                            const Spacer(),
                            SizedBox(height: 5),
          
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialTile('assets/images/apple.png', isLandscape),
                                const SizedBox(width: 15),
                                _socialTile('assets/images/google.png', isLandscape),
                                const SizedBox(width: 15),
                                _socialTile('assets/images/facebook.png', isLandscape),
                              ],
                            ),
                            SizedBox(height: 5),
                            const Spacer(flex: 2),
          
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white, 
                                    fontSize: isLandscape ? 12 : 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {},
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white, 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: isLandscape ? 12 : 14,
                                       decoration: TextDecoration.underline,
                                      decorationColor: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildTextField(TextEditingController controller, String label, IconData prefixIcon, bool? isValid, bool isLandscape, {bool obscure = false}) {
    return Container(
      constraints: BoxConstraints(maxHeight: isLandscape ? 45 : 55),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.black87, fontSize: 13),
        onChanged: (v) {
          setState(() {
            if (label == "Email") _emailValid = v.contains('@');
            if (label == "Confirm Password") _passMatch = v == _passController.text;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: const Color(0xFF134f5c), size: isLandscape ? 18 : 22),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: isValid == null
              ? null
              : Icon(
                  isValid ? Icons.check_circle : Icons.cancel, 
                  color: isValid ? Colors.green : Colors.red,
                  size: isLandscape ? 18 : 22,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), 
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(bool isLandscape) {
    return Container(
      width: double.infinity,
      height: isLandscape ? 48 : 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E773F), Color(0xFF192523)],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          "Create Account",
          style: GoogleFonts.poppins(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: isLandscape ? 14 : 16,
          ),
        ),
      ),
    );
  }

  Widget _socialTile(String path, bool isLandscape) {
    double size = isLandscape ? 35 : 50;
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Image.asset(path, fit: BoxFit.contain),
    );
  }
}