import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'jar_selection_event.dart';
part 'jar_selection_state.dart';

@Injectable()
class JarSelectionBloc extends Bloc<JarSelectionEvent, JarSelectionState> {
  JarSelectionBloc() : super(JarSelectionState("")) {
    // Select Jar Event
    on<SelectJarEvent>((event, emit) {
      emit(JarSelectionState(event.selectedJarName));
    });

    // Clear Jar Event
    on<ClearJarSelectionEvent>((event, emit) {
      emit(JarSelectionState(""));
    });
  }
}
