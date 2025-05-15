import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'currency_selected_event.dart';
part 'currency_selected_state.dart';


@Singleton()
class CurrencySelectedBloc
    extends Bloc<CurrencySelectedEvent, CurrencySelectedState> {
  CurrencySelectedBloc() : super(CurrencySelectedInitial()) {
    on<CurrencyUserSelectedEvent>((event, emit) {
      emit(CurrencySelectedUpdated(event.selectedCurrency));
    });
  }
}
