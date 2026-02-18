import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

enum NetworkStatus { online, offline }

// For checking internet connectivity
abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<NetworkStatus> get status;

  Stream<NetworkStatus> get onStatusChanged;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  late Connectivity connectivity;

  NetworkInfoImpl() {
    connectivity = Connectivity();
  }

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Future<NetworkStatus> get status async {
    final result = await connectivity.checkConnectivity();

    return result.contains(ConnectivityResult.none)
        ? NetworkStatus.offline
        : NetworkStatus.online;
  }

  @override
  Stream<NetworkStatus> get onStatusChanged {
    return connectivity.onConnectivityChanged.map(
      (results) => results.contains(ConnectivityResult.none)
          ? NetworkStatus.offline
          : NetworkStatus.online,
    );
  }
}
