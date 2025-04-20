import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Ticket
  {
    'n0tf3kvr': {
      'en': 'Tickets',
      'ar': 'التذاكر',
    },
    't4r2z4rw': {
      'en': 'Tickets',
      'ar': 'التذاكر',
    },
  },
  // Map
  {
    'bfqrpqq2': {
      'en': 'Map',
      'ar': 'الخريطة',
    },
    '16uythvq': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Lines
  {
    'pc6zctzu': {
      'en': 'Lines',
      'ar': 'المسارات',
    },
    '2nro5ia5': {
      'en': 'Find a line or station ',
      'ar': 'ابحث عن المسار',
    },
    'ay4fzosq': {
      'en': 'Blue Line',
      'ar': 'المسار الازرق',
    },
    'ktcws5a2': {
      'en': 'Red Line',
      'ar': 'المسار الاحمر',
    },
    'xj8jcrt2': {
      'en': 'Orange Line',
      'ar': 'المسار البرتقالي',
    },
    'a4wzuxni': {
      'en': 'Green Line',
      'ar': 'المسار الاخضر',
    },
    '8wrmsaeq': {
      'en': 'Purple Line',
      'ar': 'المسار البنفسجي',
    },
    '0sjscf4p': {
      'en': 'Yellow Line',
      'ar': 'المسار الاصفر',
    },
    'ungwmqpx': {
      'en': 'Lines',
      'ar': '',
    },
    'a49hi69t': {
      'en': 'Lines',
      'ar': 'المسارات',
    },
  },
  // changePassword
  {
    'iy1xt2pz': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور ',
    },
    '77eqhn33': {
      'en':
          'Enter your current password and a new password below to change your account password.',
      'ar':
          'ادخل كلمة المرور الحالية وبالأسفل ادخل كلمة المرور الجديدة لتغيير كلمة مرور حسابك',
    },
    'nn9thdht': {
      'en': 'Current password',
      'ar': 'كلمة المرور الحالية',
    },
    'qsbqd090': {
      'en': 'New password',
      'ar': 'كلمة المرور الجديدة',
    },
    'dfcu99y1': {
      'en': 'Confirm new password',
      'ar': 'تأكيد كلمة المرور الجديدة',
    },
    'w8y7t6ux': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور',
    },
  },
  // payment
  {
    'on4qm53k': {
      'en': 'Invoice Amount',
      'ar': '',
    },
    'f58f00qo': {
      'en': '4.00 SAR',
      'ar': '',
    },
    '9mg6v59j': {
      'en': 'Choose payment method',
      'ar': 'اختر طريقة دفع جديدة',
    },
    'bbrkezt6': {
      'en': 'Card',
      'ar': 'بطاقة',
    },
    'n467y1cq': {
      'en': 'Home',
      'ar': '',
    },
  },
  // payment2
  {
    'uqdrxyoa': {
      'en': 'Invoice Amount',
      'ar': '',
    },
    '97tg2o6f': {
      'en': '20.00 SAR',
      'ar': '',
    },
    'q5vyxbmy': {
      'en': 'Choose payment method',
      'ar': 'اختر طريقة دفع جديدة',
    },
    'ac6tby74': {
      'en': 'Card',
      'ar': '',
    },
    'sy4h6nt5': {
      'en': 'Home',
      'ar': '',
    },
  },
  // payment3
  {
    'o40rcol6': {
      'en': 'Invoice Amount',
      'ar': '',
    },
    '6as5oi1f': {
      'en': '40.00 SAR',
      'ar': '',
    },
    'h31rcpvo': {
      'en': 'Choose payment method',
      'ar': 'اختر طريقة دفع جديدة',
    },
    '2t6674ee': {
      'en': 'Card',
      'ar': '',
    },
    '6d56mdxw': {
      'en': 'Home',
      'ar': '',
    },
  },
  // SignUp
  {
    'zl895lxh': {
      'en': 'Get Started',
      'ar': 'ابدا من جديد',
    },
    'pvk9usbm': {
      'en': 'Create an account by using the form below.',
      'ar': 'انشاء حسابك',
    },
    'k9rg81jw': {
      'en': 'Email',
      'ar': 'الايميل',
    },
    'g72g7cld': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'jj7r7cn7': {
      'en': 'Create Account',
      'ar': 'انشئ حساب جديد',
    },
    'x2e6oisg': {
      'en': 'Or sign up with',
      'ar': 'او سجل دخولك',
    },
    'lb197smm': {
      'en': 'Already have an account? ',
      'ar': 'لديك حساب مسجل من قبل؟',
    },
    'pfy1sfnf': {
      'en': 'Log in here',
      'ar': 'سجل هنا',
    },
    'c4cya19k': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Login
  {
    'jkoc1zpq': {
      'en': 'Welcome Back',
      'ar': 'اهلا بك ',
    },
    'h4fw0g6y': {
      'en': 'Fill out the information below in order to access your account.',
      'ar': 'ادخل المعلومات المطلوبة',
    },
    'o97ewzkp': {
      'en': 'Email',
      'ar': '',
    },
    '83em4h0z': {
      'en': 'Password',
      'ar': '',
    },
    'vf1tvo5z': {
      'en': 'Log In',
      'ar': 'سجل',
    },
    '2lp64ihk': {
      'en': 'Or sign in with',
      'ar': 'او سجل ',
    },
    '2ohziq5w': {
      'en': 'Don\'t have an account?  ',
      'ar': 'ليس لديك حساب؟',
    },
    '8jm19imv': {
      'en': 'Create Account',
      'ar': 'انشئ حساب',
    },
    'j9ym69gb': {
      'en': 'Forgot password?',
      'ar': 'نسيت كلمة المرور؟',
    },
    '9imsugfq': {
      'en': 'Home',
      'ar': '',
    },
  },
  // ForgotPassword
  {
    '3nb1s9nx': {
      'en': 'Forgot Password',
      'ar': 'نسيان كلمة المرور',
    },
    'q4w2vrbj': {
      'en':
          'Please fill out your email belo in order to recieve a reset password link.',
      'ar': 'ادخل ايميلك في الاسفل',
    },
    '3a5bqicr': {
      'en': 'Email',
      'ar': '',
    },
    '4pp0qpf0': {
      'en': 'Send Reset Link',
      'ar': 'اعادة كلمة المرور',
    },
    'chm62ind': {
      'en': 'Home',
      'ar': '',
    },
  },
  // createProfile
  {
    '95qlev1j': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Profile
  {
    'y3rpup2b': {
      'en': 'Your Account',
      'ar': 'حسابك',
    },
    's31mww8e': {
      'en': 'Edit Profile',
      'ar': 'تعديل حسابك',
    },
    'jusl2bns': {
      'en': 'App Settings',
      'ar': 'اعدادات التطبيق',
    },
    'ofa28p70': {
      'en': 'Mode',
      'ar': 'الوضع',
    },
    '2enixtpc': {
      'en': 'Dark & Light',
      'ar': 'ليلي & نهاري',
    },
    'q3z0bjrq': {
      'en': 'Change Password',
      'ar': '',
    },
    'pkijbq3s': {
      'en': 'Ticket History',
      'ar': 'سجل التذاكر',
    },
    'fyc31gtv': {
      'en': 'Privacy Policy',
      'ar': 'سياسة الخصوصية',
    },
    'a4frqym2': {
      'en': 'Contact Us',
      'ar': 'تواصل معنا',
    },
    'q92zg7a1': {
      'en': 'Log Out',
      'ar': 'تسجيل خروج',
    },
    'oga87kdr': {
      'en': 'Profile',
      'ar': 'الملف التعريفي',
    },
    'dtmsvc1f': {
      'en': 'Home',
      'ar': '',
    },
  },
  // EditProfile
  {
    'zi4nlbvr': {
      'en': 'Home',
      'ar': '',
    },
  },
  // ContactUs
  {
    'tx5pijo6': {
      'en': 'Contact Us',
      'ar': '',
    },
    'o6leyopc': {
      'en':
          'We\'re here to help! Send us a message and we\'ll get back to you as soon as possible.',
      'ar': 'نحن هنا لمساعدتك! ارسل لنا رسالة وسوف نرد عليك قريبا',
    },
    'ogu7lp0i': {
      'en': 'Email Address',
      'ar': 'الايميل',
    },
    'xagy0ynh': {
      'en': 'Enter your email',
      'ar': 'ادخل ايميلك',
    },
    'y2rf4obu': {
      'en': 'Description',
      'ar': 'الوصف',
    },
    '29bgvahx': {
      'en': 'Describe your issue in detail',
      'ar': 'اوصف مشكلتك',
    },
    'c8db7x41': {
      'en': 'Submit',
      'ar': 'اوافق',
    },
    'zlhg7yiw': {
      'en': 'Enter your email is required',
      'ar': 'مطلوب ادخال الايميل',
    },
    'sroof6wt': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'h6rxz0vh': {
      'en': 'Describe your issue in detail is required',
      'ar': 'وصف مشكلتك مطلوب',
    },
    '9x7qkrin': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // BLUELine
  {
    'b4pftq2f': {
      'en': 'The line Map',
      'ar': 'المسار على الخريطة',
    },
    'huv7ca58': {
      'en': 'Pay Ticket',
      'ar': 'شراء تذكرة',
    },
    'jhc7lyc2': {
      'en': 'Blue Line',
      'ar': 'المسار الازرق',
    },
    'swuk9ba2': {
      'en': 'Home',
      'ar': '',
    },
  },
  // RedLine
  {
    '6vsiul9r': {
      'en': 'The line Map',
      'ar': '',
    },
    'o4bq4ka0': {
      'en': 'Pay Ticket',
      'ar': '',
    },
    '0q52msqr': {
      'en': 'Red Line',
      'ar': 'المسار الاصفر',
    },
    'f2c8utgk': {
      'en': 'Home',
      'ar': '',
    },
  },
  // OrangeLine
  {
    '8gpjyge9': {
      'en': 'The line Map',
      'ar': '',
    },
    'nlu1nf0y': {
      'en': 'Pay Ticket',
      'ar': '',
    },
    'a3o07kns': {
      'en': 'Orange Line',
      'ar': 'المسار البرتقالي',
    },
    'r1uqhw4i': {
      'en': 'Home',
      'ar': '',
    },
  },
  // GreenLine
  {
    'hp893vj2': {
      'en': 'The line Map',
      'ar': '',
    },
    '6hmi1vaj': {
      'en': 'Pay Ticket',
      'ar': 'شراء تذكرة',
    },
    'eba9up7z': {
      'en': 'Green Line',
      'ar': 'المسار الاخضر',
    },
    'txv9x2zq': {
      'en': 'Home',
      'ar': '',
    },
  },
  // PurpleLine
  {
    '1r3c7yy3': {
      'en': 'The line Map',
      'ar': '',
    },
    'fc9qtstx': {
      'en': 'Pay Ticket',
      'ar': '',
    },
    'f7wmf3cv': {
      'en': 'Pruple Line',
      'ar': 'المسار البنفسجي',
    },
    '0sz72mt7': {
      'en': 'Home',
      'ar': '',
    },
  },
  // YellowLine
  {
    '2vtp6gvq': {
      'en': 'The line Map',
      'ar': '',
    },
    'j246ih0y': {
      'en': 'Pay Ticket',
      'ar': '',
    },
    'ezkvj1l1': {
      'en': 'Yellow Line',
      'ar': '',
    },
    '7dqnlz2k': {
      'en': 'Home',
      'ar': '',
    },
  },
  // PrivacyPolicy
  {
    'wjihoxrc': {
      'en':
          'January 2, 2025\n\nFor the purpose of these policy, “we”, “us” and “ours” shall always mean the Royal Commission for Riyadh City (RCRC) and/or its affiliates, while “you” and “yours” shall mean the user.\n\nThis privacy and data protection policy (“Policy”) takes effect on 03 January 2025. It describes what information we hold, why we hold it and how we use it. This Policy applies to anyone who uses , our App (“RiyadhGO”) and our “RiyadhGO” card. We\'ll refer to the Site and Riyadh Bus App together as the “App”. In this Privacy and Data Protection Policy, references to the App include both Android and iOS versions of the App.\n\nWe\'re the Controlling Authority as defined by the Personal Data Protection Law of the Kingdom of Saudi Arabia, issued pursuant to Royal Decree.\n\nThis Privacy Policy is subject to the laws and regulations of the Kingdom of Saudi Arabia. The courts of jurisdiction relating to this Policy shall be the Saudi courts.\n\n1. WHAT INFORMATION DO WE HOLD AND WHY?\n\nThere are three types of information we process: (1) information you provide, (2) information created when you use features in the App or darb card and (3) information from other sources.\n\n1.1 Information you provide\n\nWhen you use our App, you might provide us with (a) personal information; (b) places and preferences; and (c) direct communications.\n\n1.1.1  Personal information\n\nRCRC requires that you provide personal information that is accurate, complete, and up-to-date as is necessary for the purposes for which it is to be used while transacting with us.\n\nIf you create a Riyadh Bus App account, you provide us with your name, phone number, email address and other personal data which we use to ensure your saved places and other personalisation features are synced across your multiple devices.\n\nWhen you purchase a QR e-ticket or travel pass within the App, you provide us with your payment details.\n\nIf you register  you provide us with your name, email address, mobile phone number and other personal data so that we can verify your identity. To register your darb card you must visit a ticket vending station for an agent to verify your identity using your National ID or Iqama and mobile phone number register. We never use this information for any purpose other than verifying your identity . You also provide us with your payment details to pay for your ticket or travel passes as specified in our Terms and Conditions.\n\n1.1.2  Places and preferences\n\nYou may choose to provide us with information on your places and preferences, such as Home, Work, Favourites, and other travel preferences. We use this information to develop personalised journey-planning services. We may also analyse this data in aggregate to improve the App (for example, by ranking certain journey results more highly than others).\n\n1.1.3  Direct communications\n\nWhen you communicate with us (for example when you respond to in-App survey questions, report problems, raise queries etc.) we may receive information about the type of phone you\'re using, your service provider and, if you\'ve enabled the location permissions in your device, the latitude and longitude of your location when you contact us. We may use this information to fix problems in the App, with ticketing and purchasing or with darb card, to reply to your communications and to help keep you safe.\n\n1.2 Information created when you use our App \n\nThe following are types of information generated when you use our App or darb card. We associate this information with an installation ID number that is randomly generated each time you install the Riyadh Bus App. We may use this installation ID to anonymize the data we collect from you. We do not access any permanent device ID numbers.\n\n1.2.1 Location information\n\nWe use the location data described in this “Location Information” section to improve results in the App and for the purposes identified below.\n\nUsers of the Riyadh Bus App: if you\'ve enabled your device\'s location services we may collect and use your start location information when you open the App. If you disable your device\'s location services we collect only the start and end points that you search manually.\n\nTicketing and purchasing: If you purchase a ticket using the App, we may collect your location information when the Riyadh Bus App is running both in the foreground and background of your device during your journey. Knowing your location during your ride enables on-trip support.\n\nIn addition to your location data, we store your booking details, the date and time of your journey, the amount charged, your origin and destination locations. We use this information for operational reasons, such as providing customer support.\n\nQR E-ticket users: If you are a QR E-ticket user, we will collect your location information as described above if you Tap-to-Go service in the Riyadh Bus App while using your QR e-ticket.\n\n1.2.2 Device information\n\nWe may collect information about the devices you use to access our App, including the type of computer or device you use, the installation ID of the App on your device, the hardware model, operating system and versions, software, file names and versions, the preferred language, time zone settings, and device motion information. This information is necessary for us to diagnose bugs and improve the App. We do not collect any permanent device ID numbers.\n\n1.2.3 Log and usage information\n\nEach time you open the App, we may collect information about how and when you use it (such as the time and date, searches in the App features and journey results you select, pages visited, app crashes and other system activity). We use this information to improve our App in multiple ways. For example, fixing bugs preventing future crashes and working out which features our users find most helpful.\n\n1.2.4 Cookies\n\nThe App uses cookies to store certain information. Cookies are pieces of information that a website or app transfers to your hard drive or mobile device to store and sometimes track information about you. Although they identify a user\'s device, cookies do not reveal the name, email address or other obvious identifiers of users.\n\nWhen you visit our App, our server sends a cookie to your computer or mobile device (depending on how you access the site or App). A number of cookies we use last only for the duration of your web session and expire when you close your App. These are known as “session cookies”. Other cookies are used to remember you when you return to the App and will last for longer. These are known as “persistent cookies”.\n\nWe may use cookies to:\n\nremember that you have visited us before, which allows us to identify the number of unique visitors we receive. This allows us to make sure we have enough capacity for the number of users that we get and to; customise elements of the promotional layout and/or content of the pages of the App; and\ncollect information about how you use the App so that we can improve the App and learn which parts of the App are most useful.\nSome of the cookies used by our App are set by us and some are set by third-party analytics and crash/error-reporting companies as described in this Policy.\n\nMost browsers automatically accept cookies but, if you prefer, you can change your browser to prevent that or to notify you each time a cookie is set. By blocking or deleting cookies you may not be able to take full advantage of the Site’s or App\'s features.\n\n1.3 Information from other sources\n\nThe App may collect the following types of information from other sources:\n\n1.3.1 Payment information\n\nIn order to pay for your darb card or QR e-ticket you will need to provide payment information. Apple collects credit or debit card (“Payment Card”) data with respect to in-app purchases of QR e-ticket, and our payment processor collects Payment Card data with respect to darb card and QR e-ticket payments. For darb card and QR e-tickets, you provide your Payment Card information directly to Payment Gateway, which processes payments on our behalf. Payment Gateway uses this payment information in accordance with its Privacy Policy. Payment Gateway provides us with some limited data related to you, such as the last four digits of your card number and expiration date, which we use in order to handle operational issues such as subscriber and passenger queries about charges.\n\n1.3.2 Cardholder ID and transaction information for darb card\n\nIf you are a darb card user, we receive a “Cardholder ID” from the third-party company that issues your darb card. The Cardholder ID is your unique identifier that tells us which darb card has been issued to you. When you use the darb card, we also receive your transaction information from this third-party company, including the date, time, amount and the merchant details associated with the transaction. This information is necessary in order to provide the darb card service and to comply with our legal obligations.\n\n2. HOW YOUR INFORMATION MAY BE USED AND BY WHOM?\n\nWe use the information we collect to:\n\nProvide and improve our App, QR e-ticket services and darb card;\nBuild a profile of your preferences so we can personalise the Riyadh Bus App and provide you with relevant transport information;\nRecommend transport options that match your stated preferences and previous use of the App;\nAdminister your account with us, if you have one;\nConfirm your eligibility to use darb card;\nVerify your identity (including processing of your identity documents in order to confirm your identity and to make an automated decision as to whether or not to provide you with darb card services);\nProcess or facilitate payment (through third party payment processing services) for QR e-ticket, and darb card;\nSend you transaction receipts for your use of QR e-ticket and/or darb card;\nRespond to your emails to discuss your use of the App, QR e-ticket, darb card and answer any support queries you may have;\nSend you marketing communications by email or in-App notifications, and let you know about our policies and terms or when we expand services in Riyadh city;\nIdentify issues with the operation of the App, and provide crash reports in order to find resolution for performance issues;\nImprove the design, functionality and/or content of the pages of the App and customise them for you;\nCarry out research on users\' transport choices to improve the App, and darb card;\nConduct studies on use of public transit and ridership;\nDisclose to lawful authorities when required to do so by law, or when appropriate, in our opinion, to respond to their request.\nWe work hard to improve the App and add functionality, which we think will make it safer, more fun and more useful. New functionality may involve similar or incidental uses of your data to those set out above. We regularly review the way we use data and retain the right to amend our privacy policy.\n\n3. WHAT IF YOU DO NOT WANT TO PROVIDE YOUR INFORMATION?\n\nRCRC may collect your personal information which you have accepted to share per this Policy for the purposes described above.  If you do not wish to disclose personal information, you may choose to forego the convenience of purchasing tickets with a credit card, on the App. \n\n4. HOW MAY THIRD PARTIES RECEIVE YOUR INFORMATION?\n\n4.1   User Experience & Related Analytics\n\nFrom time to time we may share information with third parties to improve the App and enhance user experience. To the extent possible we anonymize (remove information that identifies you) and minimize the data we send to them.\n\nSearch Partners: We have search partners like Google, so you can find the places you want to go in the App. They receive the place name you have searched for and to make your search results as relevant as possible, they receive your current location (if you have enabled location services in your device).\nAnalytics Vendors: We use third party vendors like Google Analytics to understand what you\'ve tapped or clicked on the App. They receive information showing only that someone has tapped or used certain features in the App. They organise that information and give it back to us so that we can make improvements to the App.\nCrash/Error Reporting Vendors: We may use vendors to report on crashes you experience with the App so we can fix those, and to report on errors with our backend.\nCommunication Platforms: To send you transaction receipts for your QR e-ticket and/or  card subscription and to send you all other emails and update about our services, we use communication platforms.\nWe do not control these vendors and you may wish to consult their individual privacy policies for more information.\n\n4.2   Embedded Content\n\nWe may also embed content from websites such as YouTube or Instagram. As a result, when you visit a page featuring such content, you may be presented with cookies in the embedded content from these third parties. We do not control these cookies and cannot prevent these sites or domains from collecting information on your use of this content. You should check the relevant third-party website for more information about them and how to opt out. If you are not logged in to their services, they will not know who you are but may still gather anonymous usage information.\n\n5. WILL YOU SELL MY INFORMATION TO THIRD PARTIES FOR COMMERCIAL PURPOSES?\n\nNo, we will not sell your personal information to third parties for commercial or any other purposes.  We may, from time to time, seek to update and improve the services provided, and invite commercial entities to submit proposals for enhanced services. In such circumstances, we may share data collected on ridership, but this will not include your personal information.\n\n6. WHAT ARE YOUR RIGHTS IN RELATION TO PERSONAL DATA WE HOLD ABOUT YOU?\n\n6.1   Access\n\nYou have a legal right to request access to a copy of the personal information we hold about you. In order to do this, protection policy and include details about what personal information you\'re looking for. You will need to have created an account for us to provide you with your information because without an account, we are not able to connect your Installation ID to a verifiable email address. You must have access to the email address that you used when you created the account so that we can verify your identity.\n\n6.2   Deletion\n\nWe store your personal information for as long as is necessary to provide our services and products. You have the right to request we delete your personal information if you believe that we no longer need it for the purposes for which it was provided, or you wish to withdraw your consent (and we have no other lawful basis to use the data). For legal reasons, we may not always be able to delete your information.\n\n\nNote that residual copies may take longer to be removed from our backup systems which cannot be immediately overwritten. Where residual copies are kept on our back-up systems, they are merely held on the system and are not used for any other purpose. We will keep a record of your request to ensure compliance with legal obligations.\n\n6.3   Notifications\n\nWe may send you information we think you may find useful (e.g., new bus line launches, bus route diversions, and alerts about darb card relevant to you) or which you have requested from us by push notification and/or by email (if provided). You can opt-out of receiving further notifications or emails if you wish.\n\n7. HOW WE KEEP YOUR INFORMATION SECURE\n\nWe place great importance on the security of all information associated with our users. We use measures such as encryption, anonymization, information access controls, and firewalls.\n\nKeep in mind that submission of information over the internet and mobile networks is never entirely secure. We cannot guarantee the security of information you submit via the App whilst it is in transit over the internet or mobile networks and any such submission is at your own risk.\n\n8. HOW LONG WE KEEP YOUR INFORMATION\n\nBy providing you with products or services, we create records that contain your information, such as customer account records, payment and activity records. We manage our records to help us to serve our users well and to comply with legal and regulatory requirements. Records help us demonstrate that we are meeting our responsibilities and are evidence of our business activities.\n\nHow long we keep records depends on the type of record, the nature of the activity, product or service and the applicable legal or regulatory requirements. How long we retain your information may change based on business or legal and regulatory requirements. If you are  card user, we keep most of your data for as long as it is legally required to comply with the law and if we face a legal challenge.\n\n9. WHAT COUNTRIES WILL YOUR PERSONAL INFORMATION BE SENT TO?\n\nInformation that you submit via the App is sent to and stored on secure servers located in the Kingdom of Saudi Arabia. Information submitted by you may be transferred by us to our other offices and/or to the third parties mentioned in the circumstances described above, which may be situated outside the Kingdom of Saudi Arabia.\n\n10. HOW WILL YOU KNOW ABOUT CHANGES TO OUR PRIVACY POLICY?\n\nWe may revise this Policy from time to time. Any changes and additions to this Policy will be posted in the App and are effective from the date on which they are posted. Please review this privacy notice from time to time to check whether we have made any changes to the way in which we use your personal data. This Policy was last updated on 2 January 2025. We retain the right to change this Policy as necessary.\n\n11. WHAT IF YOU HAVE A COMPLAINT?\n\nWe take handling of your information seriously. If you\'re unhappy about the way we do this, ',
      'ar':
          '2 يناير 2025\n\nلغرض هذه السياسة، فإن \"نحن\" و\"لنا\" تعني دائمًا الهيئة الملكية لمدينة الرياض (RCRC) و/أو الشركات التابعة لها، بينما تعني \"أنت\" و\"لك\" المستخدم.\n\nتدخل سياسة الخصوصية وحماية البيانات هذه (\"السياسة\") حيز التنفيذ في 3 يناير 2025. وهي تصف المعلومات التي نحتفظ بها، ولماذا نحتفظ بها وكيف نستخدمها. تنطبق هذه السياسة على أي شخص يستخدم تطبيقنا (\"RiyadhGO\") وبطاقة \"RiyadhGO\" الخاصة بنا. سنشير إلى الموقع وتطبيق حافلات الرياض معًا باسم \"التطبيق\". في سياسة الخصوصية وحماية البيانات هذه، تشمل الإشارات إلى التطبيق كل من إصدارات Android وiOS من التطبيق.\n\nنحن السلطة المسيطرة كما هو محدد في قانون حماية البيانات الشخصية للمملكة العربية السعودية، الصادر بموجب المرسوم الملكي.\n\nتخضع سياسة الخصوصية هذه لقوانين وأنظمة المملكة العربية السعودية. المحاكم المختصة بهذه السياسة هي المحاكم السعودية.\n\n1. ما هي المعلومات التي نحتفظ بها ولماذا؟\n\nهناك ثلاثة أنواع من المعلومات التي نعالجها: (1) المعلومات التي تقدمها، (2) المعلومات التي يتم إنشاؤها عند استخدامك للميزات في التطبيق أو بطاقة درب و(3) المعلومات من مصادر أخرى.\n\n1.1 المعلومات التي تقدمها\n\nعند استخدامك لتطبيقنا أو بطاقة درب، قد تزودنا بـ (أ) معلومات شخصية؛ (ب) أماكن وتفضيلات؛ و(ج) اتصالات مباشرة.\n\n1.1.1 المعلومات الشخصية\n\nتتطلب RCRC منك تقديم معلومات شخصية دقيقة وكاملة وحديثة حسب الضرورة للأغراض التي سيتم استخدامها من أجلها أثناء التعامل معنا.\n\nإذا قمت بإنشاء حساب على تطبيق حافلات الرياض، فإنك تزودنا باسمك ورقم هاتفك وعنوان بريدك الإلكتروني والبيانات الشخصية الأخرى التي نستخدمها لضمان مزامنة الأماكن المحفوظة وميزات التخصيص الأخرى عبر أجهزتك المتعددة.\n\nعند شراء تذكرة إلكترونية QR أو تذكرة سفر داخل التطبيق، فإنك تزودنا بتفاصيل الدفع الخاصة بك.\n\nإذا قمت بتسجيل بطاقة الدرب باسمك، فإنك تزودنا باسمك وعنوان بريدك الإلكتروني ورقم هاتفك المحمول وغير ذلك من البيانات الشخصية حتى نتمكن من التحقق من هويتك. لتسجيل بطاقة الدرب، يجب عليك زيارة محطة بيع التذاكر حتى يتمكن أحد الوكلاء من التحقق من هويتك باستخدام بطاقة الهوية الوطنية أو الإقامة ورقم الهاتف المحمول. لا نستخدم هذه المعلومات أبدًا لأي غرض آخر غير التحقق من هويتك حتى نتمكن من تسجيل بطاقة الدرب الخاصة بك. كما تزودنا بتفاصيل الدفع الخاصة بك لدفع ثمن تذكرتك أو تصاريح السفر كما هو محدد في شروط وأحكامنا.\n\n1.1.2 الأماكن والتفضيلات\n\nيمكنك اختيار تزويدنا بمعلومات حول أماكنك وتفضيلاتك، مثل المنزل والعمل والمفضلات وتفضيلات السفر الأخرى. نستخدم هذه المعلومات لتطوير خدمات تخطيط الرحلات الشخصية. قد نقوم أيضًا بتحليل هذه البيانات بشكل مجمع لتحسين التطبيق (على سبيل المثال، من خلال تصنيف نتائج رحلات معينة أعلى من غيرها).\n\n1.1.3 الاتصالات المباشرة\n\nعندما تتواصل معنا (على سبيل المثال عندما ترد على أسئلة الاستطلاع داخل التطبيق، أو تبلغ عن المشكلات، أو تطرح الاستفسارات، وما إلى ذلك)، فقد نتلقى معلومات حول نوع الهاتف الذي تستخدمه، وموفر الخدمة لديك، وإذا قمت بتمكين أذونات الموقع في جهازك، فربما نتلقى معلومات حول خط العرض وخط الطول لموقعك عندما تتصل بنا. قد نستخدم هذه المعلومات لإصلاح المشكلات في التطبيق، مع التذاكر والشراء أو مع بطاقة darb، للرد على اتصالاتك وللمساعدة في الحفاظ على سلامتك.\n\n1.2 المعلومات التي يتم إنشاؤها عند استخدام تطبيقنا أو بطاقة darb\n\nفيما يلي أنواع المعلومات التي يتم إنشاؤها عند استخدام تطبيقنا أو بطاقة darb. نربط هذه المعلومات برقم معرف التثبيت الذي يتم إنشاؤه عشوائيًا في كل مرة تقوم فيها بتثبيت تطبيق حافلات الرياض. يجوز لنا استخدام معرف التثبيت هذا لإخفاء هوية البيانات التي نجمعها منك. لا نصل إلى أي أرقام معرف جهاز دائمة.\n\n1.2.1 معلومات الموقع\n\nنستخدم بيانات الموقع الموضحة في قسم \"معلومات الموقع\" هذا لتحسين النتائج في التطبيق وللأغراض المحددة أدناه.\n\nمستخدمو تطبيق حافلات الرياض: إذا قمت بتمكين خدمات تحديد الموقع على جهازك، فقد نجمع معلومات موقع البداية الخاصة بك ونستخدمها عند فتح التطبيق. إذا قمت بتعطيل خدمات تحديد الموقع على جهازك، فإننا نجمع فقط نقاط البداية والنهاية التي تبحث عنها يدويًا.\n\nالتذاكر والشراء: إذا قمت بشراء تذكرة باستخدام التطبيق، فقد نجمع معلومات موقعك عندما يكون تطبيق حافلات الرياض قيد التشغيل في المقدمة والخلفية لجهازك أثناء رحلتك. إن معرفة موقعك أثناء رحلتك تمكنك من الحصول على الدعم أثناء الرحلة.\n\nبالإضافة إلى بيانات موقعك، نقوم بتخزين تفاصيل الحجز وتاريخ ووقت رحلتك والمبلغ المدفوع ومواقع المنشأ والوجهة. نستخدم هذه المعلومات لأسباب تشغيلية، مثل تقديم دعم العملاء.\n\nمستخدمو تذكرة QR الإلكترونية: إذا كنت من مستخدمي تذكرة QR الإلكترونية، فسنقوم بجمع معلومات موقعك كما هو موضح أعلاه إذا كنت تستخدم خدمة Tap-to-Go في تطبيق حافلات الرياض أثناء استخدام تذكرتك الإلكترونية QR.\n\n1.2.2 معلومات الجهاز',
    },
    'wch8hyoo': {
      'en': 'Privacy Policy',
      'ar': '',
    },
    'hx47b4xw': {
      'en': 'Home',
      'ar': '',
    },
  },
  // TicketHistory
  {
    'vkjksdua': {
      'en': 'There is no Ticket now...',
      'ar': 'لايوجد سجل للتذاكر',
    },
    '3vzthwwu': {
      'en': 'Ticket History',
      'ar': 'سجل التذاكر',
    },
    'uyygwffq': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Card1
  {
    '8mw2d05h': {
      'en': '2 HOURS',
      'ar': 'ساعتين',
    },
    'mk6sdeed': {
      'en': '4 SAR',
      'ar': '4 ريال',
    },
  },
  // Card2
  {
    'k3zt8ix4': {
      'en': '3 DAYS',
      'ar': '3 ايام',
    },
    '68zrsqt3': {
      'en': '20 SAR',
      'ar': '20 ريال',
    },
  },
  // Card3
  {
    'voenxzl6': {
      'en': '7 DAYS',
      'ar': '7 ايام',
    },
    '2c21kjcb': {
      'en': '40 SAR',
      'ar': '40 ريال',
    },
  },
  // NavBar
  {
    '0ayfbe7l': {
      'en': 'Map',
      'ar': 'الخريطة',
    },
    '7don1yj3': {
      'en': 'Tickets',
      'ar': 'التذاكر',
    },
    'pi1lc29u': {
      'en': 'Lines',
      'ar': 'المسارات',
    },
    'qi80j15c': {
      'en': 'Profile',
      'ar': 'الملف التعريفي',
    },
  },
  // editProfile_auth_2
  {
    'bhmly8um': {
      'en': 'Adjust the content below to update your profile.',
      'ar': 'ادخل المعلومات المطلوبه لتحديثها',
    },
    '5pxwftas': {
      'en': 'Full Name',
      'ar': 'اسمك كامل',
    },
    'wqcb6qqe': {
      'en': 'Your full name...',
      'ar': 'ادخل اسمك',
    },
    '6z3ymlfw': {
      'en': 'Full Name is required',
      'ar': 'الاسم مطلوب',
    },
    'n1erpnsn': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // thankU
  {
    '0uto8tx3': {
      'en': 'Thank You ',
      'ar': 'شكرا لط',
    },
    '4p3arrun': {
      'en': 'Payment is Secced thank You',
      'ar': 'العملية تمت شكرا',
    },
  },
  // Payment222
  {
    'nmxmbp60': {
      'en': 'Checkout',
      'ar': '',
    },
    'xlm02gje': {
      'en': 'Fill in the information below to place your order.',
      'ar': '',
    },
    'qne132c9': {
      'en': 'Price Breakdown',
      'ar': '',
    },
    '69h64ys0': {
      'en': 'Base Price',
      'ar': '',
    },
    'o3b6xtlx': {
      'en': '4.00   SAR',
      'ar': '',
    },
    'm83rq1lt': {
      'en': 'Taxes',
      'ar': '',
    },
    'ydgkibd3': {
      'en': '0   SAR',
      'ar': '',
    },
    '614zdh7e': {
      'en': 'Total',
      'ar': '',
    },
    'u2yiu7ox': {
      'en': '4.00   SAR',
      'ar': '',
    },
    'mwgis49a': {
      'en': 'Pay w/ Credit Card',
      'ar': '',
    },
    's8cowuyp': {
      'en': 'Or use an option below',
      'ar': '',
    },
    '1ard344f': {
      'en': 'Apple Pay',
      'ar': '',
    },
  },
  // PAYMENT2Copy
  {
    'idivn40u': {
      'en': 'Checkout',
      'ar': '',
    },
    '20sim2lr': {
      'en': 'Fill in the information below to place your order.',
      'ar': '',
    },
    'z79qgysm': {
      'en': 'Price Breakdown',
      'ar': '',
    },
    'wmcoo5ux': {
      'en': 'Base Price',
      'ar': '',
    },
    '9guf21ld': {
      'en': '17.00   SAR',
      'ar': '',
    },
    '62fjwdnq': {
      'en': 'Taxes',
      'ar': '',
    },
    'g7kj911x': {
      'en': '3.00   SAR',
      'ar': '',
    },
    'edc7zcyk': {
      'en': 'Total',
      'ar': '',
    },
    'y8bwqrmp': {
      'en': '20.00  SAR',
      'ar': '',
    },
    '2zj8t1pg': {
      'en': 'Pay w/ Credit Card',
      'ar': '',
    },
    '45o8ionx': {
      'en': 'Or use an option below',
      'ar': '',
    },
    'eds3l30m': {
      'en': 'Apple Pay',
      'ar': '',
    },
  },
  // PAYMENT2Copy2
  {
    'iunr8drz': {
      'en': 'Checkout',
      'ar': '',
    },
    'kel4ibhk': {
      'en': 'Fill in the information below to place your order.',
      'ar': '',
    },
    'mhoba7cd': {
      'en': 'Price Breakdown',
      'ar': '',
    },
    'tu50tepc': {
      'en': 'Base Price',
      'ar': '',
    },
    'xn116f85': {
      'en': '34.00   SAR',
      'ar': '',
    },
    '5i3j00oz': {
      'en': 'Taxes',
      'ar': '',
    },
    'obxskg8x': {
      'en': '6.00   SAR',
      'ar': '',
    },
    '60loiqmh': {
      'en': 'Total',
      'ar': '',
    },
    '8kggrkck': {
      'en': '40.00   SAR',
      'ar': '',
    },
    'ek22mndg': {
      'en': 'Pay w/ Credit Card',
      'ar': '',
    },
    'orkocmg7': {
      'en': 'Or use an option below',
      'ar': '',
    },
    'tq6piv3o': {
      'en': 'Apple Pay',
      'ar': '',
    },
  },
  // Action3PaymentTicketList
  {
    'pcu1wtwc': {
      'en': 'Choose a Ticket',
      'ar': 'اختر التذكرة',
    },
    'e1byfl94': {
      'en': '2 HOURS',
      'ar': '',
    },
    'hkq13hnz': {
      'en': '4 SAR',
      'ar': '',
    },
    '6cwpw078': {
      'en': '3 DAYS',
      'ar': '',
    },
    'lg7376pu': {
      'en': '20 SAR',
      'ar': '',
    },
    'knwvlzz3': {
      'en': '7 DAYS',
      'ar': '',
    },
    'kekw4nxs': {
      'en': '40 SAR',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'oidl1bxf': {
      'en': '',
      'ar': '',
    },
    'ij5n7snz': {
      'en': '',
      'ar': '',
    },
    'oqfvmb2p': {
      'en': '',
      'ar': '',
    },
    'm6znzk7h': {
      'en': '',
      'ar': '',
    },
    'z2ojgz6z': {
      'en': '',
      'ar': '',
    },
    'pgssxv4m': {
      'en': '',
      'ar': '',
    },
    '1hmqzk7j': {
      'en': '',
      'ar': '',
    },
    'uv34v4vx': {
      'en': '',
      'ar': '',
    },
    'yurokury': {
      'en': '',
      'ar': '',
    },
    'lczai7b9': {
      'en': '',
      'ar': '',
    },
    'bohqziqq': {
      'en': '',
      'ar': '',
    },
    'fv25vm9a': {
      'en': '',
      'ar': '',
    },
    'yclrp49g': {
      'en': '',
      'ar': '',
    },
    '83wldc5g': {
      'en': '',
      'ar': '',
    },
    '26iz3g6l': {
      'en': '',
      'ar': '',
    },
    'ajqkt9ic': {
      'en': '',
      'ar': '',
    },
    'srfg26tv': {
      'en': '',
      'ar': '',
    },
    'uov0vxak': {
      'en': '',
      'ar': '',
    },
    'rdq1at9l': {
      'en': '',
      'ar': '',
    },
    '8rfnidp1': {
      'en': '',
      'ar': '',
    },
    'mn2yuz2q': {
      'en': '',
      'ar': '',
    },
    'gfea7xbe': {
      'en': '',
      'ar': '',
    },
    'zgn7w1rk': {
      'en': '',
      'ar': '',
    },
    'dr4m6wpr': {
      'en': '',
      'ar': '',
    },
    'r3i4s6qr': {
      'en': '',
      'ar': '',
    },
    '43pjlc9u': {
      'en': '',
      'ar': '',
    },
    '2tibmo0d': {
      'en': '',
      'ar': '',
    },
    'eo69d5uz': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
