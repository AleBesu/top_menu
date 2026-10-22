import 'package:top_menu/core/models/restaurant_config.dart';
import 'package:top_menu/core/models/restaurant_config_repository.dart';

class HiveRestaurantRepository extends RestaurantRepository {
  final RestaurantLocalDataSource _dataSource;

  HiveRestaurantRepository(this._dataSource);

  @override
  RestaurantConfig? getConfig() {
    return _dataSource.getConfig();
  }

  @override
  Future<void> saveConfig(RestaurantConfig config) {
    return _dataSource.saveConfig(config);
  }

  @override
  Future<void> deleteConfig() {
    return _dataSource.deleteConfig();
  }
}
