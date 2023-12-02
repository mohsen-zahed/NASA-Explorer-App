import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/widgets/edit_image_profile_change_profile_widgets.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_elevated_button.dart';
import 'package:nasa_explorer_app_project/widgets/custom_list_tile_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  var userName = 'Sarah F. Kennedy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                EditImageProfileChangeImageWidgets(
                  name: userName,
                  onEditTap: () => showBottomSheetWidget(context),
                  onImageTap: () {},
                ),
                const SizedBox(height: 50),
                CustomListTileWidget(
                  text: 'Saved Posts',
                  leadingIcon: Icons.bookmark,
                  onListTileTap: () {},
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                ),
                const SizedBox(height: 10),
                CustomListTileWidget(
                  text: 'Shared Posts',
                  leadingIcon: Icons.content_paste_go_outlined,
                  onListTileTap: () {},
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                ),
                const SizedBox(height: 10),
                CustomListTileWidget(
                  text: 'Share app with friends',
                  leadingIcon: Icons.share,
                  onListTileTap: () {},
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                ),
                const SizedBox(height: 10),
                CustomListTileWidget(
                  text: 'Rate Us',
                  leadingIcon: Icons.thumb_up_alt_rounded,
                  onListTileTap: () {},
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                ),
                const SizedBox(height: 10),
                CustomListTileWidget(
                  text: 'About Us',
                  leadingIcon: Icons.warning_amber_rounded,
                  onListTileTap: () {},
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                ),
                const SizedBox(height: 50),
                Text(
                  'App ver. 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kGreyColor,
                        decoration: TextDecoration.underline,
                        wordSpacing: .1,
                        fontWeight: FontWeight.bold,
                        decorationColor: kGreyColor,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetWidget(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: kBackgroundColor,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomTextField(
                textEditingController: _textEditingController,
                hintText: 'Enter your new name',
              ),
            ),
            CustomElevatedButton(
              textButton: 'Submit',
              onPressed: () {
                if (_textEditingController.value.text.isNotEmpty) {
                  setState(() {
                    userName = _textEditingController.value.text;
                    Navigator.pop(context);
                    _textEditingController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
