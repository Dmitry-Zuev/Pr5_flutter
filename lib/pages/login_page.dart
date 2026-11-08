import 'package:flutter/material.dart';

import '../models/user_profile_data.dart';
import '../routes.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserProfileData? _registeredProfile;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _openRegistration() async {
    final result = await Navigator.pushNamed<UserProfileData>(
      context,
      Routes.register,
    );
    if (!mounted || result == null) return;

    setState(() => _registeredProfile = result);
    _emailController.text = result.email;
    _passwordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Регистрация завершена. Теперь войдите.')),
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Только учебная имитация. В реальном приложении нужен сервер.
    if (_registeredProfile != null &&
        (email != _registeredProfile!.email ||
            password != _registeredProfile!.password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверный email или пароль')),
      );
      return;
    }

    final profile = _registeredProfile ??
        UserProfileData(
          fullName: 'Пользователь',
          email: email,
          password: password,
        );

    FocusScope.of(context).unfocus();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.home,
          (route) => false,
      arguments: profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Добро пожаловать!\n'
                          'Войдите в свой аккаунт\n'
                          'Или создайте новый',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'example@mail.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 14),
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Введите пароль',
                      prefixIcon: const Icon(Icons.security),
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Восстановление пароля не реализовано'),
                            ),
                          );
                        },
                        child: const Text('Забыли пароль?'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 190,
                        child: FilledButton(
                          onPressed: _submit,
                          child: const Text('Войти'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 72),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Нет аккаунта?'),
                        TextButton(
                          onPressed: _openRegistration,
                          child: const Text('Зарегистрируйтесь'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
