import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  static const Color blueColor = Color(0xFF2196F3);
  static const Color textColor = Color(0xFF383838);
  static const Color hintColor = Color(0xFF777777);
  static const Color borderColor = Color(0xFFCCCCCC);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      _showMessage('Account details are valid!');
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 10, color: textColor),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 9, color: textColor)),
          ],
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: 37,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword && _obscurePassword,
            style: const TextStyle(color: textColor, fontSize: 11),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }

              if (label == 'Your email' &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value.trim())) {
                return 'Enter a valid email';
              }

              if (isPassword && value.length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 11, color: hintColor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 0,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 15,
                        color: textColor,
                      ),
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: blueColor, width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Colors.red),
              ),
              errorStyle: const TextStyle(fontSize: 9),
            ),
          ),
        ),
      ],
    );
  }

  // Social media icons
  Widget _buildSocialButton({
    required String assetPath,
    required double size,
    required String name,
  }) {
    return SizedBox(
      width: 45,
      height: 45,
      child: GestureDetector(
        onTap: () {
          _showMessage('$name sign-in will be added later');
        },
        child: Center(
          child: Image.asset(
            assetPath,
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Image error for $assetPath: $error');
              debugPrint('Stack trace: $stackTrace');

              return const Icon(
                Icons.broken_image,
                color: Colors.red,
                size: 22,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    const Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 36),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: blueColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              label: 'Your Username',
                              hint: 'Enter your username',
                              controller: _nameController,
                              icon: Icons.person_outline,
                            ),

                            const SizedBox(height: 25),

                            _buildTextField(
                              label: 'Your email',
                              hint: 'Enter your email',
                              controller: _emailController,
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 25),

                            _buildTextField(
                              label: 'Password',
                              hint: 'Enter your password',
                              controller: _passwordController,
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),

                            const SizedBox(height: 63),

                            SizedBox(
                              height: 41,
                              child: ElevatedButton(
                                onPressed: _signUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blueColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  _showMessage(
                                    'Sign in screen will be added later',
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(text: 'Already a user? '),
                                      TextSpan(
                                        text: 'Sign in',
                                        style: TextStyle(color: blueColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 13),

                            const Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Divider(
                      height: 1,
                      thickness: 0.7,
                      color: Color(0xFFD8D8D8),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          assetPath: 'assets/icons/facebook.png',
                          size: 35,
                          name: 'Facebook',
                        ),

                        const SizedBox(width: 15),

                        _buildSocialButton(
                          assetPath: 'assets/icons/instagram.png',
                          size: 35,
                          name: 'Instagram',
                        ),

                        const SizedBox(width: 15),

                        _buildSocialButton(
                          assetPath: 'assets/icons/twitter.png',
                          size: 35,
                          name: 'Twitter',
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
