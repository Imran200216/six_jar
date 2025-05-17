import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'range_slider_event.dart';
part 'range_slider_state.dart';


@Injectable()
class RangeSliderBloc extends Bloc<RangeSliderEvent, RangeSliderState> {
  RangeSliderBloc() : super(RangeSliderInitial()) {
    on<UpdateRangeSliderEvent>((event, emit) {
      emit(RangeSliderUpdated(event.newRange));
    });
  }
}
