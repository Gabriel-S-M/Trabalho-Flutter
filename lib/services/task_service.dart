import 'dart:convert';

import 'package:new_project/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  //SALVAR TAREFAS
  Future<void> saveTask(
      String title, String description, String priority, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task task =
        Task(title: title, description: description, priority: priority);
    tasks.add(jsonEncode(task.toJson()));
    await prefs.setStringList('tasks', tasks);
    print('adicionado');
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = tasksString
        .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
        .toList();
    return tasks;
  }

  deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks);
  }

  editTask(int index, String title, String description, String priority,
      bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task updatedTask = Task(
        description: description,
        title: title,
        priority: priority,
        isDone: isDone);
    tasks[index] = jsonEncode(updatedTask.toJson());
    await prefs.setStringList('tasks', tasks);
  }

  editTaskByCheckBox(int index, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task existingTask = Task.fromJson(jsonDecode(tasks[index]));
    existingTask.isDone = isDone;

    tasks[index] = jsonEncode(existingTask.toJson());
    await prefs.setStringList('tasks', tasks);
    print('Editou isDone');
  }
}
