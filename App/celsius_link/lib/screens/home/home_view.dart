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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        ref.read(providers.homeControllerProvider.notifier);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(controller.getTemp().first),
        ),
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);
  List<String> getTemp();
}
