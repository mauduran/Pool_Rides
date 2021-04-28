import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/utils/lists.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial());

  @override
  Stream<VehicleState> mapEventToState(
    VehicleEvent event,
  ) async* {
    if (event is ChangeImageByGalleryEvent) {
      try {
        dynamic response = await _pickImageGallery();
        if (response is String)
          yield ErrorState(
            error: response,
            errorEasy: "Algo salió mal al seleccionar la foto en galería :(",
          );
        else {
          File img = response;

          yield NewImageState(
            image: img,
            isNewImage: true,
          );
        }
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al seleccionar la foto en galería :(",
        );
      }
    } else if (event is ChangeImageByPhotoEvent) {
      try {
        dynamic response = await _pickImageCamera();
        if (response is String)
          yield ErrorState(
            error: response,
            errorEasy: "Algo salió mal al tomar la foto :(",
          );
        else {
          File img = response;

          yield NewImageState(
            image: img,
            isNewImage: true,
          );
        }
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al tomar la foto :(",
        );
      }
    } else if (event is UpdatedVehicleInformation) {
      //TODO: GUARDAR EN BASE DE DATOS

      try {
        // TODO: Primero subir la foto a Storage y luego obtener la url de la foto para colocarla en la siguiente interacción con la BD

        // TODO: Subir la información el nuevo registro de coche a la BD y modificar el usuario (agregando el coche en el user)
        cars.add(Car(
          model: (event.brand.toUpperCase() + " " + event.model.toUpperCase()),
          color: event.color.toUpperCase(),
          image: event.image.toString(),
        ));
        yield UpdatedSuccesfully(
            msg: "Auto agregado con éxito!", newCar: cars[cars.length - 1]);
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Ocurrió un error al actualizar la información :(",
        );
      }
    }
  }
}

Future<dynamic> _pickImageGallery() async {
  final picker = ImagePicker();

  final PickedFile choosenImage = await picker.getImage(
    source: ImageSource.gallery,
    maxHeight: 720,
    maxWidth: 720,
    imageQuality: 85,
  );

  if (choosenImage.path == null) {
    return "Error";
  }
  return File(choosenImage.path);
}

Future<dynamic> _pickImageCamera() async {
  final picker = ImagePicker();
  final PickedFile choosenImage = await picker.getImage(
    source: ImageSource.camera,
    maxHeight: 720,
    maxWidth: 720,
    imageQuality: 85,
  );

  if (choosenImage.path == null) {
    return "Error";
  }
  return File(choosenImage.path);
}
