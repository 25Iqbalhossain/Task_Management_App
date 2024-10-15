import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'task_list_add_screen.dart';
import 'task_list_screen.dart';

class Task{
  final String title;
  final bool isDone;
  final DateTime date;

 //constuctor
  Task({
    required this.title,
    required this.isDone,
    required this.date,
  });

  String get formattedDate{
    final DateFormat formatter= DateFormat('EEE d,yyyy');
    return formatter.format(date);
  }


  factory Task.fromFireStore( Map<String, dynamic> data){
    return Task(title: data['title'], isDone: data['isDone'], date: (data['date'] as Timestamp).toDate() );
  }

Map<String,dynamic>toFireStore(){
  return{
    'title':title,
    'isDone':isDone,
    'date':date,
  };

}

}
