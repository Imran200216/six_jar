part of 'jar_selection_bloc.dart';

class JarSelectionState extends Equatable {
  final String selectedJar;
  const JarSelectionState(this.selectedJar);

  @override
  List<Object> get props => [selectedJar];
}
