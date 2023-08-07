import 'package:celsius_link/screens/home/home_backend_service.dart';
import 'package:celsius_link/screens/home/home_model.dart';
import 'package:celsius_link/screens/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../secrets.dart';

class HomeControllerImplmentation extends HomeController {
  final HomeBackendService _backendService;
  HomeControllerImplmentation({
    HomeModel? model,
    required HomeBackendService backendService,
  })  : _backendService = backendService,
        super(model ?? const HomeModel(temp: ""));

  @override
  Future<void> getTemp() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference tempRef = FirebaseDatabase.instance
        .ref('Data/$uid/messurements/current/temperature');
    tempRef.onValue.listen((DatabaseEvent event) {
      print("newValue");
      state = state.copyWith(temp: event.snapshot.value.toString());
    });
  }
}
