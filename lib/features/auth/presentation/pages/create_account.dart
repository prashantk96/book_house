import 'package:auto_route/auto_route.dart';
import 'package:book_house/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;
  bool agree = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xff252547),
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffD8D8E5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffD8D8E5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xff4960F9)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F7),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.replaceRoute(
                SuccessRoute(
                  title: 'Success',
                  subtitle:
                      'Congratulations, you have completed your registration!.',
                ),
              );
            }

            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff252547),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Enter your details below & free sign up",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xffC0BDD4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Name",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xff8E8EA0),
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: nameController,
                            decoration: fieldDecoration(hint: "Kristin Cooper"),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Your Email",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xff8E8EA0),
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: emailController,
                            decoration: fieldDecoration(
                              hint: "Cooper_Kristin@gmail.com",
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xff8E8EA0),
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: obscure,
                            decoration: fieldDecoration(
                              hint: "••••••••••",
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: agree,
                              onChanged: (v) {
                                setState(() {
                                  agree = v ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                "By creating an account you agree to our terms and conditions.",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xff8E8EA0),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4960F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (!agree) return;

                                    context.read<AuthBloc>().add(
                                      RegisterPressed(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                            child: state is AuthLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Create account",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xff8E8EA0),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.router.back();
                              },
                              child: Text(
                                "Log in",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff4960F9),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
