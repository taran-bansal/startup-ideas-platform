import 'package:get/get.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;
  final _error = ''.obs;

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  void setLoading(bool loading) {
    _isLoading.value = loading;
  }

  void setError(String? errorMessage) {
    _error.value = errorMessage ?? '';
  }

  @override
  void onClose() {
    _isLoading.close();
    _error.close();
    super.onClose();
  }
}
