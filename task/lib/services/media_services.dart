import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/theme/theme.dart';

class MediaServices {
  static Future<String?> pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  static Future<String?> pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  static Future<List<String>?> pickMultipleImages() async {
    try {
      final result = await ImagePicker().pickMultiImage(limit: 5);
      if (result.isNotEmpty) {
        List<String> selectedPaths = result.map((image) => image.path).toList();
        return selectedPaths;
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
    return null;
  }

  static Future<String?> cropImage({
    required String filepath,
    CropStyle? cropStyle,
    CropAspectRatioPreset? cropAspectRatioPreset,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filepath,
      uiSettings: [
        AndroidUiSettings(
          cropStyle: cropStyle ?? CropStyle.rectangle,
          initAspectRatio:
              cropAspectRatioPreset ?? CropAspectRatioPreset.ratio16x9,
          hideBottomControls: true,
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          // toolbarWidgetColor: appTheme.primary,
        ),
        IOSUiSettings(
          cropStyle: cropStyle ?? CropStyle.rectangle,
          hidesNavigationBar: true,
        ),
      ],
    );
    return croppedFile?.path;
  }

  // static Future<Media?> pickFilePathAndExtension() async {
  //   try {
  //     const int maxSizeBytes = 100 * 1024 * 1024; // 100 MB
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowCompression: true,
  //       compressionQuality: maxSizeBytes,
  //     );
  //     if (result != null) {
  //       String? filePath = result.files.single.path;
  //       String? fileName = result.files.single.name;
  //       String? fileExtension = p.extension(filePath ?? "");
  //       if (result.files.single.size > maxSizeBytes) {
  //         Fluttertoast.showToast(msg: 'Size more Then 100 Mb Cant be Selected');
  //       } else {
  //         return Media.fromJson({'path': filePath, 'extension': fileExtension, 'name': fileName});
  //       }
  //       return null;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static Future<Media?> pickVideoPathAndExtension() async {
  //   try {
  //     const int maxSizeBytes = 20 * 1024 * 1024; // 20 MB
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowCompression: true,
  //       compressionQuality: maxSizeBytes,
  //       type: FileType.video, // Restrict to video files
  //     );
  //     if (result != null) {
  //       String? filePath = result.files.single.path;
  //       String? fileName = result.files.single.name;
  //       String? fileExtension = p.extension(filePath ?? "");
  //       if (result.files.single.size > maxSizeBytes) {
  //         Fluttertoast.showToast(msg: 'Size more Then 20 Mb Cant be Selected');
  //       } else {
  //         return Media.fromJson({'path': filePath, 'extension': fileExtension, 'name': fileName});
  //       }
  //       return null;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static Future<String?> recordVideo() async {
    final pickVideo = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
    if (pickVideo != null) {
      return pickVideo.path;
    }
    return null;
  }
}

class Media {
  final String path;
  final String name;
  final String fileExtension;
  Media({required this.path, required this.name, required this.fileExtension});
  factory Media.fromJson(Map<String, dynamic> json) => Media(
    path: json['path'],
    name: json['name'],
    fileExtension: json['extension'],
  );
}
