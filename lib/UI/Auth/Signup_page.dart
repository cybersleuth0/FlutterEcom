import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _mobileNumberCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe3e3e3),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Create an account to start shopping!',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 26.0),
            TextFormField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color(0xffff650e),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff650e)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _mobileNumberCtrl,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: Color(0xffff650e),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff650e)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xffff650e),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff650e)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline, color: Color(0xffff650e)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff650e)),

                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordCtrl,
              decoration: InputDecoration(
                labelText: 'Repeat Password',
                prefixIcon: Icon(Icons.lock_outline, color: Color(0xffff650e)),

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff650e)),

                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle signup logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffff650e),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
