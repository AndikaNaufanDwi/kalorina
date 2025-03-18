import 'package:flutter/material.dart';

class BuildSignUpBox extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Icon? prefixIcon;
  final TextEditingController? controller; // Tambahkan controller

  const BuildSignUpBox({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.controller, // Inisialisasi controller
  }) : super(key: key);

  @override
  _BuildSignUpBoxState createState() => _BuildSignUpBoxState();
}

class _BuildSignUpBoxState extends State<BuildSignUpBox> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextField(
        controller: widget.controller, // Gunakan controller di sini
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Color(0xFFD8EDEE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
