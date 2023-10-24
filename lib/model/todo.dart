
class ToDO {
  String? id;
  String? todoText;
  bool isDone;

  ToDO({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDO> TodoList() {
    return [
      ToDO(id: "01", todoText: "Authentication Service", isDone: true),
      ToDO(id: "02", todoText: "Customer Service", isDone: false),
      ToDO(id: "03", todoText: "Product Service", isDone: false),
      ToDO(id: "04", todoText: "Order Service", isDone: false),
    ];
  }
}