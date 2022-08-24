import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class InputField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final bool autoFocus;
  final TextInputType keyboardType;
  final int lines;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  const InputField({
    Key? key,
    this.obscureText = false,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.lines = 1,
    this.autoFocus = false,
    this.validator,
    this.onSaved, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hMargin,
      ),
      decoration: BoxDecoration(
        color: kGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(dRadius),
      ),
      child: TextFormField(
        style: blackTextStyle.copyWith(
          fontSize: 14,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: lines,
        autofocus: autoFocus,
        validator: validator,
        onSaved: onSaved,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: greyTextStyle.copyWith(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
