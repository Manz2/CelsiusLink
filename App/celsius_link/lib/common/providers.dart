import 'package:celsius_link/screens/home/home_backend_service.dart';
import 'package:celsius_link/screens/home/home_controller.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:celsius_link/screens/home/home_view.dart';
import 'package:celsius_link/service/backend_service.dart';
import 'package:celsius_link/service/backend_service_aggregator.dart';
import 'package:riverpod/riverpod.dart';

final Providers providers = Providers();

class Providers {
  final Provider backendServiceProvider =
      Provider<BackendServiceAggregator>((_) => BackendService());

  final StateNotifierProvider<HomeController, HomeModel>
      homeControllerProvider = StateNotifierProvider<HomeController, HomeModel>(
          (StateNotifierProviderRef ref) => HomeControllerImplmentation(
                  backendService: ref.read(
                providers.backendServiceProvider
                    as ProviderListenable<HomeBackendService>,
              )));
}
