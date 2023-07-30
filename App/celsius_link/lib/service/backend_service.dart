import 'package:celsius_link/service/backend_service_aggregator.dart';
import 'package:logger/logger.dart';

class BackendService implements BackendServiceAggregator {
  Logger logger = Logger();

  @override
  List<String> getTemp() {
    return ["1", "2"];
  }
}
