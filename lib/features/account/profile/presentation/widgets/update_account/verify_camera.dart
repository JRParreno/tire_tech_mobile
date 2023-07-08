import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/widgets/update_account/verify_preview_photo.dart';

// A screen that allows users to take a picture using a given camera.
class VerifyCamera extends StatefulWidget {
  static const String routeName = 'camera-screen';

  final bool isFrontPhoto;

  const VerifyCamera({
    super.key,
    this.isFrontPhoto = true,
  });

  @override
  VerifyCameraState createState() => VerifyCameraState();
}

class VerifyCameraState extends State<VerifyCamera> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState(); // Obtain a list of the available cameras on the device.

    WidgetsBinding.instance.addPostFrameCallback((_) => setUpCamera());
  }

  Future<void> setUpCamera() async {
    final tempCameras = await availableCameras();

    // To display the current output from the Camera,
    // create a CameraController.
    setState(() {
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        tempCameras.first,
        // Define the resolution to use.
        ResolutionPreset.medium,
      );
    });
    _initializeControllerFuture = _controller!.initialize();
    setState(() {
      cameras = tempCameras;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller!);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            if (_controller != null) {
              _controller!.setFlashMode(FlashMode.off);

// Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller!.takePicture();

              if (!mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => VerifyPreviewPhoto(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                    isFrontPhoto: widget.isFrontPhoto,
                  ),
                ),
              );
            }
          } catch (e) {
            // If an error occurs, log the error to the console.
            // print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
