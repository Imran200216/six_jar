part of 'range_slider_bloc.dart';

sealed class RangeSliderEvent extends Equatable {
  const RangeSliderEvent();
}

class UpdateRangeSliderEvent extends RangeSliderEvent {
  final RangeValues newRange;
  const UpdateRangeSliderEvent(this.newRange);

  @override
  List<Object> get props => [newRange];
}

