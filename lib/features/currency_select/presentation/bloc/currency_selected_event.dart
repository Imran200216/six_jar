part of 'currency_selected_bloc.dart';

sealed class CurrencySelectedEvent extends Equatable {
  const CurrencySelectedEvent();
}

// currency selected event
class CurrencyUserSelectedEvent extends CurrencySelectedEvent {
  final String selectedCurrency;

  const CurrencyUserSelectedEvent(this.selectedCurrency);

  @override
  List<Object> get props => [selectedCurrency];
}
