import 'package:top_menu/core/models/restaurant_config.dart';

abstract class RestaurantRepository {
  RestaurantConfig? getConfig();

  Future<void> saveConfig(RestaurantConfig config);

  Future<void> deleteConfig();
}

abstract class RestaurantLocalDataSource {
  RestaurantConfig? getConfig();

  Future<void> saveConfig(RestaurantConfig config);

  Future<void> deleteConfig();
}
