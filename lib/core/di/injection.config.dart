// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:social_media_app/core/config/app_config.dart' as _i420;
import 'package:social_media_app/core/di/register_module.dart' as _i542;
import 'package:social_media_app/core/network/network_info.dart' as _i1057;
import 'package:social_media_app/data/repositories/auth_repository_impl.dart'
    as _i1022;
import 'package:social_media_app/domain/repositories/auth_repository.dart'
    as _i441;
import 'package:social_media_app/presentation/providers/auth/auth_state_provider.dart'
    as _i467;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i420.AppConfig>(() => _i420.AppConfig());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i457.FirebaseStorage>(() => registerModule.storage);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => registerModule.connectionChecker);
    await gh.lazySingletonAsync<_i986.Box<dynamic>>(
      () => registerModule.hiveBox,
      preResolve: true,
    );
    gh.factory<_i1057.NetworkInfo>(
        () => _i1057.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i441.AuthRepository>(() => _i1022.AuthRepositoryImpl(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.factory<_i467.AuthNotifier>(
        () => _i467.AuthNotifier(gh<_i441.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i542.RegisterModule {}
