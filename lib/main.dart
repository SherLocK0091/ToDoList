import 'package:flutter/material.dart'; //Flutter framework'ünün Material Design widget'larını içe aktarır.

void main() {
  runApp(MyApp()); //Uygulamanın ana işlevi, MyApp widget'ını çalıştırır
}

class MyApp extends StatelessWidget {
  //Stateless widget olan MyApp sınıfı, uygulamanın ana widget'ıdır.

  @override //StatelessWidget, build() yöntemini uygulamak zorundadır. MyApp sınıfının build() yöntemi, uygulamanın arayüzünü oluşturur.

  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp widget'ı, uygulamanın genel görünümünü tanımlar.

      debugShowCheckedModeBanner:
          false, //Bu ayar, debug modunda uygulamanın üstünde çıkan "debug" etiketini kaldırır.
      title: 'To-do List', //Uygulamanın adı.
      theme: ThemeData.from(
          colorScheme: ColorScheme.light()), //Uygulamanın tema ayarları.
      home: TodoList(), //Uygulamanın ana sayfası, TodoList sınıfından oluşur.
    );
  }
}

class Todo {
  //sınıfı, bir to-do listesindeki bir öğeyi temsil eder.
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}

class TodoList extends StatefulWidget {
  //sınıfı, StatefulWidget widget'ıdır ve bir to-do listesi oluşturmak için kullanılır.
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todoList = []; //sınıfının bir özelliği, to-do listesini depolar.

  final TextEditingController _textEditingController =
      TextEditingController(); //sınıfının bir özelliği, metin alanının kontrolcüsüdür.





/*
  @override
  void dispose() {
    _textEditingController.dispose();//textEditingController nesnesinin kullanımdan kaldırılmasını sağlar ve böylece bellek sızıntılarını önler. 
    super.dispose();
  }
*/










//Yeni bir to-do öğesi eklemek için kullanılan bir yöntem.
  void addTodo() {
    setState(() {
      String newTodo = _textEditingController.text;
      if (newTodo.isNotEmpty) {
        todoList.add(Todo(title: newTodo));
        _textEditingController.clear();
      }
    });
  }

//Belirtilen dizindeki to-do öğesini listeden kaldırmak için kullanılan bir yöntem.
  void removeTodoAtIndex(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

// Belirtilen dizindeki to-do öğesinin tamamlandı durumunu tersine çevirmek için kullanılan bir yöntem.
  void toggleTodoAtIndex(int index) {
    setState(() {
      todoList[index].isCompleted = !todoList[index].isCompleted;
    });
  }

//sınıfının build() yöntemi, uygulamanın to-do listesi arayüzünü oluşturur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 121, 94),
        title: Center(
          child: Text(
            'Yapılacaklar Listesi',
            style: TextStyle(
              color: Color.fromARGB(255, 205, 133, 63),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(199, 139, 120, 95), //Uygulamanın arka plan rengini ayarlar.
      body: Column(
        /* Bu kod, bir metin alanı ve yanındaki bir ekle düğmesi içeren bir düzenleme oluşturur. 
        Kullanıcı metin alanına bir görev ekleyebilir ve ardından ekle düğmesine basarak listeye ekleyebilir.*/ 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Yeni Görev Ekle',
                      //border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => addTodo(),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTodo,
                ),
              ],
            ),
          ),
          /* her öğe için bir ListTile oluşturur ve ListTile'ın sağ tarafında silme işlevi için bir IconButton ekler. 
          IconButton'a tıklanıldığında, listeden o öğe kaldırılır.*/
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  /* her bir todo öğesi için check box tanımlar ve değerini kontrol eder */
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) => toggleTodoAtIndex(index),
                    activeColor: Colors.green,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeTodoAtIndex(index),
                  ),
                  tileColor:
                      todo.isCompleted ? null : Colors.red.withOpacity(0.2),/*görev tamamlandımı diye kontrol eder eğer tamamlandıysa kutunun rengi değişmez 
                      tamamlanmadıysa hafif kırmızı bir renk verir*/
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
