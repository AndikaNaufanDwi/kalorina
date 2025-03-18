import 'package:flutter/material.dart';

class BuildLoginBox extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Icon? prefixIcon;
  final TextEditingController controller; // Tambahkan controller

  const BuildLoginBox({
    Key? key,
    required this.hintText,
    required this.controller, // Tambahkan required controller
    this.isPassword = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _BuildLoginBoxState createState() => _BuildLoginBoxState();
}

class _BuildLoginBoxState extends State<BuildLoginBox> {
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
        controller: widget.controller, // Tambahkan controller
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Color(0xFFD8EDEE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.prefixIcon, // Gunakan prefixIcon dari parameter
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          suffixIcon:
              widget.isPassword
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
