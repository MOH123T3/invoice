import 'package:autorepair/imports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  final ValueChanged? onSaved;
  const CustomTextField(
      {super.key,
      this.controller,
      this.label,
      this.prefixIcon,
      this.textInputType,
      this.validator,
      this.onChanged,
      this.onSaved});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      cursorHeight: 10,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      style: GoogleFonts.poppins(color: Colors.black, fontSize: 10),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 8),
        labelStyle: TextStyle(fontSize: 10),
        prefixIcon: prefixIcon,
        labelText: label,
        border: _border,
      ),
    );
  }

  InputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
  }
}
