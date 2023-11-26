import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class PrivacyPolicyTextAcceptance extends StatefulWidget {
  const PrivacyPolicyTextAcceptance({
    super.key,
  });

  @override
  State<PrivacyPolicyTextAcceptance> createState() =>
      _PrivacyPolicyTextAcceptanceState();
}

class _PrivacyPolicyTextAcceptanceState
    extends State<PrivacyPolicyTextAcceptance> {
  bool policyAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: policyAccepted,
          fillColor: MaterialStateProperty.all(kWhiteColor),
          side: BorderSide.none,
          checkColor: kGreenColor,
          onChanged: (value) {
            setState(() {
              policyAccepted = value!;
            });
          },
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 230),
          child: Text.rich(
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: kWhiteColor70,
                  fontSize: 12,
                ),
            TextSpan(
              text: 'By creating account, you agree to our ',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    policyAccepted = !policyAccepted;
                  });
                },
              children: [
                TextSpan(
                  text: 'terms of services ',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        decoration: TextDecoration.underline,
                        color: kWhiteColor70,
                        decorationColor: kWhiteColor70,
                        decorationThickness: 1.5,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  children: [
                    TextSpan(
                      text: 'and',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: kWhiteColor70,
                            fontSize: 12,
                          ),
                      children: [
                        TextSpan(
                          text: ' privacy policy',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: kWhiteColor70,
                                    color: kWhiteColor70,
                                    decorationThickness: 1.5,
                                  ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
