import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:task_managment/Task.dart';

class TaskListAddScreen extends StatefulWidget {
  const TaskListAddScreen({super.key});

  @override
  State<TaskListAddScreen> createState() => _TaskListAddScreenState();
}

class _TaskListAddScreenState extends State<TaskListAddScreen> {
  final TextEditingController taskController = TextEditingController();
  bool _inproess=false;

  void dispose(){
    taskController.dispose();
    super.dispose();
  }

  void showInSnacker(String value){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value,textAlign: TextAlign.center),
      backgroundColor: Colors.black54,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void addTaskToFireStore() async{
    setState(() {
      _inproess=true;
    });

    if(taskController.text.isEmpty){
      showInSnacker("please write your task! ");
    }

    if(taskController.text.isNotEmpty){
      Task newTask = Task(
          title: taskController.text.toString(),
          isDone: false,
          date: DateTime.now(),);

      //firebase instance
       await FirebaseFirestore.instance
           .collection('task')
           .doc(taskController.text.toString())
           .set(newTask.toFireStore());

       taskController.clear();
       setState(() {
        _inproess=false;
       });
       showInSnacker("New task added");


       Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // building api call from
      body:ModalProgressHUD(
        inAsyncCall: _inproess,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left:10.0,top:40.0),
              child: const BackButton(color: Colors.black,),
            ),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top:100.0),
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
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget> [
                            Text(
                              'New',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),

                              ),
                             Text(
                                "Task",
                                style:TextStyle(
                                     fontSize: 28.0,color: Colors.grey),
                          )
                          ],
                         )),
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
                Padding(padding: EdgeInsets.only(
                  top: 50.0,
                  left:20.0,
                  right: 20.0,
                ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal,),
                      ),

                      labelText: 'Task name',
                      contentPadding: EdgeInsets.only(
                        left: 16.0,
                        top: 20.0,
                        right:16.0,
                        bottom: 5.0,
                      ),
                    ),
                    controller: taskController,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 40,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 24.0),
                child:
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white
                              ),

                              onPressed: (){
                                addTaskToFireStore();

                              }, child: const Text(
                            'Add New Task',
                            style: TextStyle(color: Colors.white),
                          ),)


                )
              ],
                ),

              ],
            ),
          ),
        );
  }
}
