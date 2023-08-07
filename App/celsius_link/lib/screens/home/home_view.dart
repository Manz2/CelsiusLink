import 'package:celsius_link/common/providers.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final HomeController controller;
  @override
  void initState() {
    super.initState();
    controller = ref.read(providers.homeControllerProvider.notifier);
    controller.getTemp();
  }

  @override
  Widget build(BuildContext context) {
    final HomeModel model = ref.watch(providers.homeControllerProvider);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(model.temp),
        ),
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);
  Future<void> getTemp();
}
