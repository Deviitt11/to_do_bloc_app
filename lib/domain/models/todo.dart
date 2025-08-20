/*

TO DO MODEL

-----------------------------------------------

Cuenta con las siguientes propiedades:

- id
- text
- isCompleted


-----------------------------------------------

Métodos:

- cambiar estado Completed (on & off)

*/

class Todo {

  // atributos
  final int id;
  final String text;
  final bool isCompleted;

  // constructor
  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false // inicialmente incompleto
  });

  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}