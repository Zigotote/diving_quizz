import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettings extends StatefulWidget {
  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      String themeValue = themeProvider.isDarkTheme ? "sombre" : "clair";
      return Scaffold(
        appBar: AppBar(
          title: Text("Paramètres"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeProvider.isDarkTheme = value;
                    });
                  },
                ),
                Text("Thème $themeValue activé"),
              ],
            ),
            BotDialog(
              child: BotText("Bonjour, je suis le professeur X."),
            ),
            UserDialog(
              child: UserText("Démarrons le quizz !"),
            )
          ],
        ),
      );
    });
  }
}
