import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app_autonomo/Navegacion/drawer.dart';

class CreateNoteScreen extends StatelessWidget {
  final String userId;

  CreateNoteScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    Future<void> saveNote() async {
      final title = titleController.text;
      final description = descriptionController.text;
      final price = double.tryParse(priceController.text) ?? 0.0;

      if (title.isEmpty || description.isEmpty || price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, completa todos los campos')),
        );
        return;
      }

      try {
        DatabaseReference notesRef = FirebaseDatabase.instance.ref('users/$userId/notes');
        final newNoteRef = notesRef.push();

        await newNoteRef.set({
          'title': title,
          'description': description,
          'price': price,
        });

        Navigator.pop(context); // Volver a la pantalla anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la nota: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Nueva Nota")),
      drawer: MyDrawer(userId: userId),  // Aquí no cambiamos la navegación, solo el diseño
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Precio',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey, // Color de fondo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14), // Padding vertical
              ),
              child: Text(
                "Guardar Nota",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
