import 'package:app_autonomo/Screens/crearNotas.dart';
import 'package:app_autonomo/Screens/editarNotas.dart';
import 'package:app_autonomo/Screens/listaNotas.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userId; 

  const MyDrawer({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, 
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black, 
              ),
              child: Text(
                'Navegacion de Notas',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Crear Nota",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrearNotas(userId: userId)), 
                );
              },
            ),
            ListTile(
              title: Text(
                "Lista de Notas",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaNotas(userId: userId)), 
                );
              },
            ),
            ListTile(
              title: Text(
                "Editar Notas",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                ),
              ),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditarScreen(userId: userId)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
