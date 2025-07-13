import 'package:notes_app/editnotes.dart';
import 'sqldb.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Sqldb sqlDb = Sqldb();
  bool isLoading = true;
  List notes = [];

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add, color: Colors.white, size: 28),
        backgroundColor: Colors.blue.shade800,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: notes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_add, size: 60, color: Colors.blue.shade200),
                    SizedBox(height: 20),
                    Text(
                      "No notes yet",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tap + to add your first note",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                padding: EdgeInsets.all(15),
                itemBuilder: (context, i) {
                  Color noteColor;
                  try {
                    noteColor = Color(int.parse(notes[i]['color']));
                  } catch (e) {
                    noteColor = Colors.white;
                  }

                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: noteColor.withOpacity(0.9),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        "${notes[i]['title']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: noteColor.computeLuminance() > 0.5 
                              ? Colors.black 
                              : Colors.white,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "${notes[i]['note']}",
                          style: TextStyle(
                            fontSize: 15,
                            color: noteColor.computeLuminance() > 0.5 
                                ? Colors.black87 
                                : Colors.white70,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              int response = await sqlDb.delete(
                                  "notes", "id= ${notes[i]['id']}");
                              if (response > 0) {
                                notes.removeWhere(
                                    (element) => element['id'] == notes[i]['id']);
                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.delete,
                                color: noteColor.computeLuminance() > 0.5
                                    ? Colors.red.shade700
                                    : Colors.red.shade300),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Editnotes(
                                    note: notes[i]['note'],
                                    title: notes[i]['title'],
                                    color: notes[i]['color'],
                                    id: notes[i]['id'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit,
                                color: noteColor.computeLuminance() > 0.5
                                    ? Colors.blue.shade700
                                    : Colors.blue.shade300),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}