part of 'currency_selected_bloc.dart';

sealed class CurrencySelectedState extends Equatable {
  const CurrencySelectedState();

  @override
  List<Object> get props => [];
}

final class CurrencySelectedInitial extends CurrencySelectedState {}

// currency selected update state
final class CurrencySelectedUpdated extends CurrencySelectedState {
  final String selectedCurrency;

  const CurrencySelectedUpdated(this.selectedCurrency);

  @override
  List<Object> get props => [selectedCurrency];
}
