import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String> validator;
  const CustomTextField({Key? key, required this.controller, required this.obscureText, required this.hintText, required this.onChanged,
  required this.validator}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: "*",
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.9), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: hintText,
          errorStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.grey.withOpacity(0.2),
      ),
      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
      validator: validator,
    );
  }

}