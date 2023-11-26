import 'package:nasa_explorer_app_project/constants/list.dart';

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
