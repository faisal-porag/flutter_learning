import 'package:flutter/material.dart';
import 'package:learningdart/constants/colors.dart';
import 'package:learningdart/model/todo.dart';
import 'package:learningdart/widgets/todo_items.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDO.TodoList();
  final _todoController = TextEditingController();
  List<ToDO> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,  
                          ),
                        ),
                      ),
                      for (ToDO todoo in _foundTodo)
                        TodoItem(
                          todo: todoo,
                          onTodoChanged: _handleTodoChange,
                          onDeleteItem: _handleTodoItemDelete,
                        ),
                     
                  ],),
                )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                  bottom: 20, 
                  right: 20, 
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [BoxShadow(
                    color: Colors.grey, 
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: "Add new todo item",
                    border: InputBorder.none,
                  ),
                ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text("+", style: TextStyle(fontSize: 40, color: Colors.white),),
                  onPressed: (){
                    // print("Clicked on add button");
                    _handleAddNewTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );

  }

  void _handleTodoChange(ToDO todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleTodoItemDelete(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _handleAddNewTodoItem(String todoText){
    setState(() {
      todoList.add(ToDO(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todoText));
    });
    _todoController.clear(); // Clean text field after add
  }

  void _handleTodoFilter(String searchKeyWord){
    List<ToDO> results = [];
    if(searchKeyWord.isEmpty || searchKeyWord.trim().isEmpty){
      results = todoList;
    } else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(searchKeyWord.toLowerCase())).toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _handleTodoFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
          ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ]),
    );
  }
}


