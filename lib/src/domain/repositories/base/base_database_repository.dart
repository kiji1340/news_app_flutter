import 'package:meta/meta.dart';

import '../../../data/datasources/local/floor/app_database.dart';

class BaseDatabaseRepository{
  @protected
  final AppDatabase appDatabase;

  BaseDatabaseRepository(this.appDatabase);
}