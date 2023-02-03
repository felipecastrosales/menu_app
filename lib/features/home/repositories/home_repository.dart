import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/home/models/home_section.dart';

class HomeRepository {
  final StrapiDatasource datasource = StrapiDatasourceImpl();

  Future<List<HomeSection>> getHomeSections() {
    return datasource.getHomeSections();
  }

  Future<List<HomeSection>> getMenuSections() {
    return datasource.getMenuSections();
  }
}
