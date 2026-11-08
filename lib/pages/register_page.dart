import 'package:flutter/material.dart';

import '../models/user_profile_data.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    Navigator.pop<UserProfileData>(
      context,
      UserProfileData(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
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
                      'Регистрация',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 28),
                    CustomTextFormField(
                      inputType: InputFieldType.fullName,
                      labelText: 'ФИО',
                      hintText: 'Иванов Иван Иванович',
                      prefixIcon: const Icon(Icons.person_outline),
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 14),
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'example@mail.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 14),
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Минимум 6 символов',
                      prefixIcon: const Icon(Icons.security),
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    ),
                    const SizedBox(height: 14),
                    CustomTextFormField(
                      inputType: InputFieldType.confirmPassword,
                      labelText: 'Повторите пароль',
                      hintText: 'Повторите пароль',
                      prefixIcon: const Icon(Icons.security),
                      controller: _confirmPasswordController,
                      passwordController: _passwordController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: FilledButton(
                        onPressed: _submit,
                        child: const Text('Зарегистрироваться'),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Уже есть аккаунт?'),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Войдите'),
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
