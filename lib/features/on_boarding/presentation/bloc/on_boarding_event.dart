part of 'on_boarding_bloc.dart';

sealed class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();
}

class PageChangedEvent extends OnBoardingEvent {
  final int pageIndex;

  const PageChangedEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
