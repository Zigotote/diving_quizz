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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 5),
              child: Text(
                "Exemple :",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.isDarkTheme
                        ? Colors.white
                        : themeProvider.theme.themeData.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    BotDialog(
                      child: BotText("Bonjour, je suis le professeur X."),
                    ),
                    UserDialog(
                      child: UserText("Démarrons le quizz !"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
