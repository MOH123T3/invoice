import 'package:autorepair/imports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  const CustomTextField(
      {Key? key,
      this.controller,
      this.label,
      this.prefixIcon,
      this.textInputType,
      this.validator,
      this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      style: GoogleFonts.poppins(color: Colors.black, fontSize: 10),
      decoration: InputDecoration(
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
