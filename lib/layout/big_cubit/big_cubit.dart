import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/big_cubit/states_big.dart';

class NetConnectionCubit extends Cubit<NetConnectionState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectivityStreamSubscription;

  NetConnectionCubit() : super(NetLoading()) {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(
              (result) {
            if (result == ConnectivityResult.none) {
             emit(emitNetDisConnected()) ;
            } else {
             emit(emitNetConnected()) ;
            }
          },
        );
  }
  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}