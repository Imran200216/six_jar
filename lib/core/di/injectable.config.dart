// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:six_jar/commons/bloc/connectivity_bloc.dart' as _i268;
import 'package:six_jar/core/service/hive_service.dart' as _i1002;
import 'package:six_jar/features/currency_select/presentation/bloc/currency_selected_bloc.dart'
    as _i925;
import 'package:six_jar/features/on_boarding/presentation/bloc/on_boarding_bloc.dart'
    as _i578;
import 'package:six_jar/features/splash/presentation/bloc/app_version_bloc.dart'
    as _i93;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i578.OnBoardingBloc>(() => _i578.OnBoardingBloc());
    gh.singleton<_i268.ConnectivityBloc>(() => _i268.ConnectivityBloc());
    gh.singleton<_i93.AppVersionBloc>(() => _i93.AppVersionBloc());
    gh.singleton<_i925.CurrencySelectedBloc>(
      () => _i925.CurrencySelectedBloc(),
    );
    gh.lazySingleton<_i1002.HiveService>(() => _i1002.HiveService());
    return this;
  }
}
