import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_toggle_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  String? _errorMessage;

  Future<void> _submit() async {
    final auth = ref.read(authServiceProvider);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Заповніть всі поля');
      return;
    }

    setState(() => _errorMessage = null);

    final user = _isLogin
        ? await auth.login(email, password)
        : await auth.register(email, password);

    if (user == null) {
      setState(() => _errorMessage = 'Помилка: неправильний email або пароль');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Трекер Звичок',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 50),

                Row(
                  children: [
                    AuthToggleButton(
                      text: 'Вхід',
                      isSelected: _isLogin,
                      onPressed: () => setState(() => _isLogin = true),
                      isLeft: true,
                    ),
                    AuthToggleButton(
                      text: 'Реєстрація',
                      isSelected: !_isLogin,
                      onPressed: () => setState(() => _isLogin = false),
                      isLeft: false,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Пароль',
                  icon: Icons.lock,
                  obscureText: true,
                ),

                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
                  ),

                const Spacer(),

                SizedBox(
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _isLogin ? 'Увійти' : 'Зареєструватися',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}