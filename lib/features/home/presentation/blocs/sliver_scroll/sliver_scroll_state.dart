part of 'sliver_scroll_bloc.dart';

sealed class SliverScrollState extends Equatable {
  const SliverScrollState();
  
  @override
  List<Object> get props => [];
}

final class SliverScrollInitial extends SliverScrollState {}


// Sliver Scroll Collapsed State
class ScrollCollapsedState extends SliverScrollState {}

// Sliver Scroll Expanded State 
class ScrollExpandedState extends SliverScrollState {}