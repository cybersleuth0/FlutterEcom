import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_Bloc.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_Event.dart';
import 'package:flutter_ecom/UI/Signup/Bloc/signup_State.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _mobileNumberCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
              //Name
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              //Mobile
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Mobile Number';
                  }
                  if (value.length != 10) {
                    return 'Mobile Number must be 10 digits';
                  }
                  return null;
                },
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              //email
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              //password
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  ).hasMatch(value)) {
                    return """Password must include:
                            - 1 Upper case
                            - 1 lowercase
                            - 1 Numeric Number
                            - 1 Special Character""";
                  }
                  return null;
                },
                controller: _passwordCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xffff650e),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: isPasswordVisible
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffff650e)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: !isPasswordVisible,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              //confirm password
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: _confirmPasswordCtrl,
                decoration: InputDecoration(
                  labelText: 'Repeat Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xffff650e),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffff650e)),

                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    child: isConfirmPasswordVisible
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined),
                  ),
                ),
                obscureText: !isConfirmPasswordVisible,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24.0),
              BlocListener<Signup_Bloc, Signup_State>(
                listener: (context, state) {
                  if (state is SignupLoadingState) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is SignupSuccessState) {
                    setState(() {
                      isLoading = false;
                    });
                    //Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.ROUTE_HOMEPAGE,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Sign Up Successful",
                            style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(10),));
                  }
                  if (state is SignupFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.errorMsg,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(10),
                    ));
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> mParams = {
                        "name": _nameCtrl.text.trim(),
                        "mobile_number": _mobileNumberCtrl.text.trim(),
                        "email": _emailCtrl.text.trim(),
                        "password": _passwordCtrl.text.trim(),
                      };
                      context.read<Signup_Bloc>().add(
                        Register_Event(bodyParams: mParams),
                      );
                    }
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
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
