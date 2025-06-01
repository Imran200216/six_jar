import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sliver_scroll_event.dart';
part 'sliver_scroll_state.dart';

class SliverScrollBloc extends Bloc<SliverScrollEvent, SliverScrollState> {
  SliverScrollBloc() : super(SliverScrollInitial()) {
    on<ScrollOffsetChanged>((event, emit) {
      if (event.offset > 250 && state is! ScrollCollapsedState) {
        emit(ScrollCollapsedState());
      } else if (event.offset <= 250 && state is! ScrollExpandedState) {
        emit(ScrollExpandedState());
      }
    });
  }
}
