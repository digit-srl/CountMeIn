import 'package:flutter_codice_fiscale/dao/city_dao.dart';
import 'package:flutter_codice_fiscale/models/city.dart';


final allCities = CityDao().cities.map((c)=>MyCity(c.name, c.province, c.regione, c.code)).toList();
class MyCity extends City {
  MyCity(super.name, super.province, super.regione, super.code);

  @override
  String toString() {
    return name;
  }
}

class Nation extends MyCity {
  Nation(String name, String code) : super(name, '', '', code);
}
