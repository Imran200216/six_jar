part of 'sliver_scroll_bloc.dart';

sealed class SliverScrollEvent extends Equatable {
  const SliverScrollEvent();

  @override
  List<Object> get props => [];
}


// Scroll Off Set changed
class ScrollOffsetChanged extends SliverScrollEvent {
  final double offset;

  const ScrollOffsetChanged(this.offset);

  @override
  // TODO: implement props
  List<Object> get props => [offset];
}
