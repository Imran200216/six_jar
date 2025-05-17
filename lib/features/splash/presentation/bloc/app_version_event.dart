part of 'app_version_bloc.dart';

sealed class AppVersionEvent extends Equatable {
  const AppVersionEvent();
}

// Fetch App Version Event
class FetchAppVersionEvent extends AppVersionEvent {
  const FetchAppVersionEvent();

  @override
  List<Object> get props => [];
}
