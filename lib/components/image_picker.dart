import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CocktailPhotoPicker extends StatefulWidget {
  const CocktailPhotoPicker({super.key});

  @override
  _CocktailPhotoPickerState createState() => _CocktailPhotoPickerState();
}

class _CocktailPhotoPickerState extends State<CocktailPhotoPicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Gestisci errori, ad esempio permessi negati
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nel caricare l\'immagine: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_image != null)
          Image.file(
            _image!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        else
          Container(
            width: 200,
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.photo, size: 100, color: Colors.white),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Galleria'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Fotocamera'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ],
    );
  }
}
