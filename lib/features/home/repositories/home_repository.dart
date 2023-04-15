import 'package:menu/features/core/datasources/strapi_datasource.dart';
import 'package:menu/features/home/models/home_section.dart';

class HomeRepository {
  HomeRepository(this._datasource);

  final StrapiDatasource _datasource;

  Future<List<HomeSection>> getHomeSections() {
    return _datasource.getHomeSections();
  }

  Future<List<HomeSection>> getMenuSections() {
    return _datasource.getMenuSections();
  }
}
