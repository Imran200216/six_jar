part of 'on_boarding_bloc.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

}

final class OnBoardingInitial extends OnBoardingState {
  final int currentPage;

  const OnBoardingInitial({required this.currentPage});


  @override
  List<Object> get props => [currentPage];
}
