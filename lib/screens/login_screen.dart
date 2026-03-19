import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final bool isLandscape = size.height < 500;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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

                            
                            Text(
                              "VeggieVibe",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: isLandscape ? 28 : 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Welcome back!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: isLandscape ? 14 : 18,
                                color: const Color(0xFFd9ead3),
                              ),
                            ),

                            
                            Spacer(flex: isLandscape ? 1 : 2),

                            
                            _buildTextField(_emailController, 'Email', Icons.email_outlined, isLandscape),
                            SizedBox(height: isLandscape ? 8 : 16),
                            _buildTextField(_passwordController, 'Password', Icons.lock_outline, isLandscape, obscure: true),

                            
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 208, 255, 0),
                                    fontSize: isLandscape ? 11 : 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            
                            const Spacer(),

                            
                            _buildLoginButton(isLandscape),

                            
                            // const Spacer(),
                            SizedBox(height: 15,),
                            
                            Row(
                              children: [
                                const Expanded(child: Divider(color: Colors.white38)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Or continue with",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isLandscape ? 10 : 13,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(color: Colors.white38)),
                              ],
                            ),

                            
                                                       SizedBox(height: 15,),

                            
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

                            
                            const Spacer(),
                           

                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isLandscape ? 12 : 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255), 
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 10),
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

  

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isLandscape, {bool obscure = false}) {
    return Container(
      constraints: BoxConstraints(maxHeight: isLandscape ? 45 : 55),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.black87, fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF134f5c), size: isLandscape ? 18 : 22),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
      ),
    );
  }

  Widget _buildLoginButton(bool isLandscape) {
    return Container(
      height: isLandscape ? 50 : 56, 
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
          'Login',
          style: TextStyle(
            fontSize: isLandscape ? 14 : 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      ),
      child: Image.asset(path, fit: BoxFit.contain),
    );
  }
}