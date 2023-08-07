import 'package:celsius_link/screens/home/home_backend_service.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:celsius_link/screens/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import '../../secrets.dart';

class HomeControllerImplmentation extends HomeController {
  final HomeBackendService _backendService;
  HomeControllerImplmentation({
    HomeModel? model,
    required HomeBackendService backendService,
  })  : _backendService = backendService,
        super(model ??
            const HomeModel(
                temp: "", hum: "", bat: "", selected: 0, temperatureToday: []));

  @override
  Future<void> init() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // temperature
    DatabaseReference tempRef = FirebaseDatabase.instance
        .ref('Data/$uid/messurements/current/temperature');
    tempRef.onValue.listen((DatabaseEvent event) {
      state = state.copyWith(temp: event.snapshot.value.toString());
    });

    // humidity
    DatabaseReference humRef = FirebaseDatabase.instance
        .ref('Data/$uid/messurements/current/humidity');

    humRef.onValue.listen((DatabaseEvent event) {
      state = state.copyWith(hum: event.snapshot.value.toString());
    });

    // baterie Voltage
    DatabaseReference batRef =
        FirebaseDatabase.instance.ref('Data/$uid/messurements/current/voltage');

    batRef.onValue.listen((DatabaseEvent event) {
      state = state.copyWith(bat: event.snapshot.value.toString());
    });

    // temparature today
    List<Map<DateTime, double>> tempTodayList = [];
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('d-M-yyyy').format(date);
    DatabaseReference temTodayRef =
        FirebaseDatabase.instance.ref('Data/$uid/messurements/');
    DataSnapshot tempTodaySnapshot =
        await temTodayRef.child(formattedDate).get();
    int counter = 0;
    for (var element in tempTodaySnapshot.children) {
      if (counter == 2) {
        String formattedDateTwo = DateFormat('yyyy-MM-dd').format(date);
        DateTime dateTime = DateTime.parse("$formattedDateTwo ${element.key!}");
        double temperature =
            double.parse(element.child("temperature").value.toString());
        tempTodayList.add({dateTime: temperature});
        counter = 0;
      } else {
        counter++;
      }
    }

    state = state.copyWith(temperatureToday: tempTodayList);
  }

  @override
  void setSelected(int select) {
    state = state.copyWith(selected: select);
  }
}
