String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T extends Object>(String key, List<T> values) => values
    .firstWhere((v) => key.toLowerCase() == enumToString(v).toLowerCase());
