import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import "package:googleapis_auth/auth_io.dart";
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late final String? token;
  static final StreamController<dynamic> _messageStream =
      StreamController.broadcast();
  static Stream<dynamic> get dataNotification => _messageStream.stream;

  // Use service account credentials to obtain oauth credentials.
  Future<String?> getAccessToken() async {
    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "lizit-production-a28ef",
      "private_key_id": "83c3159ba64da4e95767ca1c160e55c91f537b52",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCD9V7uSb/YLpxY\n7sdLXFdvdG83nfRbrORUKl6AoU7qzv+JUf3JeH6SPxx0nd41ZVeUtzMIfGETUBeV\nZIPO/Z3tuhQoVdp3jBMiQcRfv7gN/QbESvlKQQFMIk46z+M7MFRQokDpgzzp+L2D\ntKxkIpRdMknqgnqed0k3u8/mcWK6CSSosnER0jmco48XPDR1YaRiVyNxknkpJ/0K\nl3vx93vFhL/ZxYBb5KNJLgCBuktNREFFLnFiif9hlIodjMsiV4gLyrZutz4lqrtE\nQVK3HvSgb7Kra34w6tddgbBp+y0CG5zb8tXl/MXN31BpV1lm0qaLL9N6FCgFDiJZ\nnxLg641dAgMBAAECggEAGb5ZZlCB+llhjCINRGD/99D1z5pjrSzmIJthc2PE4x8+\nEBqsUc1NmBdy5DdWPgGG3A7/iETHpX5nE3CYHF4zHMlEHHhfVhpAM1s0Rd+/tw7p\nbosX5koXSDSbIXMkKAxuLorw8f11+UlbI6IwTZrHagUhEXyiEl9AK/zaeuEc+yD8\ny5GPlZxM7yT5aeK+BEtXhXKM6BsKFr0T2wECO7K7ks5IMtGTCf8KgPm7JlqlUT6N\nD+HnTyfvxEybFp+lGZ1ZLnzpjsiXx6r51n/Sl5FB8SM8JRGwIRTV53ZIGw2xgekI\nmOUhKJxgjWNNmoRt7Ek8GizfFWO+d+Bo/+IfvmTjQQKBgQC5p3o/ViI9Wns0l4XI\nrODM/oK6vCUASkUQdNG+srJq0iGnlT9uK7cE46zjOcG8sglgUF+jARDlq9QGVM6J\n93BAhf9QXYDZKDe+U1uzxfAP7qY+JGcIEfM4ULEa7gggHLOOQsVngHlYlkyrv28x\nAhAxsv7UtCp5YTWd2Yf0srsUIQKBgQC19WOUklpY9FyAXVSct8mEc0F5uZA6RjCr\nnBzAyXoe8iDo5FlsXnLygF6+MRQ+t9M0hbPhwGK6BFBFFqqyq8U8Igy2Ns/jGQFZ\nZW+OJ8IMwxAenS+WF3/gPOphvSW039RPO6WgVpsUhXQ1ezkrtooBNI551lhKUu/B\nojyMOYeRvQKBgG4Wv8j6/IbBNrny9+QNj6g/a6nrk01evSGLBC0+rcnmHQrQ17Iu\nvfJqR8TeJOIN+L1iK7PvF+P5RlsSwv7Q+YFpdAJlz9f1n0h/CavKvhXUgEPtNiN0\n8XL9dmfvqmXQXzEGqyQ67Ln5NjHJ7Nd0z8GI0M+0nlMnr7GQoqwZqBHBAoGAaXLY\nTtWx/jM/GDT+QARSiKuymjRr3RmoQwupriAU4bI4WD9dg2wI+Xhjb51Juj8V6y5A\n3Od9T4gIbMGCEyFwoDSrYT3KpDVtjr02NQ/daT/yK4u0dCsSNIWY3yOaooPEqlZK\n2ezW2sGsYwISU77po2Et4HXTnN8Liw/WPv1oD5ECgYBiKqvTTwO42DrwTUlj5ms3\nLMd85+wmv0L/cr/uteR0TWrhGEvPFvTRRWbp8OaRTkahIJ6w/9jFLKj1xnsLCCoJ\nKv/MdxzJrFExAPLNN6/+l2Z138WQku4AjEwoGhxAFYTsPh8C6FvMWdqAP+ChcRP1\nhwh2I7FA5AG9EKoGmtmj3Q==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-mf2yx@lizit-production-a28ef.iam.gserviceaccount.com",
      "client_id": "103232604594023055495",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mf2yx%40lizit-production-a28ef.iam.gserviceaccount.com"
    });
    var client = http.Client();
    AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
            accountCredentials, scopes, client);

    client.close();
    return credentials.accessToken.data;
  }

  static Future initNotifications() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print("Este es el token $token");

    final box = GetStorage();
    box.write('pushToken', token);

    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onLaunch);
    FirebaseMessaging.onBackgroundMessage(onResume);
  }

  static Future<dynamic> onMessage(RemoteMessage message) async {
    debugPrint("======== ON Message ==========");
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    SnackBars.showNotificationSnackBar('Tienes una nueva notificación');
    Map<String, dynamic> dataNotification = message.data;
    dataNotification.addAll({'isLocal': true});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onLaunch(RemoteMessage message) async {
    debugPrint("======== ON Launch ==========");
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    Map dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static Future<dynamic> onResume(RemoteMessage message) async {
    debugPrint("======== ON Resume ==========");
    debugPrint('Title: ${message.notification!.title}');
    debugPrint('Body: ${message.notification!.body}');
    Map dataNotification = message.data;
    dataNotification.addAll({'isLocal': false});
    _messageStream.add(dataNotification);
  }

  static closeStream() {
    _messageStream.close();
  }

  /// Enviar notificaciones a un número limitado de usuarios (1-5 usuarios)
  Future<Map<String, dynamic>?> sendNotificationToToken1(
      String tokens, String title, String body) async {
    var accesstoken = await getAccessToken();
    print(accesstoken);
    final response = await http
        .post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/lizit-production-a28ef/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      },
      body: jsonEncode(
        <String, dynamic>{
          "message": {
            "token": tokens,
            "notification": <String, dynamic>{"body": body, "title": title}
          }
        },
      ),
    )
        .catchError((e) {
      debugPrint("ERROR AL POST NOTIF: $e");
    });

    debugPrint("RESPONSE: ${response.body}");
    return null;
  }

  /// Enviar notificaciones a un usuario
  Future<Map<String, dynamic>?> sendNotificationToToken(
      String token, String title, String body) async {
    final response = await http
        .post(
      Uri.parse(
          'fcm.googleapis.com/v1/projects/lizit-production/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getAccessToken()',
      },
      body: jsonEncode(
        <String, dynamic>{
          "to": token,
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "sound": "default",
            "badge": 1,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
          },
        },
      ),
    )
        .catchError((e) {
      debugPrint("ERROR AL POST NOTIF: $e");
    });

    debugPrint("RESPONSE: ${response.body}");
    return null;
  }

  /// Enviar notificaciones a n usuarios que estén suscritos al topic
  Future<Map<String, dynamic>?> sendNotificationToTopic(
      String topic, String title, String body) async {
    final response = await http
        .post(
      Uri.parse(
          'fcm.googleapis.com/v1/projects/lizit-production/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $getAccessToken()',
      },
      body: jsonEncode(
        <String, dynamic>{
          "to": "/topics/$topic",
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "sound": "default",
            "badge": 1,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
          },
        },
      ),
    )
        .catchError((e) {
      debugPrint("ERROR AL POST NOTIF: $e");
    });

    debugPrint("RESPONSE: ${response.body}");
    return null;
  }
}

PushNotificationService pushNotificationService = PushNotificationService();
