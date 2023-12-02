import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';

class CustomTextField extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: kGreyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextFormField(
              style: TextStyle(
                color: kWhiteColor70.withOpacity(0.6),
              ),
              controller: textEditingController,
              focusNode: focusNode,
              obscureText: obsecuredField ?? false,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      color: kBlackColor.withOpacity(0.4),
                    ),
                prefixIconColor: kBlackColor.withOpacity(0.4),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    prefixIcon,
                    size: 23,
                  ),
                ),
                suffixIcon: isPasswordField == true
                    ? GestureDetector(
                        onTap: onSuffixIconTap,
                        child: Icon(
                          suffixIcon,
                          size: 23,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ),
        ...List.generate(
          errorList.length,
          (index) => Text(
            errorList[index],
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
      ],
    );
  }
}
