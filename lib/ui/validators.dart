
import 'package:form_field_validator/form_field_validator.dart';

class CFValidator extends TextFieldValidator {
  CFValidator(
      {String errorText = 'Il codice fiscale è composto da 16 caratteri'})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (value.toUpperCase() == 'NA') {
      return true;
    } else if (value.length == 16) {
      return true;
    }
    return false;
  }
}

final nameSurnameValidator = MultiValidator([
  RequiredValidator(errorText: 'Questo campo è obbligatorio'),
  MinLengthValidator(3, errorText: 'Devi inserire almeno 3 caratteri'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);
