import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // ignore: prefer_typing_uninitialized_variables, unused_field
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      // source: ImageSource.camera,
      // maxHeight: 600,
      maxWidth: 600,
    );
    if (imageFile?.path != null) {
      setState(() {
        _storedImage = File(imageFile?.path as String);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile?.path as String);
      final savedImage = await File(imageFile?.path as String)
          .copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _takePicture();
            },
            label: Text(
              'Take picture',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            icon: Icon(
              Icons.camera,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
