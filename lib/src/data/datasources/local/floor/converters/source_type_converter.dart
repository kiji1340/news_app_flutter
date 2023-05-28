import 'package:floor/floor.dart';
import 'dart:convert';

import '../../../../../domain/models/source.dart';

class SourceTypeConverter
    extends TypeConverter<Source?, String?> {
  @override
  Source? decode(String? databaseValue) {
    final json = databaseValue == null ? null : jsonDecode(databaseValue);
    return json == null ? null : Source.fromMap(json);
  }

  @override
  String? encode(Source? value) {
    return value == null ? null : jsonEncode(value.toMap());
  }


}