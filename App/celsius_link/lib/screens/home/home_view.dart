import 'package:celsius_link/common/providers.dart';
import 'package:celsius_link/config.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui_kit/temp_panel.dart';

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
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final HomeModel model = ref.watch(providers.homeControllerProvider);
    MaterialStateProperty<Color> selected =
        MaterialStateProperty.all<Color>(currentScheme.getScheme().onPrimary);
    MaterialStateProperty<Color> notSelected =
        MaterialStateProperty.all<Color>(currentScheme.getScheme().background);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                model.selected == 0 ? selected : notSelected),
                        onPressed: () {
                          controller.setSelected(0);
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.thermostat),
                          ),
                          Text("${model.temp} °C")
                        ])),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              model.selected == 1 ? selected : notSelected),
                      onPressed: () {
                        controller.setSelected(1);
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.water_drop_outlined),
                        ),
                        Text("${model.hum} %")
                      ])),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                model.selected == 2 ? selected : notSelected),
                        onPressed: () {
                          controller.setSelected(2);
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.battery_charging_full_sharp),
                          ),
                          Text("${model.bat} V")
                        ])),
                  ),
                ],
              ),
            ),
            TempPanel(
              controller: controller,
              model: model,
            )
          ],
        ),
      ),
    );
  }
}

abstract class HomeController extends StateNotifier<HomeModel> {
  HomeController(HomeModel state) : super(state);
  Future<void> init();
  void setSelected(int select);
}
