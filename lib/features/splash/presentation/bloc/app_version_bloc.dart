import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

@Singleton()
class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  AppVersionBloc() : super(AppVersionInitial()) {
    on<FetchAppVersionEvent>(_onFetchAppVersion);
  }

  Future<void> _onFetchAppVersion(
    FetchAppVersionEvent event,
    Emitter<AppVersionState> emit,
  ) async {
    final info = await PackageInfo.fromPlatform();
    emit(AppVersionLoaded(info.version));
  }
}
