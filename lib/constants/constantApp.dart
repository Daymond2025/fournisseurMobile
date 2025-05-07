import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  // Application information
  static const String appName = 'MyFlutterApp';
  static const String appVersion = '1.0.0';
  static const String companyName = 'My Company';
  static const String currency = 'CFA';

  // API URLs
  static const String baseUrl = 'https://v2.daymondboutique.com/api/v2';
  static const String loginUrl = '$baseUrl/auth/supplier/login';
  static const String userURL = '$baseUrl/user';
  //static const String registerUrl = '$baseUrl/auth/register';
  static const String fetchproduit = '$baseUrl/supplier/product';
  static const String updateproduit = '$baseUrl/supplier/product';
  static const String updatestockproduit = '$baseUrl/supplier/product';
  static const String parametre = '$baseUrl/params/data?option=state';
  static const String categories = '$baseUrl/params/data?option=category_detail';
  static const String villes = '$baseUrl/params/data/offline?option=city';
  static const String walletbyuser = '$baseUrl/supplier/wallet';
  static const String dashboard = '$baseUrl/supplier/dashboard?option=apk';
  static const String order = '$baseUrl/supplier/order';
  static const String shop = '$baseUrl/supplier/shop';
  static const String updateStatus = '$baseUrl/supplier/order';
  static const String orderby = '$baseUrl/supplier/order/2';
  static const String recharge = '$baseUrl/supplier/payment/recharge';
  static const String retrait = '$baseUrl/supplier/payment/withdrawal';
  static const String transaction = '$baseUrl/supplier/transactions';
  static const String numbers = '$baseUrl/supplier/phone_number';

  static const String updateUser = '$baseUrl/supplier/fournisseur';
  static const String updateShop = '$baseUrl/supplier/updateShop';

  // API Keys
  //static const String apiKey = 'YOUR_API_KEY_HERE';

  // Error Messages
  static const serverError = 'Erreur du serveur';
  static const unauthorized = 'Tu n\'es pas autorisé';
  static const somethingWentWrong = 'Une erreur s\'est produite, réessayez!';

  // Regular Expressions
  static const String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String phoneRegex = r'^\+?[0-9]{7,15}$';

  // separateur
  var formatter = NumberFormat('#,###', "fr_FR");

  // Input Decorations
  static const InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: inputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: inputFocusedBorderColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: errorColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: inputBorderColor),
    ),
    labelText: 'Enter text',
    labelStyle: TextStyle(color: Colors.black54),
    hintText: 'Your input here',
    hintStyle: TextStyle(color: Colors.black38),
  );

  // Error Messages
  static const String fieldRequiredError = 'Tous les champs sont obligatoire.';
  static const String invalidEmailError = 'Please enter a valid email address.';

  // Button Styles
  static ButtonStyle validateButtonStyle = const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(buttonColor),
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  );
  static const ButtonStyle outlineButtonStyle = ButtonStyle(
    side: MaterialStatePropertyAll(
        BorderSide(color: buttonColor)), // Bordure colorée
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
    ),
  );

  static const ButtonStyle cancelButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(cancelButtonColor),
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12.0)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
  );

  // App padding & margins
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;

  // Text styles
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
  );
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color accentColor = Color(0xFF03DAC5);
  static Color backgroundColor = hexToColor('#F7F7FA');
  static const Color errorColor = Color(0xFFB00020);
  static const Color buttonColor = Colors.orange;
  static const Color cancelButtonColor = Colors.redAccent;
  static const Color inputBorderColor = Color.fromARGB(255, 195, 195, 195);
  static const Color inputFocusedBorderColor = Colors.orange;
  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Button radius
  static const double buttonRadius = 8.0;

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);

  // Animations
  static const Duration animationDuration = Duration(milliseconds: 300);

  // App-specific constants
  static const int maxLoginAttempts = 3;
  static const int itemsPerPage = 20;
}

setUserSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('session');
  await prefs.setString(
      'session', "${DateTime.now().add(const Duration(minutes: 5))}");
}

var formatwallet = NumberFormat('#,###', "fr_FR");
// Formateur pour la date
DateFormat dateFormatter = DateFormat('dd/MM/yyyy', 'fr_FR');

// Formateur pour l'heure
DateFormat timeFormatter = DateFormat('HH:mm', 'fr_FR');

Color hexToColor(String hexColor) {
  // Vérifier si la chaîne de caractères commence par '#'
  if (hexColor.startsWith('#')) {
    hexColor = hexColor.substring(1); // Supprimer le '#' au début
  }

  // Convertir le hex en entier
  int colorInt = int.parse(hexColor, radix: 16);

  // Si la couleur est de format RGB, ajoutez l'opacité (255)
  if (hexColor.length == 6) {
    return Color(colorInt | 0xFF000000); // Ajoute 255 d'opacité
  } else if (hexColor.length == 8) {
    return Color(colorInt); // Si c'est déjà en ARGB
  } else {
    throw FormatException(
        'La couleur doit être au format hexadécimal de 6 ou 8 caractères.');
  }
}

// Fonction pour convertir une date au format DD/MM/YYYY en DateTime
DateTime? parseDate(String dateString) {
  try {
    List<String> parts = dateString.split('/');
    if (parts.length == 3) {
      // Reformater au format YYYY-MM-DD
      String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';
      return DateTime.parse(formattedDate);
    }
  } catch (e) {
    print('Erreur de format de date: $e');
  }
  return null; // Si la date est invalide 
}

Column formatDates(String? createdAt) {
  DateTime dateTime =
      DateTime.parse(createdAt!); // Conversion de la chaîne en DateTime

  // Format de la date : jeudi/octobre/18
  DateFormat dateFormatter = DateFormat('EEEE/MMMM/yy', 'fr');
  String formattedDate = dateFormatter.format(dateTime);

  // Format de l'heure : 15:34
  DateFormat timeFormatter = DateFormat('HH:mm');
  String formattedTime = timeFormatter.format(dateTime);

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        formattedDate,
        style: AppConstants.bodyTextStyle.copyWith(fontSize: 8),
      ),
      Text(
        formattedTime,
        style: AppConstants.bodyTextStyle.copyWith(fontSize: 7),
      )
    ],
  );
}

Column formatDate(String? dateTimeString) {
  // Convertir le string en objet DateTime
  DateTime dateTime = DateTime.parse(dateTimeString!);

  // Formater la date : 'jeu' pour jour de la semaine et 'oct' pour mois
  String formattedDate = DateFormat('EEE/MMM/yy').format(dateTime);

  // Formater l'heure : '10:10'
  String formattedTime = DateFormat('HH:mm').format(dateTime);

  // Combiner date et heure
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        formattedDate,
        style: AppConstants.bodyTextStyle.copyWith(fontSize: 8),
      ),
      Text(
        formattedTime,
        style: AppConstants.bodyTextStyle.copyWith(fontSize: 7),
      )
    ],
  );
}

String formatCustomDate(String? dateString) {
  // Définir le format actuel de la date reçue (DD/MM/YYYY)
  DateFormat inputFormat = DateFormat('dd/MM/yyyy');

  // Convertir la date en objet DateTime
  DateTime dateTime = inputFormat.parse(dateString!);

  // Formater la date : 'jeu' pour jour de la semaine et 'oct' pour mois
  String formattedDate = DateFormat('EEE/MMM/yy', 'fr_FR').format(dateTime);

  // Exemple : si tu veux afficher l'heure de la journée à une valeur par défaut

  // Combiner date et heure
  return formattedDate;
}
