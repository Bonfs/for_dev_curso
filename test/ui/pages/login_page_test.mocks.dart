// Mocks generated by Mockito 5.0.16 from annotations
// in for_dev_curso/test/ui/pages/login_page_test.dart.
// Do not manually edit this file.

import 'package:for_dev_curso/ui/pages/login/login_presenter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [LoginPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class LoginPresenterSpy extends _i1.Mock implements _i2.LoginPresenter {
  LoginPresenterSpy() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void validateEmail(String? email) =>
      super.noSuchMethod(Invocation.method(#validateEmail, [email]),
          returnValueForMissingStub: null);
  @override
  void validatePassword(String? password) =>
      super.noSuchMethod(Invocation.method(#validatePassword, [password]),
          returnValueForMissingStub: null);
  @override
  void auth() => super.noSuchMethod(Invocation.method(#auth, []),
      returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
