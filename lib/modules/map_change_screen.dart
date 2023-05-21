import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/order/cubit/order_cubit.dart';

class MapChangeScreen extends StatelessWidget {
  var searchController=TextEditingController();


  GoogleMapController ?_controller ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
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
                        StoreAppCubit.get(context).changeLocation(pos);
                        if(!StoreAppCubit.get(context).isBill) {
                          StoreAppCubit
                              .get(context)
                              .lat = pos.target.latitude;
                          StoreAppCubit
                              .get(context)
                              .lng = pos.target.longitude;
                        }
                        if(StoreAppCubit.get(context).isBill)
                          {
                            OrderCubit.get(context).latBill=pos.target.latitude;
                            OrderCubit.get(context).lngBill=pos.target.longitude;
                          }
                        print(StoreAppCubit.get(context).lat);
                      },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      markers: Set<Marker>.from(StoreAppCubit.get(context).myMarker),
                      initialCameraPosition: StoreAppCubit.get(context).kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        StoreAppCubit.get(context).animateCamera(controller);
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
