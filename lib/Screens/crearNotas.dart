import 'package:app_autonomo/Navegacion/drawer.dart'; // Asegúrate de que MyDrawer esté importado correctamente
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CreateNoteScreen extends StatelessWidget {
  final String userId;  // El userId necesario para el Drawer

  CreateNoteScreen({required this.userId});  // Recibimos el userId en el constructor

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    // Método para guardar la nota en Firebase
    Future<void> saveNote() async {
      final title = titleController.text;
      final description = descriptionController.text;
      final price = double.tryParse(priceController.text) ?? 0.0;

      // Verifica que todos los campos estén completos
      if (title.isEmpty || description.isEmpty || price <= 0) {
        // Muestra un mensaje de error si algún campo está vacío o el precio es 0
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, completa todos los campos')),
        );
        return;
      }

      try {
        DatabaseReference notesRef = FirebaseDatabase.instance.ref('users/$userId/notes');
        final newNoteRef = notesRef.push();  // Crea una nueva referencia para la nota

        // Guardamos los datos de la nueva nota en Firebase
        await newNoteRef.set({
          'title': title,
          'description': description,
          'price': price,
        });

        // Una vez guardado, volvemos a la pantalla anterior
        Navigator.pop(context);
      } catch (e) {
        // Manejo de errores en caso de que ocurra algún problema con Firebase
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la nota: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Nueva Nota")),
      drawer: MyDrawer(userId: userId),  // Pasamos el userId al Drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote, // Llama a la función para guardar la nota
              child: Text("Guardar Nota"),
            ),
          ],
        ),
      ),
    );
  }
}
