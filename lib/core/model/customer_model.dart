class Customer {
  final String uid;
  final String email;
  final String nameSurname;

  Customer({
    required this.uid,
    required this.email,
    required this.nameSurname,
  });

  @override
  String toString() {
    return 'Customer{uid: $uid, email: $email, nameSurname: $nameSurname}';
  }
}
