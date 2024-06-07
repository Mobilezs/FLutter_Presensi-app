// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_applikasipresensi/screen/dashboard_screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() {
//     return _LoginScreen();
//   }
// }

// class _LoginScreen extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _login() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please enter your username and password')),
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     const url =
//         'https://presensi.spilme.id/login'; // Replace with your server address
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'username': username,
//         'password': password,
//       }),
//     );
//     if (kDebugMode) {
//       print(response.statusCode);
//     } //tambahan
//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       final token = responseBody['token'];
//       //tamabahan
//       final name = responseBody['nama'];
//       final dept = responseBody['departemen'];
//       final imgUrl = responseBody['imgUrl'];

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('jwt', token);
//       //tambahan
//       await prefs.setString('name', name);
//       await prefs.setString('dept', dept);
//       await prefs.setString('imgProfil', imgUrl);

//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const DashboardScreen()),
//         (route) => false,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid username or password')),
//       );
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 80,
//               ),
//               Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     //Logo aplikasi
//                     Image.asset(
//                       'assets/images/logo_polbeng.png',
//                       height: 128,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                           text: 'Selamat Datang\ndi ',
//                           style: GoogleFonts.manrope(
//                             fontSize: 32,
//                             color: const Color(0xFF101317),
//                             fontWeight: FontWeight.w800,
//                           ),
//                           children: const [
//                             TextSpan(
//                                 text: 'PresensiApp',
//                                 style: TextStyle(
//                                     color: Color(0xFF12A3DA),
//                                     fontWeight: FontWeight.w800))
//                           ]),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'Halo, silahkan masuk untuk melanjutkan',
//                       style: GoogleFonts.manrope(
//                         fontSize: 14,
//                         color: const Color(0xFFACAFB5),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextField(
//                       controller: _usernameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Username',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           borderSide: BorderSide(color: Color(0xFF12A3DA)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           borderSide: BorderSide(color: Color(0xFF12A3DA)),
//                         ),
//                       ),
//                       //keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 24),
//                     // Password TextField
//                     TextField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         labelText: 'Password',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           borderSide: BorderSide(color: Color(0xFF12A3DA)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           borderSide: BorderSide(color: Color(0xFF12A3DA)),
//                         ),
//                         suffixIcon: Icon(Icons.visibility_off),
//                       ),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 8),
//                     //forgot password
//                     GestureDetector(
//                       onTap: () {
//                         if (kDebugMode) {
//                           print('lupa password tapped');
//                         }
//                       },
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Lupa Password?',
//                           style: GoogleFonts.manrope(
//                             fontSize: 14,
//                             color: const Color(0xFF9B59B6),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     // Login Button
//                     _isLoading
//                         ? const CircularProgressIndicator()
//                         // Login Button
//                         : ElevatedButton(
//                             onPressed: _login,
//                             style: ElevatedButton.styleFrom(
//                                 minimumSize: const Size(
//                                     double.infinity, 50), // width and height
//                                 backgroundColor: const Color(0xFF12A3DA),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                             child: Text(
//                               'Masuk',
//                               style: GoogleFonts.manrope(
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Masuk dengan sidik jari?',
//                       style: GoogleFonts.manrope(
//                         fontSize: 14,
//                         color: const Color(0xFF101317),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Fingerprint Tap
//                       },
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.fingerprint, size: 48, color: Colors.grey),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     // Register New Account
//                     GestureDetector(
//                       onTap: () {
//                         // Register Tap
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           style: GoogleFonts.manrope(
//                             fontSize: 14,
//                             color: const Color(0xFF101317),
//                           ),
//                           children: const [
//                             TextSpan(text: 'Belum punya akun? '),
//                             TextSpan(
//                               text: 'Daftar',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF9B59B6),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )));
//   }
// }

//punya saya oke
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_applikasipresensi/screen/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Add this boolean variable

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Please enter your username and password')),
        // );
        const SnackBar(
            content: Text('Please enter your username and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const url =
        'https://presensi.spilme.id/login'; // Replace with your server address
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (kDebugMode) {
      print(response.statusCode);
    } //tambahan
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final nik = responseBody['nik'];
      final token = responseBody['token'];
      //tambahan
      final name = responseBody['nama'];
      final dept = responseBody['departemen'];
      final imgUrl = responseBody['imgUrl'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
      //tambahan
      await prefs.setString('name', name);
      await prefs.setString('dept', dept);
      await prefs.setString('imgProfil', imgUrl);
      await prefs.setString('nik', nik);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text('Invalid username or password')),
        const SnackBar(content: Text('Invalid username or password')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Logo aplikasi
                    Image.asset(
                      'assets/images/logo_polbeng.png',
                      height: 128,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Selamat Datang\ndi ',
                        style: GoogleFonts.manrope(
                          fontSize: 32,
                          color: const Color(0xFF101317),
                          fontWeight: FontWeight.w800,
                        ),
                        children: const [
                          TextSpan(
                            text: 'PresensiApp',
                            style: TextStyle(
                              color: Color(0xFF12A3DA),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Halo, silahkan masuk untuk melanjutkan',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xFFACAFB5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF12A3DA)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF12A3DA)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Password TextField
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF12A3DA)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFF12A3DA)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 8),
                    //forgot password
                    GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print('lupa password tapped');
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lupa Password?',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: const Color(0xFF9B59B6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login Button
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(
                                  double.infinity, 50), // width and height
                              backgroundColor: const Color(0xFF12A3DA),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Masuk',
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    Text(
                      'Masuk dengan sidik jari?',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xFF101317),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Fingerprint Tap
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.fingerprint, size: 48, color: Colors.grey),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Register New Account
                    GestureDetector(
                      onTap: () {
                        // Register Tap
                      },
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: const Color(0xFF101317),
                          ),
                          children: const [
                            TextSpan(text: 'Belum punya akun? '),
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9B59B6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}