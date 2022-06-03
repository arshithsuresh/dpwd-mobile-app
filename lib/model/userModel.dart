
class User {

    String id;
    String username;
    String name;
    String organization;    
    int verified;
    int role;
    String accessToken;
    
    User({this.id,this.username, this.name, this.organization,this.role,this.verified, this.accessToken});
    
    factory User.fromJson(Map<String,dynamic> json) {      
        return User(id:json['id'] ,username: json['username'], name: json['name'], organization: json['organization'],
                    role: json['role'], verified: json['verified'], accessToken: json['accessToken']);
    }


}