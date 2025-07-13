import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/sqldb.dart';

class Editnotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;

  Editnotes({Key? key, this.note, this.title, this.color, this.id}) : super(key: key);

  @override
  State<Editnotes> createState() => _Editnotes();
}

class _Editnotes extends State<Editnotes> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              int response = await sqldb.update(
                "notes",
                {
                  "note": "${note.text}",
                  "color": "${color.text}",
                  "title": "${title.text}",
                },
                "id= ${widget.id}"
              );

              if (response > 0) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
              }
            },
          ),
        ],
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.color_lens, color: Colors.blue),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  int response = await sqldb.update(
                    "notes",
                    {
                      "note": "${note.text}",
                      "color": "${color.text}",
                      "title": "${title.text}",
                    },
                    "id= ${widget.id}"
                  );

                  if (response > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
                  }
                },
                child: Text("UPDATE NOTE", style: TextStyle(fontSize: 16)),
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


