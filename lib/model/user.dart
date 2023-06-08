

class Shipping{
  final String address;
  final String city;
  final bool isEmpty;

  Shipping({
    required this.isEmpty,
    required this.address,
    required this.city
});
}


class User{

  final String token;
  final String email;
  final String fullname;
  final bool isAdmin;
  final Shipping shipping;

  User({
    required this.shipping,
    required this.fullname,
    required this.email,
    required this.token,
    required this.isAdmin
});

}