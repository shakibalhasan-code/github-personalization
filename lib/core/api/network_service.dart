import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();
  final Logger _logger = Logger();

  /// Check if device has internet connectivity
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> connectivityResult = await _connectivity
          .checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet)) {
        _logger.i('Network connection available');
        return true;
      }

      _logger.w('No network connection');
      return false;
    } catch (e) {
      _logger.e('Error checking connectivity: $e');
      return false;
    }
  }

  /// Check connectivity and show error message if not connected
  Future<bool> checkConnectivityWithMessage() async {
    final connected = await isConnected();
    if (!connected) {
      _showNoInternetMessage();
    }
    return connected;
  }

  /// Show no internet connection message
  void _showNoInternetMessage() {
    Get.snackbar(
      'No Internet Connection',
      'Please check your internet connection and try again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  /// Listen to connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
