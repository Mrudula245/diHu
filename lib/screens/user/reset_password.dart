import 'package:dihub/common/validator.dart';
import 'package:dihub/services/auth_service.dart';
import 'package:dihub/widgets/appbutton.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  "Reset Your Password",
                  style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter your email and new password",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: isShowPassword,
                  validator: (value) {
                    return Validator.validatePassword(value);
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: const Icon(Icons.password, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: isShowConfirmPassword,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return Validator.validatePassword(value);
                  },
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.password, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(isShowConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          isShowConfirmPassword = !isShowConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AppButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AuthService _authService = AuthService();
                      try {
                        await _authService.resetPassword(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password reset email sent!')),
                        );
                        Navigator.pushNamed(context, 'login');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error resetting password: $e')),
                        );
                      }
                    }
                  },
                  title: "Reset Password",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
