part of 'jar_selection_bloc.dart';

sealed class JarSelectionEvent extends Equatable {
  const JarSelectionEvent();
}

// Select Jar Event
class SelectJarEvent extends JarSelectionEvent {
  final String selectedJarName;

  const SelectJarEvent(this.selectedJarName);

  @override
  List<Object> get props => [selectedJarName];
}

// Clear Jar Selection Event
class ClearJarSelectionEvent extends JarSelectionEvent {
  const ClearJarSelectionEvent();

  @override
  List<Object> get props => [];
}
