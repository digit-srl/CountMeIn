enum Gender {
  male,
  female,
  notDeclared,
}

extension GenderX on Gender{

  String get text {
    switch(this){
      case Gender.male:
        return 'Uomo';
      case Gender.female:
        return 'Donna';
      case Gender.notDeclared:
        return 'Non dichiarato';
    }
  }
}