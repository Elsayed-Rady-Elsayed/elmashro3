class admin{
  final int id;
  final String email;
  final String status;
  final String password;
  final String updated_at;
  final int created_at;

  admin({required this.status,required this.password,required this.id,
    required this.created_at,required this.updated_at,required this.email
  });
}