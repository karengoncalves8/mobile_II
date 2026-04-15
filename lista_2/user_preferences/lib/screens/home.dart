import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_preferences/l10n/app_localizations.dart';
import 'package:user_preferences/widgets/radio_group.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String lightThemeValue = 'light';
  static const String darkThemeValue = 'dark';
  static const String portugueseLanguageValue = 'pt';
  static const String englishLanguageValue = 'en';
  static const String spanishLanguageValue = 'es';

  String temaSelection = lightThemeValue;
  String idiomaSelection = portugueseLanguageValue;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    _initialized = true;

    final locale = Get.locale ?? Localizations.localeOf(context);
    idiomaSelection = switch (locale.languageCode) {
      englishLanguageValue => englishLanguageValue,
      spanishLanguageValue => spanishLanguageValue,
      _ => portugueseLanguageValue,
    };

    temaSelection = Theme.of(context).brightness == Brightness.dark
        ? darkThemeValue
        : lightThemeValue;
  }

  void onChangeTheme(String? value) {
    setState(() {
      temaSelection = value ?? lightThemeValue;
    });

    if (temaSelection == lightThemeValue) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
  }

  void onChangeLanguage(String? value) {
    setState(() {
      idiomaSelection = value ?? portugueseLanguageValue;
    });

    Locale newLocale;
    switch (idiomaSelection) {
      case englishLanguageValue:
        newLocale = const Locale(englishLanguageValue);
        break;
      case spanishLanguageValue:
        newLocale = const Locale(spanishLanguageValue);
        break;
      default:
        newLocale = const Locale(portugueseLanguageValue);
    }

    Get.updateLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Text(
              localizations.welcome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: localizations.nameLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            CustomRadioGroup(
              title: localizations.themeLabel,
              options: [
                RadioGroupOption(
                  value: lightThemeValue,
                  label: localizations.lightTheme,
                ),
                RadioGroupOption(
                  value: darkThemeValue,
                  label: localizations.darkTheme,
                ),
              ],
              selectedOption: temaSelection,
              onChanged: onChangeTheme,
            ),
            CustomRadioGroup(
              title: localizations.languageLabel,
              options: [
                RadioGroupOption(
                  value: portugueseLanguageValue,
                  label: localizations.portugueseLanguage,
                ),
                RadioGroupOption(
                  value: englishLanguageValue,
                  label: localizations.englishLanguage,
                ),
                RadioGroupOption(
                  value: spanishLanguageValue,
                  label: localizations.spanishLanguage,
                ),
              ],
              selectedOption: idiomaSelection,
              onChanged: onChangeLanguage,
            ),
          ],
        ),
      ),
    );
  }
}
