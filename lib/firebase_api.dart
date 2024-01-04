import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

class FirebasAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final _fcmToken = await _firebaseMessaging.getToken();
    GetStorage().write('fcmToken', _fcmToken);
   
    FirebaseMessaging.onBackgroundMessage(handleFireBaseBackgroundMessage);
    
  }
}

Future<void> handleFireBaseBackgroundMessage(RemoteMessage message) async {
 
}
