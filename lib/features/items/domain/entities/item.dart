class Item {
  final String id;
  final String title;
  final String? description;

 const Item({
    required this.id,
    required this.title,
    this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}
