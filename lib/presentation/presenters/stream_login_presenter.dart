import 'dart:async';

import '../../ui/pages/pages.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  @override
  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<String> get passwordErrorStream => _controller.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<String> get mainErrorStream => _controller.stream.map((state) => state.mainError).distinct();

  @override
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream => _controller.stream.map((state) => state.isLoading).distinct();

  StreamLoginPresenter({ required this.validation, required this.authentication });

  void _update() => _controller.add(_state);
  
  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _update();
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(AuthenticationParams(email: _state.email, password: _state.password));
    } on DomainError catch(error) {
      _state.mainError = error.description;
    }
    _state.isLoading = false;
    _update();
  }

  @override
  void dispose() {
    _controller.close();
  }

  bool get isClosed => _controller.isClosed;
}

class LoginState {
  String email = '';
  String password = '';
  String emailError = '';
  String passwordError = '';
  String mainError = '';
  bool isLoading = false;
  bool get isFormValid => emailError.isEmpty 
    && passwordError.isEmpty
    && email.isNotEmpty
    && password.isNotEmpty;
}
