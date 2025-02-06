// lib/core/network/network_info.dart
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

@Injectable(as: NetworkInfo) // Changed from @LazySingleton to @Injectable
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectivityChanged => connectionChecker.onStatusChange
      .map((status) => status == InternetConnectionStatus.connected);
}
