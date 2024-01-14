import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';

class EditImageProfileChangeImageWidgets extends StatefulWidget {
  const EditImageProfileChangeImageWidgets({
    super.key,
    required this.onEditTap,
    required this.name,
    required this.onCameraTap,
    required this.email,
    required this.urlImage,
    required this.isImageUploading,
    required this.onImageTap,
  });
  final String? urlImage;
  final String name;
  final String email;
  final VoidCallback onEditTap;
  final VoidCallback onCameraTap;
  final VoidCallback onImageTap;
  final bool isImageUploading;

  @override
  State<EditImageProfileChangeImageWidgets> createState() =>
      _EditImageProfileChangeImageWidgetsState();
}

class _EditImageProfileChangeImageWidgetsState
    extends State<EditImageProfileChangeImageWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: widget.onEditTap,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: kGreyColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Icon(Icons.edit),
                ),
              ),
            ),
            GestureDetector(
                onTap: widget.onImageTap,
                child: Container(
                  width: 130,
                  height: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: kWhiteColor),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: widget.urlImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: widget.urlImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const CircularProgressIndicator(),
                          ),
                  ),
                )),
            widget.isImageUploading
                ? Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : GestureDetector(
                    onTap: widget.onCameraTap,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: kGreyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(Icons.camera_alt_rounded),
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          widget.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kWhiteColor,
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          widget.email,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: kGreyColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: kGreyColor,
              ),
        ),
      ],
    );
  }
}
