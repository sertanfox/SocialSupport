class User {
  final String username;
  final String cancertype;
  final String location;
  final String id;

  User({this.username, this.cancertype, this.location, this.id});

  Map<String, dynamic> tomap() {
    return {
      'username': username,
      'cancertype': cancertype,
      'location': location,
      'id': id
    };
  }
}
