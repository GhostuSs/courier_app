// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocale {
  AppLocale();

  static AppLocale? _current;

  static AppLocale get current {
    assert(_current != null,
        'No instance of AppLocale was loaded. Try to initialize the AppLocale delegate before accessing AppLocale.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocale> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocale();
      AppLocale._current = instance;

      return instance;
    });
  }

  static AppLocale of(BuildContext context) {
    final instance = AppLocale.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocale present in the widget tree. Did you add AppLocale.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocale? maybeOf(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale);
  }

  /// `Суши шеф`
  String get title {
    return Intl.message(
      'Суши шеф',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Авторизация`
  String get auth {
    return Intl.message(
      'Авторизация',
      name: 'auth',
      desc: '',
      args: [],
    );
  }

  /// `Ваш email`
  String get yourEmail {
    return Intl.message(
      'Ваш email',
      name: 'yourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Ваш пароль`
  String get yourPass {
    return Intl.message(
      'Ваш пароль',
      name: 'yourPass',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get login {
    return Intl.message(
      'Войти',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Заказы`
  String get orders {
    return Intl.message(
      'Заказы',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get profile {
    return Intl.message(
      'Профиль',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Нужна помощь?`
  String get needHelp {
    return Intl.message(
      'Нужна помощь?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `День`
  String get day {
    return Intl.message(
      'День',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Неделя`
  String get week {
    return Intl.message(
      'Неделя',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Месяц`
  String get month {
    return Intl.message(
      'Месяц',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Попробовать снова`
  String get retry {
    return Intl.message(
      'Попробовать снова',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Выйти`
  String get exit {
    return Intl.message(
      'Выйти',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Открыть настройки`
  String get openSettings {
    return Intl.message(
      'Открыть настройки',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Заказ`
  String get order {
    return Intl.message(
      'Заказ',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Состав заказа`
  String get orderCart {
    return Intl.message(
      'Состав заказа',
      name: 'orderCart',
      desc: '',
      args: [],
    );
  }

  /// `Заказ забрал`
  String get orderPicked {
    return Intl.message(
      'Заказ забрал',
      name: 'orderPicked',
      desc: '',
      args: [],
    );
  }

  /// `Заказ доставлен`
  String get orderDelivered {
    return Intl.message(
      'Заказ доставлен',
      name: 'orderDelivered',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocale> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocale> load(Locale locale) => AppLocale.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
