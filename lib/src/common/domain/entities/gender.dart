enum Gender {
  male,
  female,
  notBinary,
}

extension GenderX on Gender{

  String get text {
    switch(this){
      case Gender.male:
        return 'Maschio';
      case Gender.female:
        return 'Femmina';
      case Gender.notBinary:
        return 'Non binario';
    }
  }
}