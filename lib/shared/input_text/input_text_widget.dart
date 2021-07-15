import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final bool readOnly;
  final String? Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final void Function()? onTap;
  final IconData icon;
  const InputTextWidget({
    Key? key,
    required this.label,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.validator,
    this.textInputType,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: textInputType,
        controller: controller,
        validator: validator,
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
