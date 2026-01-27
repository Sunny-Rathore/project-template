import 'package:equatable/equatable.dart';

sealed class PickImageState extends Equatable {
  const PickImageState();
}

final class PickImageInitial extends PickImageState {
  const PickImageInitial();

  @override
  List<Object?> get props => [];
}

final class PickImageSuccess extends PickImageState {
  final String imagePath;
  const PickImageSuccess(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

final class PickMultipleImageSuccess extends PickImageState {
  final List<String> images;
  const PickMultipleImageSuccess(this.images);

  @override
  List<Object?> get props => [images];
}
