
class MyValidations {

  static validateEmptyText(String? fieldname , String? value) {
    if(value == null || value.isEmpty){
      return '$fieldname is required';
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }
    // Regular expression for email validation
    final emailRedExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRedExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required';
    }
    if(value.length < 6){
      return 'Password must be at least 6 characters';
    }
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one uppercase';
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number';
    }
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least one special character';
    }
    return null;

  }
}


