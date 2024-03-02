class user{
  final String userID;
  final String username;
  final String email;
  final String password;

  user({required this.userID, required this.username, required this.email, required this.password});

  factory user.fromJson(Map<String, dynamic> json){
    return user(
        userID: json['userID'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
    );
  }
}