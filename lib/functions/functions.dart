import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:http/http.dart' as http;

void emailValidator(String email) {
  if (email.isEmpty) {
    if (!errorList.contains('Please enter an email!')) {
      errorList.add('Please enter an email!');
    } else if (errorList.contains('Please enter an email!')) {}
  } else {
    errorList.remove('Please enter an email!');
    if (!email.contains('@gmail.com')) {
      if (!errorList.contains('Please check your email address!')) {
        errorList.add('Please check your email address!');
      } else if (errorList.contains('Please check your email address!')) {}
    } else if (email.contains('@gmail.com')) {
      errorList.remove('Please check your email address!');
    }
  }
}

void passwordValidator(String password) {
  if (password.isEmpty) {
    errorList.add('Please enter your password!');
  } else {
    errorList.remove('Please enter your password!');
    if (password.length < 6) {
      errorList.add('Password must be more than 6 characters!');
    } else if (password.length == 6 || password.length > 6) {
      errorList.remove('Password must be more than 6 characters!');
    }
    if (!password.contains('%') ||
        !password.contains('&') ||
        !password.contains('#') ||
        !password.contains('@') ||
        !password.contains('!')) {
      errorList
          .add('Password must contain at least one of \'!,@,#,%,&\' symbols!');
    } else if (password.contains('%') ||
        password.contains('&') ||
        password.contains('#') ||
        password.contains('@') ||
        password.contains('!')) {
      errorList.remove(
          'Password must contain at least one of \'!,@,#,%,&\' symbols!');
    }
  }
}

// to set condition lottie file
String getWeatherAnimations(String? mainCondition) {
  if (mainCondition == null) {
    return 'assets/images/weather_icons/sunny.json';
  }

  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/images/weather_icons/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/images/weather_icons/rainy.json';
    case 'thunderstorm':
      return 'assets/images/weather_icons/thunder.json';
    case 'clear':
      return 'assets/images/weather_icons/sunny.json';
    default:
      return 'assets/images/weather_icons/sunny.json';
  }
}

getDummyData() async {
  var url = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2017-07-08&end_date=2017-07-10';
  try {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      print(response.body.length);
    }
  } catch (e) {
    print(e);
  }
}
