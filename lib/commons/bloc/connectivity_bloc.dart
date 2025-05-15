import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';


@Singleton()
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    // Listen to connectivity changes (now returns a List<ConnectivityResult>)
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Determine if any of the results is not 'none' (i.e., we are connected)
      bool isConnected = results.any((result) => result != ConnectivityResult.none);
      add(ConnectivityChanged(isConnected));
    });

    // Handle the ConnectivityChanged event
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivitySuccess(event.isConnected));
      } else {
        emit(ConnectivityFailure());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
