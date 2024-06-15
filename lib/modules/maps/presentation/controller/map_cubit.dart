import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/modules/profile/presentation/controller/profile_cubit.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  static MapCubit get(BuildContext context)=>BlocProvider.of(context);

  CameraPosition? kGooglePlex;

  var myMarker = [];
  double? lat;
  double? lng;
  bool isBill = false;

  void changeLocation(CameraPosition position) {
    myMarker.first = myMarker.first.copyWith(positionParam: position.target);
    emit(ChangeLocationState());
  }

  void animateCamera(GoogleMapController controller,BuildContext context) {
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex!));
    Marker marker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(ProfileCubit.get(context).userInformation!.lat!, ProfileCubit.get(context).userInformation!.lang!),
      //draggable: true
    );
    myMarker.add(marker);
    emit(AnimateCameraState());
  }

  void initialMap(BuildContext context) {
    kGooglePlex = CameraPosition(
        target: LatLng(ProfileCubit.get(context).userInformation!.lat!, ProfileCubit.get(context).userInformation!.lang!),
        zoom: 18.555);

    emit(InitialMapState());
  }
}
