import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_colors.dart';

class CocktailImagePicker extends StatefulWidget {
  final Function(File image)? onImageSelected;

  const CocktailImagePicker({super.key, this.onImageSelected});

  @override
  State<CocktailImagePicker> createState() => _CocktailImagePickerState();
}

class _CocktailImagePickerState extends State<CocktailImagePicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _image = file);
      widget.onImageSelected?.call(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _pickImage(ImageSource.gallery),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.image,
              borderRadius: BorderRadius.circular(12),
              image: _image != null
                  ? DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _image == null
                ? const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 48,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            TextButton.icon(
              icon: const Icon(Icons.photo_library, color: AppColors.tapBarBackground),
              label: const Text("Galleria",  style: TextStyle(color: AppColors.tapBarBackground)),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              icon: const Icon(Icons.camera_alt, color: AppColors.tapBarBackground),
              label: const Text("Fotocamera", style: TextStyle(color: AppColors.tapBarBackground)),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ],
    );
  }
}
