
class User {

    String username;
    String name;
    String organization;    
    int verified;
    int role;
    String accessToken;
    
    User({this.username, this.name, this.organization,this.role,this.verified, this.accessToken});
    
    factory User.fromJson(Map<String,dynamic> json) {      
        return User(username: json['username'], name: json['name'], organization: json['organization'],
                    role: json['role'], verified: json['verified'], accessToken: json['accessToken']);
    }


}