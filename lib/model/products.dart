class product{
  final int id;
  final String name;
  final String code;
  final String quantity;
  final String price;
  final String updated_at;
  final int image;
  final bool status;
  final String des;
  final String created_at;

  product({required this.price,required this.code,required this.id,required this.name,required this.des,required this.image,required this.quantity,
    required this.created_at,required this.status,required this.updated_at
  });
}