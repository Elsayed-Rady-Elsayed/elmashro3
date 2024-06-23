class address{
  final int id;
  final String street;
  final String floor;
  final String building;
  final String notes;
  final String updated_at;
  final int created_at;

  address({required this.notes,required this.building,required this.id,
    required this.created_at,required this.floor,required this.updated_at,required this.street
  });
}