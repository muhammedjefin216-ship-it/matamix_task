class User {
  final int id;
  final String name, username, email, phone, website, company, address;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'],
        website = json['website'],
        company = json['company']['name'],
        address = '${json['address']['street']}, ${json['address']['city']}';
}