import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_todo/core/extensions/extensions.dart';

import '../../../core/feature/model/params/todo_filter_params.dart';
import '../../../core/feature/model/response/todo_model.dart';
import '../../../injection_container.dart';
import '../bloc/todo_bloc.dart';
import '../widget/add_todo_widget.dart';
import '../widget/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> todoList= [];
  ToDoFilterParams params = ToDoFilterParams(onlyNotCompleted: false);

  @override
  void initState(){
    super.initState();
    _requestToDos();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: onAddClick,
            child: const Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'My ToDo',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontSize: 100.h,
                    ),),

                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: params.onlyNotCompleted,
                      onChanged: (val){
                        params.onlyNotCompleted = val ?? false;
                        setState(() {
                        });
                        _requestToDos();
                      },
                      checkColor: context.colorScheme.surface,
                    ),
                    Text('Show only not completed todo'),
                  ],
                ),
                Expanded(
                  child: BlocConsumer<ToDoBloc, ToDoState>(
                    bloc: sl<ToDoBloc>(),
                    listenWhen: (cur, prev) => cur != prev,
                    listener: _todoStateListener,
                    buildWhen: (cur, prev) => cur != prev,
                    builder: (context, state) {
                      if (state is ToDoLoading || state is DeleteToDoLoading) {
                        return const Center(child: Center(
                          child: CircularProgressIndicator(),
                        ));

                      }
                      return _buildToDoList();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }


  Widget _buildToDoList() => Scrollbar(
    interactive: true,
    radius: const Radius.circular(10),
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ToDoCard(
          todo: todoList.elementAt(index),
        );
      },
      padding: EdgeInsets.symmetric(
        vertical: 39.h,
      ),
      itemCount: todoList.length,
      separatorBuilder: (
          BuildContext context,
          int index,
          ) =>
     SizedBox(height: 20.h,),
    ),
  );

  void _todoStateListener(BuildContext context, ToDoState state) {
    if (state is ToDoError) {
      Fluttertoast.showToast(msg: state.message ?? '',);
    }
    if (state is ToDoLoaded) {
      todoList=state.todoList;
    }
    if (state is DeleteToDoLoaded) {
      _requestToDos();
    }
    if (state is UpdateToDoLoaded) {
      _requestToDos();
    }
    if (state is CreateToDoLoaded) {
      Navigator.pop(context);
      _requestToDos();
    }
  }

  void _requestToDos() {
    sl<ToDoBloc>().add(GetToDoLisLtEvent(params: params,
        ));
  }

  void onAddClick(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(20.r),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: const AddToDoWidget(

        ),
      ),
    );
  }
}
