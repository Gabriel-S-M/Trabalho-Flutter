import 'package:flutter/material.dart';
import 'package:new_project/models/task_model.dart';
import 'package:new_project/services/task_service.dart';

class CreateTasks extends StatefulWidget {
  final Task? task;
  final int? index;
  const CreateTasks({super.key, this.task, this.index});

  @override
  State<CreateTasks> createState() => _CreateTasksState();
}

class _CreateTasksState extends State<CreateTasks> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TaskService TasksService = TaskService();
  String _priority = 'Baixa'; // default priority

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.task != null ? 'Editar Tarefa' : 'Criar nova tarefa'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Titulo não preenchido!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(_titleController.text);
                      },
                      decoration: InputDecoration(
                          label: Text('Titulo'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' * Descrição não preenchida!';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      maxLength: null,
                      decoration: InputDecoration(
                          label: Text('Descrição'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Baixa',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value as String;
                        });
                      },
                    ),
                    Text('Baixa'),
                    Radio(
                      value: 'Média',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value as String;
                        });
                      },
                    ),
                    Text('Média'),
                    Radio(
                      value: 'Alta',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value as String;
                        });
                      },
                    ),
                    Text('Alta'),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String titleNewTask = _titleController.text;
                        String descriptionNewTask = _descriptionController.text;
                        if (widget.task != null && widget.index != null) {
                          await TasksService.editTask(
                              widget.index!,
                              titleNewTask,
                              descriptionNewTask,
                              _priority,
                              false);
                        } else {
                          await TasksService.saveTask(titleNewTask,
                              descriptionNewTask, _priority, false);
                        }

                        Navigator.pop(context);
                      }
                    },
                    child: Text(widget.task != null
                        ? 'Alterar Tarefa'
                        : 'Adicionar Tarefas'))
              ],
            ),
          ),
        ));
  }
}
