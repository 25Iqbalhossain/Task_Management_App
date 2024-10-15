
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_managment/task_list_add_screen.dart';
import 'Task.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}
class _TaskListScreenState extends State<TaskListScreen> {
Future<void>_toggleTaskStatus(Task task) async {
  await FirebaseFirestore.instance
      .collection('task')
      .doc(task.title)
      .update({'isDone' : !task.isDone,});
}
  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
                padding:EdgeInsets.only(top: 75.0,left: 16.0,right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/task.png')),
                  SizedBox(width: 16),
                  Text(
                    'Tasky',
                        style:TextStyle(
                      fontSize:30.0,
                          fontWeight: FontWeight.bold,
                  )
                  )


              ],
            ),

            ),
            Padding(padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                  ),
                  const Expanded(
                    flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Your',
                          style:TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold

                      )
                          ),
                          Text(
                            'Tasks',
                            style: TextStyle(
                              fontSize: 28.0,color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                ],
              ),


            ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                ),
                child: IconButton(
                  icon: const Icon(FontAwesomeIcons.plus),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskListAddScreen(),
                      ),
                    );
                  },
                  iconSize: 24.0,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0),
                  child: Text("Add New Task",
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  )
              )

            ],
          ),
        ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('task')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final tasks = snapshot.data!.docs.map((doc) {
                  return Task.fromFireStore(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: task.isDone,
                              onChanged: (value) {
                                _toggleTaskStatus(task);
                              },
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                Text(
                                  task.formattedDate,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
