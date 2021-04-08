part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class UpdatedVehicleInformation extends VehicleEvent {
  final String brand;
  final String model;
  final String plates;
  final String color;
  final int year;
  final File image;
  UpdatedVehicleInformation({
    @required this.brand,
    @required this.model,
    @required this.plates,
    @required this.color,
    @required this.year,
    @required this.image,
  });
  @override
  List<Object> get props => [
        brand,
        model,
        plates,
        color,
        year,
        image,
      ];
}

class ChangeImageByPhotoEvent extends VehicleEvent {}

class ChangeImageByGalleryEvent extends VehicleEvent {}
