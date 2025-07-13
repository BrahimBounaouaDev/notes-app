import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/sqldb.dart';

class Addnotes extends StatefulWidget {
  Addnotes({Key? key}) : super(key: key);

  @override
  State<Addnotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<Addnotes> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Form(
          key: formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter note title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.title, color: Colors.blue),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: note,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Note",
                  hintText: "Write your note here",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.note, color: Colors.blue),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: color,
                decoration: InputDecoration(
                  labelText: "Color Code",
                  hintText: "e.g. 0xFF4285F4",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.color_lens, color: Colors.blue),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  int response = await sqldb.insert("notes", {
                    "note": "${note.text}",
                    "title": "${title.text}",
                    "color": "${color.text}"
                  });

                  if (response > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
                  }
                },
                child: Text("SAVE NOTE", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







