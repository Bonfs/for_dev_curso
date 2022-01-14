import 'package:equatable/equatable.dart';

import '../protocols/field_validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  String? validate(String value) => value.isNotEmpty ? null : 'Campo Obrigatório.';
}