import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  UserAuthProvider _authProvider = UserAuthProvider();
  static final UserService _userService = UserService();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  User _myUser;
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // implement mapEventToState
    //
    if (event is GetUserEvent) {
      try {
        yield LoadingState();

        _myUser = await _userService.getCurrentUser(_authProvider.getUid());

        yield UserFoundState(
          msg: "User found succesfully!",
          currentUser: _myUser,
        );
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al leer el usuario",
        );
      }
    } else if (event is ChangeAccountImageByGalleryEvent) {
      try {
        File response = await _pickImageGallery();
        String imageUrl = await _uploadFile(response);
        if (imageUrl != null) {
          yield LoadingState();
          await updateField("image", imageUrl);
          print("User image updated!");
          _myUser = await _userService.getCurrentUser(_authProvider.getUid(),
              update: true);
          yield UserFoundState(
              msg: "User image updated succesfully!", currentUser: _myUser);
        } else {
          throw "Error";
        }
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al seleccionar la foto en galería :(",
        );
      }
    } else if (event is ChangeAccountImageByPhotoEvent) {
      try {
        File response = await _pickImageCamera();

        String imageUrl = await _uploadFile(response);
        if (imageUrl != null) {
          yield LoadingState();
          await updateField("image", imageUrl);
          print("User image updated!");
          _myUser = await _userService.getCurrentUser(_authProvider.getUid(),
              update: true);
          yield UserFoundState(
              msg: "User image updated succesfully!", currentUser: _myUser);
        } else {
          throw "Error";
        }
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al tomar la foto :(",
        );
      }
    } else if (event is ChangeBiographyEvent) {
      try {
        yield LoadingState();

        await users
            .doc(_authProvider.getUid())
            .update({"biography": event.newBiography});

        print("User biography updated!");

        _myUser = await _userService.getCurrentUser(_authProvider.getUid(),
            update: true);

        yield UserFoundState(
            msg: "User image updated succesfully!", currentUser: _myUser);
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al tomar la foto :(",
        );
      }
    } else if (event is LoadCarEvent) {
      try {
        yield LoadingState();

        _myUser = await _userService.getCurrentUser(_authProvider.getUid(),
            update: true);

        yield UserFoundState(
            msg: "User car updated succesfully!", currentUser: _myUser);
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al obtener la información del coche",
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

  Future<bool> updateField(String field, dynamic value) async {
    try {
      await users.doc(_authProvider.getUid()).update({"$field": value});
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<File> _pickImageGallery() async {
    final picker = ImagePicker();

    final PickedFile choosenImage = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );

    if (choosenImage.path == null) {
      return null;
    }

    return File(choosenImage.path);
  }

  Future<File> _pickImageCamera() async {
    final picker = ImagePicker();
    final PickedFile choosenImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );

    if (choosenImage.path == null) {
      return null;
    }
    return File(choosenImage.path);
  }
}
