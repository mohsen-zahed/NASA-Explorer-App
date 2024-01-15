import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.errorText,
    this.obsecuredField,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.isPasswordField,
    this.focusNode,
    this.textEditingController,
    this.textInputType,
    this.hintTextColor,
    this.prefixIconColor,
    this.maxLength,
  });
  final String hintText;
  final IconData? prefixIcon;
  final String? errorText;
  final bool? obsecuredField;
  final bool? isPasswordField;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final Color? hintTextColor;
  final Color? prefixIconColor;
  final int? maxLength;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGreyColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextFormField(
          keyboardType: widget.textInputType ?? TextInputType.text,
          maxLength: widget.maxLength,
          maxLines: null,
          style: TextStyle(
            color: kWhiteColor70.withOpacity(0.6),
          ),
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          obscureText: widget.obsecuredField ?? false,
          cursorColor: kWhiteColor,
          cursorOpacityAnimates: true,
          cursorRadius: const Radius.circular(10),
          decoration: InputDecoration(
            semanticCounterText: widget.maxLength == 40 ? '' : null,
            counterStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: kWhiteColor,
                ),
            hintText: widget.hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  color: widget.hintTextColor ?? kBlackColor.withOpacity(0.4),
                ),
            prefixIconColor:
                widget.prefixIconColor ?? kBlackColor.withOpacity(0.4),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                widget.prefixIcon,
                size: 23,
              ),
            ),
            suffixIcon: widget.isPasswordField == true
                ? GestureDetector(
                    onTap: widget.onSuffixIconTap,
                    child: Icon(
                      widget.suffixIcon,
                      size: 23,
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
