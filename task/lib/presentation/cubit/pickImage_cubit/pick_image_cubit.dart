import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:task/domain/cubit/pickImage_cubit/pick_image_state.dart';

import '../../../services/media_services.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());
  Future<void> pickImage({
    CropStyle? cropStyle,
    CropAspectRatioPreset? cropAspectRatioPreset,
  }) async {
    String? pickedImage = await MediaServices.pickImageFromGallery();
    if (pickedImage != null) {
      String? cropImage = await MediaServices.cropImage(
        filepath: pickedImage,
        cropStyle: cropStyle,
        cropAspectRatioPreset: cropAspectRatioPreset,
      );
      if (cropImage != null) {
        emit(PickImageSuccess(cropImage));
      } else {
        emit(PickImageInitial());
      }
    } else {
      emit(PickImageInitial());
    }
  }

  Future<void> pickMultipleImage({
    CropStyle? cropStyle,
    CropAspectRatioPreset? cropAspectRatioPreset,
  }) async {
    List<String>? pickedImages = await MediaServices.pickMultipleImages();

    if (pickedImages != null) {
      List<String> croppedImages = [];
      for (var image in pickedImages) {
        String? croppedImage = await MediaServices.cropImage(
          filepath: image,
          cropStyle: cropStyle,
          cropAspectRatioPreset: cropAspectRatioPreset,
        );
        if (croppedImage != null) {
          croppedImages.add(croppedImage);
        }
      }
      if (croppedImages.isNotEmpty) {
        emit(PickMultipleImageSuccess(croppedImages));
      } else {
        emit(PickImageInitial());
      }
    } else {
      emit(PickImageInitial());
    }
  }
}
