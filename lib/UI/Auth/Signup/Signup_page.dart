import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';
import 'package:lottie/lottie.dart';

import 'Bloc/signup_Bloc.dart';
import 'Bloc/signup_Event.dart';
import 'Bloc/signup_State.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  spacing: 0,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'Assets/LottieAnimations/login.json',
                      height: 250,
                      width: 250,
                    ),
                    Text('Sign Up', style: textTheme.displaySmall),
                    const SizedBox(height: 8.0),
                    Text(
                      'Create an account to start shopping!',
                      // style: TextStyle(fontSize: 16, color: Colors.black54),
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 26.0),
                    //Name
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
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
                            color: colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorScheme.primary),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //Mobile
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
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
                            color: colorScheme.primary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //email
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
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
                            color: colorScheme.primary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //password
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
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
                            color: colorScheme.primary,
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
                          border: OutlineInputBorder(),
                        ),
                        obscureText: !isPasswordVisible,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //confirm password
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
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
                            color: colorScheme.primary,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
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
                    ),
                    const SizedBox(height: 24.0),
                    BlocListener<Signup_Bloc, Signup_State>(
                      listener: (context, state) {
                        if (state is SignupLoadingState) {
                          Center(child: CircularProgressIndicator());
                          setState(() {
                            isLoading = true;
                          });
                        }
                        if (state is SignupSuccessState) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Sign Up Successful",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              elevation: 6.0,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                        if (state is SignupFailureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: colorScheme.surface,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      state.errorMsg,
                                      style: TextStyle(
                                        color: colorScheme.surface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              elevation: 6.0,
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
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
                            print(mParams["name"]);
                            print(mParams["mobile_number"]);
                            print(mParams["email"]);
                            print(mParams["password"]);

                            context.read<Signup_Bloc>().add(
                              Register_Event(bodyParams: mParams),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(
                                constraints: BoxConstraints(
                                  minHeight: 25,
                                  minWidth: 25,
                                ),
                                padding: EdgeInsets.zero,
                                color: colorScheme.primary,
                              )
                            : Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.ROUTE_LOGINPAGE);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color:
                                        colorScheme.brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),
                            TextSpan(
                              text: "Sign in",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xffff650e),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
