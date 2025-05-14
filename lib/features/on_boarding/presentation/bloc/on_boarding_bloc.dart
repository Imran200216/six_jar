import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

@Injectable()
class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingInitial(currentPage: 0)) {
    on<PageChangedEvent>((event, emit) {
      emit(OnBoardingInitial(currentPage: event.pageIndex));
    });
  }
}
