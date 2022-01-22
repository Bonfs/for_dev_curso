import 'package:get/state_manager.dart';

import '../../ui/pages/pages.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';

class GetXLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email = '';
  String _password = '';
  final _emailError = RxString('');
  final _passwordError = RxString('');
  final _mainError = RxString('');
  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  @override
  Stream<String> get emailErrorStream => _emailError.stream;

  @override
  Stream<String> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String> get mainErrorStream => _mainError.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetXLoginPresenter({
    required this.validation, 
    required this.authentication, 
    required this.saveCurrentAccount
  });
  
  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value.isEmpty 
    && _passwordError.value.isEmpty
    && _email.isNotEmpty
    && _password.isNotEmpty;
  }

  @override
  Future<void> auth() async {
    if(!_isLoading.value) {
      try {
        _isLoading.value = true;
        final accountEntity = 
          await authentication.auth(AuthenticationParams(email: _email, password: _password));
        await saveCurrentAccount.save(accountEntity);
      } on DomainError catch(error) {
        _mainError.value = error.description;
      }
    }
    _isLoading.value = false;
  }
}
