import 'package:menu/core/datasources/strapi_datasource.dart';
import 'package:menu/features/home/models/home_section.dart';

class HomeRepository {
  final datasource = StrapiDatasourceImpl();

  Future<List<HomeSection>> getHomeSections() {
    return datasource.getHomeSections();
  }
}
