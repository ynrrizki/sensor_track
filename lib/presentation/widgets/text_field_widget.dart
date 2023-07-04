import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  bool? obscureText;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText!,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade100),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey[500],
          ),
          suffixIcon: widget.hintText.contains('Password')
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText!;
                    });
                  },
                  child: widget.obscureText!
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                )
              : null,
          errorText: errorText,
        ),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            errorText = widget.validator?.call(value);
          });
        },
      ),
    );
  }
}
