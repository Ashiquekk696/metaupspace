import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/theme/app_theme.dart';
import 'package:metaupspace/core/ui/screen.dart';
import 'package:metaupspace/features/auth/bloc/login_bloc.dart';
import 'package:metaupspace/features/auth/bloc/login_event.dart';
import 'package:metaupspace/features/auth/bloc/login_state.dart';
import 'package:metaupspace/features/dashboard/pages/dashboard_page.dart';
import 'package:metaupspace/shared/widgets/glass_card.dart';
import 'package:metaupspace/shared/widgets/primary_gradient_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.8, -0.9),
            radius: 1.35,
            colors: [Color(0xFF312E81), AppColors.background],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<LoginBloc, Object>(
            listener: (context, state) {
              if (state is LoginOk) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: const Duration(milliseconds: 420),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return DashboardPage(profile: state.profile);
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              } else if (state is LoginBad) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final busy = state is LoginBusy;
              final screen = Screen.of(context);
              final horizontal = screen.gutter();
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontal,
                    vertical: 28,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screen.containerMaxWidth(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Metaupspace',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.6,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to your workspace dashboard.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 36),
                        GlassCard(
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Use your work email to continue.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  controller: emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.alternate_email_rounded,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  validator: (value) {
                                    final v = value?.trim() ?? '';
                                    if (v.isEmpty) {
                                      return 'Email is required';
                                    }
                                    final regex = RegExp(
                                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!regex.hasMatch(v)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: passwordCtrl,
                                  obscureText: obscure,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: AppColors.textSecondary,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscure = !obscure;
                                        });
                                      },
                                      icon: Icon(
                                        obscure
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 28),
                                PrimaryGradientButton(
                                  label: 'Continue',
                                  loading: busy,
                                  onPressed: busy
                                      ? null
                                      : () {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          context.read<LoginBloc>().add(
                                                LoginAttempted(
                                                  emailCtrl.text.trim(),
                                                  passwordCtrl.text,
                                                ),
                                              );
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Secure sign-in · Your data stays private',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

