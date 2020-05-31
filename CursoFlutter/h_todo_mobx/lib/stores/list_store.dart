import 'package:h_todo_mobx/stores/todo_store.dart';
import 'package:mobx/mobx.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {

  @observable
  String newTodoTitle = "";

  @action
  void setNewTodoTitle(value) => newTodoTitle = value;

  @computed
  bool get isTodoEmpty => newTodoTitle.isEmpty;

  @observable
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() => todoList.insert(0, TodoStore(title: newTodoTitle));

  @action
  void removoTodo(index) => todoList.removeAt(index);

}
