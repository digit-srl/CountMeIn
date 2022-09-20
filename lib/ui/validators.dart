import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter_codice_fiscale/codice_fiscale.dart';

class MyEmailValidator extends EmailValidator{
  MyEmailValidator({required super.errorText});

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
   return value!= null && value.isNotEmpty && super.isValid(value);
  }
}
class CFValidator extends TextFieldValidator {
  CFValidator(
      {String errorText = 'Il codice fiscale è composto da 16 caratteri'})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if(CodiceFiscale.check(value)){
      return true;
    }
    return false;
/*
    if (value.toUpperCase() == 'NA') {
      return true;
    } else if (value.length == 16) {
      return true;
    }
    return false;*/
  }
}

final nameSurnameValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(3, errorText: 'Devi inserire almeno 3 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final numberValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 1, max: 365, errorText: 'Il valore inserito non è valido'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final averageAgeValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 3, max: 99, errorText: 'Il valore deve essere compreso tra 3 e 99'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final maxGroupCountValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  RangeValidator(
      min: 2, max: 40, errorText: 'Il valore deve essere compreso tra 2 e 40'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);