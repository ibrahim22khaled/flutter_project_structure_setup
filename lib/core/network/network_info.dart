import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

/// PURPOSE: Provides a clean interface to check internet connectivity status.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// @LazySingleton(as: NetworkInfo) tells our DI (get_it) how to create this class,
/// and binds it to the [NetworkInfo] abstraction.
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  /// Why checking internet BEFORE API calls improves UX:
  /// It prevents the app from waiting for a timeout (which can take 30+ seconds),
  /// providing instant feedback to the user that they are offline.
  /// 
  /// Why relying only on DioException is not enough:
  /// A Dio connection error is generic and can mean many things (DNS issue, proxy error).
  /// Checking connectivity gives an explicit "no internet" signal earlier.
  /// 
  /// Note on internal workings of connectivity_plus:
  /// It checks the active network interface (e.g., if Wi-Fi or Cellular is toggled ON).
  /// It does NOT guarantee that the interface actually has internet access (e.g. captive portals).
  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    // In connectivity_plus 6.x, checkConnectivity returns a List<ConnectivityResult>.
    // It returns [ConnectivityResult.none] if no connection is active.
    return !results.contains(ConnectivityResult.none);
  }
}
