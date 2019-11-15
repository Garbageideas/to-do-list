class LoginDetails {

  static Map<String, String> details = {
    "guest": "guest",
    "hdjeong80@gmail.com": "hdjeong80",
    "crobatma88@gmail.com": "crobatma88",
  };


  static checkUser(String user){
    return details.containsKey(user);
  }

  static checkPass(String user, String pass) {
    return details[user] == pass;
  }

}