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
import 'package:six_jar/core/blocs/connectivity_bloc/connectivity_bloc.dart'
    as _i705;
import 'package:six_jar/features/currency_select/presentation/bloc/currency_selected_bloc.dart'
    as _i925;
import 'package:six_jar/features/my_expense/presentation/blocs/jar_selection_bloc/jar_selection_bloc.dart'
    as _i759;
import 'package:six_jar/features/my_expense/presentation/blocs/range_slider_bloc/range_slider_bloc.dart'
    as _i906;
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
    gh.factory<_i759.JarSelectionBloc>(() => _i759.JarSelectionBloc());
    gh.factory<_i906.RangeSliderBloc>(() => _i906.RangeSliderBloc());
    gh.factory<_i578.OnBoardingBloc>(() => _i578.OnBoardingBloc());
    gh.singleton<_i705.ConnectivityBloc>(() => _i705.ConnectivityBloc());
    gh.singleton<_i93.AppVersionBloc>(() => _i93.AppVersionBloc());
    gh.singleton<_i925.CurrencySelectedBloc>(
      () => _i925.CurrencySelectedBloc(),
    );
    return this;
  }
}
