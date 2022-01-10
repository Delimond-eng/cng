import '../index.dart';

class CostumFormTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String errorText;
  final String expandedLabel;
  final TextEditingController controller;
  const CostumFormTextField({
    this.icon,
    this.hintText,
    this.errorText,
    this.expandedLabel,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: expandedLabel,
        hintText: '$hintText...',
        errorStyle: GoogleFonts.lato(
          color: Colors.red,
          fontSize: 12.0,
        ),
        hintStyle: GoogleFonts.lato(
          color: Colors.grey[500],
          fontStyle: FontStyle.italic,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.yellow[900],
          size: 16.0,
        ),
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
