// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/layout/data/data_source/data_source.dart' as _i235;
import '../../features/layout/data/data_source/data_source_imp.dart' as _i43;
import '../../features/layout/data/repo_imp/repo_imp.dart' as _i722;
import '../../features/layout/domain/repo/repo.dart' as _i221;
import '../../features/layout/domain/use_case/move_use_case.dart' as _i443;
import '../../features/layout/presentation/manager/move_cubit.dart' as _i900;
import '../service/api_service.dart' as _i906;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i906.ApiService>(() => _i906.ApiService());
    gh.factory<_i900.MoveCubit>(() => _i900.MoveCubit(gh<_i443.MoveUseCase>()));
    gh.factory<_i235.DataSource>(
      () => _i43.DataSourceImp(gh<_i906.ApiService>()),
    );
    gh.factory<_i221.Repo>(() => _i722.RepoImp(gh<_i235.DataSource>()));
    gh.factory<_i443.MoveUseCase>(() => _i443.MoveUseCase(gh<_i221.Repo>()));
    return this;
  }
}
