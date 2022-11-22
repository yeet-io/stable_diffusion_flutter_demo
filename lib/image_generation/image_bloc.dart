import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class ImageEvent {}

class ImageLoadedEvent extends ImageEvent {
  final Image image;

  ImageLoadedEvent(this.image);
}

class ImageBloc extends Bloc<ImageEvent, Image?> {
  ImageBloc(super.initialState) {
    on<ImageLoadedEvent>((event, emit) => emit(event.image));
  }
}
