import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom/UI/Auth/Login/Bloc/login_Bloc.dart';
import 'package:flutter_ecom/UI/Auth/Login/Bloc/login_State.dart';
import 'package:flutter_ecom/utils/constants/AppConstant.dart';
import 'package:lottie/lottie.dart';

import 'Bloc/login_Event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'Assets/LottieAnimations/login.json',
                      height: 250,
                      width: 250,
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Welcome back! Please login to your account.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20.0),
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorScheme.primary),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    //password
                    SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorScheme.primary),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: !isPasswordVisible,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    BlocListener<Signin_Bloc, Signin_State>(
                      listener: (context, state) {
                        if (state is LoginLoadingState) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        if (state is LoginSuccessState) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Login Successful",
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 6.0,
                              backgroundColor: colorScheme.secondary,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.all(10),
                            ),
                          ); //
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.ROUTE_HOMEPAGE,
                          );
                        }
                        if (state is LoginFailureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: colorScheme.surface,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      state.errorMsg,
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.surface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 6.0,
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          _passwordCtrl.clear();
                          _emailCtrl.clear();
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> mParams = {
                              "email": _emailCtrl.text.trim(),
                              "password": _passwordCtrl.text.trim(),
                            };
                            context.read<Signin_Bloc>().add(
                              Login_Event(bodyParams: mParams),
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
                                color: Colors.white,
                              )
                            : Text(
                                'Login',
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
                    Text(
                      'Forget Password ?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xffff650e),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.ROUTE_SIGNUP);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
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
                              text: "Sign up",
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
