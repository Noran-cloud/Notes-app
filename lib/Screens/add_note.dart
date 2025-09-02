import 'package:flutter/material.dart';
import 'package:rwad2/DataBase/DatabaseHelper.dart';
import 'package:rwad2/Screens/notes.dart';
import 'package:rwad2/models/notes.dart';

class AddNote extends StatefulWidget {
  final index;
  const AddNote({super.key, this.index});

  @override
  State<AddNote> createState() => _AddNoteState();
}
  var titleController = TextEditingController();
  var contentController = TextEditingController();
class _AddNoteState extends State<AddNote> {
  bool contentFocus = false;

@override
void initState() {
  super.initState();
  if (widget.index != null && widget.index < notes.length) {
    titleController.text = notes[widget.index].title ?? "";
    contentController.text = notes[widget.index].content ?? "";
  }
  else {
    titleController.clear();
    contentController.clear();
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 143, 247),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () => Navigator.pop(context),),
        actions: [
          IconButton(icon: Icon(Icons.check,color: Colors.white,),
                        onPressed: () {
                          showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text('Save',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: const Color.fromARGB(255, 105, 143, 247)),),
                  content: Text('Are you sure you want to save this note?',style: TextStyle(color: Colors.black),),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      setState(() {
                        if(widget.index < notes.length )
                        db.updateNote(Notes(id: notes[widget.index].id,title: '${titleController.text}', content: '${contentController.text}'));
                        else
                        db.insertNote(Notes(title: '${titleController.text}', content: '${contentController.text}'));
                        Navigator.pop(context);
                      
                      });
                    }, 
                    child: Text('SAVE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text('CANCEL',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                  ],
                );
              });
                        },
                    ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(icon: Icon(Icons.delete,color: Colors.white,),onPressed: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: const Color.fromARGB(255, 105, 143, 247)),),
                  content: Text('Are you sure you want to delete this note?',style: TextStyle(color: Colors.black),),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      setState(() {
                      db.deleteNote(notes[widget.index].id!);
                        Navigator.pop(context);
                      
                      });
                    }, 
                    child: Text('DELETE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text('CANCEL',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                  ],
                );
              });
            },)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                controller:  titleController,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hint: Text('title',textAlign: TextAlign.center,style: TextStyle(color: const Color.fromARGB(255, 226, 224, 224),fontWeight: FontWeight.bold,fontSize: 25),)
                  ),
              ),
            ),
            TextField( 
              maxLines: 500,
              autofocus: contentFocus,
              controller: contentController,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  ),
            )
          ],
        ),
      ),
    );
  }
}