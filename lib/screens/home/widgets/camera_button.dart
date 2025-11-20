import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraButton extends StatelessWidget {
  final Function(String imagePath) onImageCapture;
  final String buttonText;
  const CameraButton({super.key, required this.onImageCapture, required this.buttonText});

  Future<void> _takePhoto(BuildContext context) async {
    try {
      //request camera permision
      final status = await Permission.camera.request();
      if (status.isDenied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Camera permision is required to take photo'),
              backgroundColor: Colors.orange,
            )
          );
        }
        return;
      }
      if (status.isPermanentlyDenied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Camera premision denied, please enable in setting'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => openAppSettings(),
            ),
            ),

          );
        }
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 70, //compressed image

      );

      if (photo != null) {
        onImageCapture(photo.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erroe Taking Photo: ${e.toString()}'),
          backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _takePhoto(context),
      icon: Icon(Icons.camera_alt),
      label: Text(buttonText),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        )
      ),
    );
  }
}