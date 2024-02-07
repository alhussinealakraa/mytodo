import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo/core/extensions/extensions.dart';
import 'package:my_todo/core/feature/model/response/todo_model.dart';
import 'package:my_todo/feature/home/bloc/todo_bloc.dart';

import '../../../injection_container.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({
    required this.todo,
    super.key});
  final TodoModel todo;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        border: Border.all(
          color: context.colorScheme.primary,
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Checkbox(
            value: widget.todo.isCompleted,
            onChanged: onCompleted,
            checkColor: context.colorScheme.surface,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(widget.todo.title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,)
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text(widget.todo.description,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),maxLines: 3, overflow: TextOverflow.ellipsis,))
                  ],
                ),
              ],
            ),
          ),
          InkWell(
              onTap: deletePressed,
              child: const Center(
                child: Icon(
                  Icons.delete,
                ),
              )
          ),
        ],
      ),
    );

  }

  void onCompleted(val){
    sl<ToDoBloc>().add(UpdateToDoEvent(todoModel: widget.todo.copyWith(
        isCompleted: !widget.todo.isCompleted,
    )));
  }

  void deletePressed(){
    sl<ToDoBloc>().add(DeleteToDoEvent(todoModel: widget.todo));
  }
}
