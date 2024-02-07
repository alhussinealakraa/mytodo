import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_todo/core/extensions/extensions.dart';
import 'package:my_todo/core/feature/model/response/todo_model.dart';

import '../../../core/global/common_text_field.dart';
import '../../../injection_container.dart';
import '../bloc/todo_bloc.dart';

class AddToDoWidget extends StatefulWidget {
  const AddToDoWidget({super.key});

  @override
  State<AddToDoWidget> createState() => _AddToDoWidgetState();
}

class _AddToDoWidgetState extends State<AddToDoWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('New ToDo',
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.primary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),)],
        ),
        SizedBox(
          height: 30.h,
        ),
        CommonTextField(
          hintText: 'Task Title',
          title: 'Task Title',
          controller: _titleController,
        ),
        SizedBox(
          height: 20.h,
        ),
        CommonTextField(
          hintText: 'Description',
          title: 'Description',
          maxLines: 6,
          controller: _descController,
        ),
        BlocConsumer<ToDoBloc, ToDoState>(
          bloc: sl<ToDoBloc>(),
          listenWhen: (cur, prev) => cur != prev,
          listener: (context,state){},
          buildWhen: (cur, prev) => cur != prev,
          builder: (context, state) {
            if (state is CreateToDoLoading) {
              return const Center(child: Center(
                child: CircularProgressIndicator(),
              ));

            }
            return ElevatedButton(
              onPressed: _createTask,
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Save',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.colorScheme.surface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            );
          },
        ),

      ],
    );
  }

  _createTask(){
    if (_descController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      sl<ToDoBloc>().add(CreateToDoEvent(
          todoModel: TodoModel(
            isCompleted: false,
            date: DateTime.now().toString(),
            description: _descController.text,
            title: _titleController.text,
          )
      ));
    } else {
      Fluttertoast.showToast(msg: 'please add title and description',);
    }
  }
}
