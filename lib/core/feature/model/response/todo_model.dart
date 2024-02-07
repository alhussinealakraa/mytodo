import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  late final int? id;
  late final String title;
  late final String description;
  late final String date;
  late final bool isCompleted;
   TodoModel({
    this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ID': id,
      'TITLE': title,
      'DESCRIPTION': description,
      'DATE': date,
      'ISCOMPLETED': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    return TodoModel(
      id: map['ID'] ?? 0,
      title: map['TITLE'] ?? '',
      description: map['DESCRIPTION'] ?? '',
      date: map['DATE'] ?? '',
      isCompleted: (map['ISCOMPLETED'] ?? 0) == 1 ? true : false,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      description,
      date,
      isCompleted,
    ];
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}