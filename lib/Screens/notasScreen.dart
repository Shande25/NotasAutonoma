import 'package:app_autonomo/Navegacion/drawer.dart';
import 'package:app_autonomo/Screens/notasDetalles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotesListScreen extends StatelessWidget {
  final String userId; // Este sería el userId del usuario autenticado

  NotesListScreen({required this.userId});

  // Función para leer las notas del usuario
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
      drawer: MyDrawer(userId: userId), // Aquí le pasas el userId
      appBar: AppBar(
        title: Text("Notas de Gastos"),
        backgroundColor: Colors.blueGrey, // Cambié el color de fondo del AppBar
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
                        color: Colors.blueGrey[800], // Color del título
                      ),
                    ),
                    subtitle: Text(
                      "${note['description']} - \$${note['price']}",
                      style: TextStyle(
                        color: Colors.blueGrey[600], // Color del subtítulo
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesScreen(
                          userId: userId, // Aquí también le pasas el userId
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
