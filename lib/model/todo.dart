class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Exercícios pela manhã',
        isDone: true,
      ),
      ToDo(
        id: '02',
        todoText: 'Comprar verduras',
        isDone: true,
      ),
      ToDo(
        id: '03',
        todoText: 'Checar e-mails',
      ),
      ToDo(
        id: '04',
        todoText: 'Fazer reunião com a equipe',
      ),
      ToDo(
        id: '05',
        todoText: 'Trabalhar no trabalho da Ana Paula durante 2 horas no dia',
      ),
      ToDo(
        id: '06',
        todoText: 'Estudar comunicação',
      ),
    ];
  }
}
