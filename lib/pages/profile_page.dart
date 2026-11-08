import 'package:flutter/material.dart';

import '../models/user_profile_data.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final UserProfileData profile;

  const ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.fullName);
    _emailController = TextEditingController(text: widget.profile.email);
    _passwordController = TextEditingController(text: widget.profile.password);
    _confirmPasswordController =
        TextEditingController(text: widget.profile.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    widget.profile.fullName = _nameController.text.trim();
    widget.profile.email = _emailController.text.trim();
    widget.profile.password = _passwordController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Данные профиля проверены и обновлены')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              height: 112,
              width: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.grey.shade200,
              ),
              child: const Icon(Icons.person, size: 72),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 510),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      inputType: InputFieldType.fullName,
                      labelText: 'ФИО',
                      hintText: 'Введите ФИО',
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
                      hintText: 'Введите пароль',
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
                      onFieldSubmitted: (_) => _save(),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _save,
                      child: const Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
