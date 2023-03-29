import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/widgets/splashScreen.dart';

void main(List<String> args) {
  AwesomeNotifications().initialize(
    "@mipmap/laucher_icon",
    [
      NotificationChannel(
          channelKey: 'Basic',
          channelName: 'Progresso do Aluno',
          channelDescription: 'Mensagem Seth')
    ],
    debug: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa as Widgets corretamente
  runApp(const ProjectSeth());
}

class ProjectSeth extends StatelessWidget {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    initState();
  }

  const ProjectSeth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //após fechar o app, verificar se o isAuth tem valor
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
