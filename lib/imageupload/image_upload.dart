import 'dart:io';
import 'package:flutter/material.dart';
// image picker for picking the image
//firebase storage for uploading the iage to firestore
// and, cloud firestore for saving the url for uploaded image to our application

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
// some initialize code
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

// image picker
  Future imagePickerMethod() async {
// picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        // showing a snackbar with error
        showSnackBar("No file selected", const Duration(milliseconds: 400));
      }
    });
  }

// uploading the image, then getting the download url and then
// adding that download url to our cloudfirestor

  Future uploadImage() async {
    Reference ref = FirebaseStorage.instance.ref().child("images");
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    print(downloadURL);
  }

// snackbar for showing erros
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Image Upload")),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          // for rounded rectangular clip
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
                height: 550,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text("Upload Image"),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red)),
                          child: Center(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                Expanded(
                                  child: _image == null
                                      ? const Center(
                                          child: Text("No Image Selected"))
                                      : Image.file(_image!),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      imagePickerMethod();
                                    },
                                    child: const Text("Select image")),
                                ElevatedButton(
                                    onPressed: () {
                                      uploadImage();
                                    },
                                    child: const Text("Upload image")),
                              ])),
                        )),
                  ],
                )),
          ),
        )));
  }
}
