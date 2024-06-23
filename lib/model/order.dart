class order{
  final int id;
  final String totalPrice;
  final String itemPrice;
  final String pay_method;
  final String status;
  final String updated_at;
  final int created_at;

  order({required this.itemPrice,required this.totalPrice,required this.id,
    required this.created_at,required this.status,required this.updated_at,required this.pay_method
  });
}