import 'package:celsius_link/screens/home/home_backend_service.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:celsius_link/screens/home/home_view.dart';

class HomeControllerImplmentation extends HomeController {
  final HomeBackendService _backendService;
  HomeControllerImplmentation({
    HomeModel? model,
    required HomeBackendService backendService,
  })  : _backendService = backendService,
        super(model ?? const HomeModel(temp: []));

  @override
  List<String> getTemp() {
    return _backendService.getTemp();
  }
}
