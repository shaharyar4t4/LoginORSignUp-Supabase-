import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile;

  //pick the image
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    // pick the image from the gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // update image preview
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  //upload the image
  Future uploadImage() async {
    if (_imageFile == null) return;

    // generate the unique file name
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = "uploads/$fileName";

    // upload the image on supabase
    await Supabase.instance.client.storage
        .from('images')
        .upload(path, _imageFile!)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image Uploaded Successfully"))))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to upload the image"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title:
            const Text("Upload Image", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _imageFile != null
                ? Image.file(_imageFile!)
                : const Text("No Image selected...."),

            // pick the image through button just preview
            ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text("Pick the image")),

            // uplaod the image on DB
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text("Upload the Image"))
          ],
        ),
      ),
    );
  }
}
