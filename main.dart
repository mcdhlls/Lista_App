import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Alumnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomeScreen(),
    );
  }
}

class Persona {
  final String name;
  final String lastname;
  final String cuenta;

  Persona(this.name, this.lastname, this.cuenta);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Persona> _alumnos = [
    Persona('JasielVaro', 'Vazquez', '20221579'),
    Persona('Cielo', 'Silva', '20221680'),
    Persona('Angel', 'Vazquez', '20216534'),
    Persona('Gabriela', 'Topete', '20216635'),
    Persona('Tatiana', 'Rosiles', '20216503'),
    Persona('Alvayaso', 'Cardenas', '20207854'),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cuentaController = TextEditingController();

  void _addAlumno() {
    if (_nameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _cuentaController.text.isNotEmpty) {
      setState(() {
        _alumnos.add(Persona(
          _nameController.text,
          _lastnameController.text,
          _cuentaController.text,
        ));
      });
      _nameController.clear();
      _lastnameController.clear();
      _cuentaController.clear();
      Navigator.of(context).pop(); // Cierra el diálogo
    }
  }

  void _removeAlumno(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar a este alumno?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                setState(() {
                  _alumnos.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddAlumnoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Alumno'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _lastnameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _cuentaController,
                decoration: const InputDecoration(labelText: 'Cuenta'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _addAlumno,
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alumnos'),
      ),
      body: ListView.builder(
        itemCount: _alumnos.length,
        itemBuilder: (context, index) {
          final alumno = _alumnos[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('${alumno.name} ${alumno.lastname}'),
              subtitle: Text('Cuenta: ${alumno.cuenta}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeAlumno(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: _showAddAlumnoDialog,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
