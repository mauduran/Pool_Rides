import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/services/auth-service.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial());

  UserAuthProvider _authProvider = UserAuthProvider();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
      try {
        String imageUrl = await _uploadFile(event.image);

        if (imageUrl != null) {
          Car newCar = Car(
            color: event.color,
            model: event.model,
            year: event.year,
            brand: event.brand,
            image: imageUrl,
            plates: event.plates,
          );
          await updateField("car", newCar.toMap());
          print("User car updated!");

          yield UpdatedSuccesfully(
              msg: "Auto agregado con éxito!", newCar: newCar);
        } else {
          throw "Error";
        }
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Ocurrió un error al actualizar la información :(",
        );
      }
    }
  }

  Future<String> _uploadFile(File _selectedPicture) async {
    try {
      var stamp = DateTime.now();
      if (_selectedPicture == null) return null;
      // define upload task
      UploadTask task = FirebaseStorage.instance
          .ref("users/imagen_$stamp.png")
          .putFile(_selectedPicture);
      // execute task
      await task;
      // recuperar url del documento subido
      return await task.storage.ref("users/imagen_$stamp.png").getDownloadURL();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("Error al subir la imagen: $e");
      return null;
    } catch (e) {
      // error
      print("Error al subir la imagen: $e");
      return null;
    }
  }

  Future<bool> updateField(String field, Map<String, dynamic> value) async {
    try {
      await users.doc(_authProvider.getUid()).update({"$field": value});
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
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
}
