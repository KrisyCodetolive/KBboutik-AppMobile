import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {

    // demander permission
    await _messaging.requestPermission();

    // récupérer le token
    String? token = await _messaging.getToken();

    print("TOKEN : $token");

    // écouter les notifications quand l'app est ouverte
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print("Nouvelle notification");
      print(message.notification?.title);
      print(message.notification?.body);

    });

  }

}