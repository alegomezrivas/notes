import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notas/core/utils/utilities.dart';

enum Status { add, remove, error }

Future<void> createNoteNotification(Status status) async {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      switch (status) {
        case Status.add:
          noteNotification(
            title: '${Emojis.smile_star_struck} Nota agregada con éxito',
            body: 'Su nota ha sido almacenada satisfactoriamente',
          );
          break;
        case Status.remove:
          noteNotification(
            title:
                '${Emojis.smile_beaming_face_with_smiling_eyes} Nota eliminada con éxito',
            body: 'Su nota ha sido eliminada satisfactoriamente',
          );
          break;
        case Status.error:
          noteNotification(
            title: '${Emojis.smile_face_screaming_in_fear} Error de cache',
            body:
                'Ha ocurrido un error al obtener los datos, por favor intente nuevamente',
          );
          break;
        default:
      }
    }
  });
}

Future<void> noteNotification({required String title, String? body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
  );
}
