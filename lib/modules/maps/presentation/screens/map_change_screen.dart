import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/modules/maps/presentation/controller/map_cubit.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';

class MapChangeScreen extends StatelessWidget {
  final searchController=TextEditingController();
  GoogleMapController ?_controller ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit,MapState>(
      listener: (context,state)
      {
      },
      builder: (context,state)
      {
        return  Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    GoogleMap(

                      onCameraMove: (pos)
                      {
                        MapCubit.get(context).changeLocation(pos);
                        if(!MapCubit.get(context).isBill) {
                          MapCubit
                              .get(context)
                              .lat = pos.target.latitude;
                          MapCubit
                              .get(context)
                              .lng = pos.target.longitude;
                        }
                        if(MapCubit.get(context).isBill)
                          {
                            OrderCubit.get(context).latBill=pos.target.latitude;
                            OrderCubit.get(context).lngBill=pos.target.longitude;
                          }
                        print(MapCubit.get(context).lat);
                      },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      markers: Set<Marker>.from(MapCubit.get(context).myMarker),
                      initialCameraPosition: MapCubit.get(context).kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        MapCubit.get(context).animateCamera(controller,context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
