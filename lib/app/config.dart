import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static late String apiUrl;

  static Future init() async {
    await dotenv.load(fileName: ".env");
    Config.apiUrl = dotenv.env['API_URL']!;
  }
}
