import 'package:app_autonomo/Navegacion/drawer.dart';
import 'package:app_autonomo/Screens/editarNotas.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListaNotas extends StatelessWidget {
  final String userId; 

  ListaNotas({required this.userId});

  Future<List<Map<String, dynamic>>> fetchNotes() async {
    DatabaseReference notesRef = FirebaseDatabase.instance.ref('users/$userId/notes');
    final snapshot = await notesRef.get();
    final data = snapshot.value;

    if (data != null) {
      Map<dynamic, dynamic> mapData = data as Map<dynamic, dynamic>;
      List<Map<String, dynamic>> notesList = [];
      mapData.forEach((key, value) {
        notesList.add({
          'id': key,
          'title': value['title'],
          'description': value['description'],
          'price': value['price'],
        });
      });
      return notesList;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(userId: userId), 
      appBar: AppBar(
        title: Text("Notas de Gastos"),
        backgroundColor: Colors.blueGrey, 
      ),
      body: FutureBuilder(
        future: fetchNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    title: Text(
                      note['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800], 
                      ),
                    ),
                    subtitle: Text(
                      "${note['description']} - \$${note['price']}",
                      style: TextStyle(
                        color: Colors.blueGrey[600], 
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarScreen(
                          userId: userId, 
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No hay notas disponibles"));
          }
        },
      ),
    );
  }
}
