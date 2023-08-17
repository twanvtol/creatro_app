import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:creatro_app/UI/Post/create_post_upload.dart';
import 'package:creatro_app/image_gallary_preview_button.dart';
import 'package:creatro_app/loading.dart';
import 'package:creatro_app/mobilescreenlayout.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:native_exif/native_exif.dart';

class CreatePostConcept extends StatefulWidget {
  final List<CameraDescription> cameras;
  CreatePostConcept({required this.cameras, Key? key}) : super(key: key);

  @override
  _CreatePostConceptState createState() => _CreatePostConceptState();
}

class _CreatePostConceptState extends State<CreatePostConcept> {
  late CameraController cameraController;
  late Future<void> initializeController;
  int cameraDirection = 0;
  int index = 0;

  @override
  void initState() {
    startCamera(cameraDirection);
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void startCamera(int cameraDirection) async {
    cameraController = CameraController(
      widget.cameras[cameraDirection],
      ResolutionPreset.max,
      enableAudio: false,
    );
    initializeController = cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                children: const [
                  Text(
                    "Blind picture time!",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "You can't see what picture you take",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        // when pressed back to workout page overview
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MobileScreenLayout(),
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            child: cameraButton(Alignment.bottomCenter, 50),
            onTap: () async {
              try {
                await initializeController;
                final file = await cameraController.takePicture();
                // final path = file.path;
                File imageFile = File(file.path);
                Uint8List image = imageFile.readAsBytesSync();
                // final exif = await Exif.fromPath(file.path);
                // final date = await exif.getOriginalDate();
                if (!mounted) {
                  return;
                }
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePostUpload(
                      uploadImage: image,
                      dateTime: DateTime.now(),
                    ),
                  ),
                );
              } catch (e) {
                // showAlertCard(
                //     "Oops!", "No images selected", Colors.black, 0, context);
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget button(PostPreview asset, Alignment alignment, double radius) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(
        left: 30,
        bottom: 40,
        right: 20,
      ),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(2, 2), blurRadius: 10),
        ],
      ),
      child: Center(
        child: asset,
      ),
    ),
  );
}

Widget cameraButton(Alignment alignment, double radius) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(
        left: 20,
        bottom: 50,
        right: 20,
      ),
      height: 85,
      width: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: const Color.fromARGB(255, 172, 172, 172),
          width: 3,
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(5, 5), blurRadius: 10),
        ],
      ),
    ),
  );
}
