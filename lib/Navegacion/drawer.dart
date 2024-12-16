import 'package:app_autonomo/Screens/crearNotas.dart';
import 'package:app_autonomo/Screens/notasDetalles.dart';
import 'package:app_autonomo/Screens/notasScreen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userId; // Asegúrate de tener un userId en esta clase

  const MyDrawer({super.key, required this.userId}); // Asegúrate de pasar el userId cuando crees el MyDrawer

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Fondo negro para el Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black, // Fondo negro para el header
              ),
              child: Text(
                'Menú de Navegación',
                style: TextStyle(
                  color: Colors.white, // Texto en blanco
                  fontSize: 18, // Título más pequeño
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Crear Nota",
                style: TextStyle(
                  color: Colors.white, // Texto blanco
                  fontSize: 16, // Tamaño de texto ajustado
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateNoteScreen(userId: userId)), // Pasa el userId aquí
                );
              },
            ),
            ListTile(
              title: Text(
                "Lista de Notas",
                style: TextStyle(
                  color: Colors.white, // Texto blanco
                  fontSize: 16, // Tamaño de texto ajustado
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesListScreen(userId: userId)), // Pasa el userId aquí también
                );
              },
            ),
            ListTile(
              title: Text(
                "Detalle de Nota",
                style: TextStyle(
                  color: Colors.white, // Texto blanco
                  fontSize: 16, // Tamaño de texto ajustado
                ),
              ),
              onTap: () {
                // Suponiendo que tienes un `noteId` para el detalle de la nota
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen(userId: userId)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
