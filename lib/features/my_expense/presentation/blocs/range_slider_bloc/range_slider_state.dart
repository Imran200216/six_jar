part of 'range_slider_bloc.dart';

abstract class RangeSliderState {
  final RangeValues range;
  const RangeSliderState(this.range);
}

class RangeSliderInitial extends RangeSliderState {
  const RangeSliderInitial() : super(const RangeValues(0, 200000));
}

class RangeSliderUpdated extends RangeSliderState {
  const RangeSliderUpdated(super.newRange);
}