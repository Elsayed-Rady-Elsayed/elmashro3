class user{
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String creditCard;
  final int points;
  final bool status;
  final String updated_at;
  final String created_at;
  final String image;
  final String gender;
  final String age;
  final String birthDate;
  user({required this.email,required this.phone,required this.id,required this.name,required this.password,required this.image,required this.age,required this.birthDate,
  required this.created_at,required this.creditCard,required this.gender,required this.points,required this.status,required this.updated_at
  });
}