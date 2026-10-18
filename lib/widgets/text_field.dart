import 'package:flutter/material.dart';

enum InputFieldType {
  fullName,
  email,
  password,
  confirmPassword,
}

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.fullName:
        final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
        if (!reg.hasMatch(text)) {
          return 'ФИО должно содержать только буквы и пробелы';
        }
        break;

      case InputFieldType.email:
        final reg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!reg.hasMatch(text)) {
          return 'Введите корректный email';
        }
        break;

      case InputFieldType.password:
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_-]).{6,}$',
        );
        if (!reg.hasMatch(text)) {
          return 'Минимум 6 символов: буквы, цифры и +, _ или -';
        }
        break;

      case InputFieldType.confirmPassword:
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_-]).{6,}$',
        );
        if (!reg.hasMatch(text)) {
          return 'Минимум 6 символов: буквы, цифры и +, _ или -';
        }

        if (widget.passwordController != null &&
            text != widget.passwordController!.text) {
          return 'Пароли не совпадают';
        }
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password ||
        widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      validator: _validator,
      obscureText: isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
