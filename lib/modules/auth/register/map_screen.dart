import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/modules/auth/presentation/controller/auth_cubit.dart';
import 'package:store/modules/auth/presentation/screens/register_screen.dart';

import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

class MapScreen extends StatelessWidget {
  bool isMarket;
  MapScreen({required this.isMarket});
var searchController=TextEditingController();
  GoogleMapController ?_controller ;
  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [

                    GoogleMap(

                      onCameraMove: (pos)
                      {
                        AuthCubit.get(context).changeLocation(pos);
                        AuthCubit.get(context).lat=pos.target.latitude;
                        AuthCubit.get(context).lang=pos.target.longitude;
                        print(AuthCubit.get(context).lang);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      markers: Set<Marker>.from(AuthCubit.get(context).myMarker),
                      mapType: MapType.normal,
                      initialCameraPosition: AuthCubit.get(context).kGooglePlex!=null?AuthCubit.get(context).kGooglePlex!:kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller=controller;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        clipBehavior: Clip.antiAlias,
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: ()
                          {
                            print(isMarket);
                            AuthCubit.get(context).getNewAddress(AuthCubit.get(context).lat!,AuthCubit.get(context).lang!);
                            navigateTo(context, RegisterScreen(isMarket: isMarket,));
                          },

                          child: Text(
                            'انشاء الموقع الجديد',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,

                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100,left: 20),
                        child: FloatingActionButton(
                            onPressed: ()
                            {
                              AuthCubit.get(context).changeMarker(_controller!);
                            },
                          backgroundColor: Colors.white,
                          elevation: 3,
                          child: Icon(
                            Icons.api_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
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
