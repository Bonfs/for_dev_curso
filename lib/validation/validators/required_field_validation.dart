import '../protocols/field_validation.dart';

class RequiredFieldValidation implements FieldValidation {
  @override
  String field;

  RequiredFieldValidation(this.field);

  @override
  String? validate(String value) => value.isNotEmpty ? null : 'Campo Obrigatório.';
}