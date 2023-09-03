class todoItem {
  final String title;
  final String description;
  final String id;
  todoItem({
    required this.title,
    required this.description,
  }) : id = DateTime.timestamp().toString();
}
