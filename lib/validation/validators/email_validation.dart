import 'package:equatable/equatable.dart';

import '../../validation/protocols/protocols.dart';

class EmailValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const EmailValidation(this.field);

  @override
  String? validate(String value) {
    RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isValid = value.isEmpty || emailRegex.hasMatch(value);
    return isValid ? null : 'Campo inválido.';
  }
}