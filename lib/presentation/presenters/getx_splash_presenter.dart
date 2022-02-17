import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetXSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString('');

  GetXSplashPresenter({ required this.loadCurrentAccount });

  @override
  Stream<String>? get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      if(account != null) {
        _navigateTo.value = '/surveys';
      } else {
        _navigateTo.value = '/login';
      }
    } catch(error) {
      _navigateTo.value = '/login';
    }
  }
}