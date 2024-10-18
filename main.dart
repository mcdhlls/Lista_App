import 'package:flutter/material.dart';

void main() => runApp(AgendaApp());

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      home: AgendaPage(),
    );
  }
}

class Agenda {
  String nombre;
  String control;

  Agenda(this.nombre, this.control);
}

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final List<Agenda> _contactos = [];
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _controlController = TextEditingController();
  int _contactCount = 0;

  void _agregarContacto() {
    final nombre = _nombreController.text;
    final control = _controlController.text;

    if (nombre.isNotEmpty && control.isNotEmpty) {
      setState(() {
        _contactos.add(Agenda(nombre, control));
        _contactCount = _contactos.length;
      });

      _nombreController.clear();
      _controlController.clear();
    }
  }

  void _verAgenda() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListadoContactosPage(contactos: _contactos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _controlController,
              decoration: InputDecoration(labelText: 'No. Control'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarContacto,
              child: Text('Agregar'),
            ),
            ElevatedButton(
              onPressed: _verAgenda,
              child: Text('Ver agenda'),
            ),
            SizedBox(height: 20),
            Text('Total de contactos: $_contactCount'),
          ],
        ),
      ),
    );
  }
}

class ListadoContactosPage extends StatelessWidget {
  final List<Agenda> contactos;

  ListadoContactosPage({required this.contactos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Contactos'),
      ),
      body: ListView.builder(
        itemCount: contactos.length,
        itemBuilder: (context, index) {
          final contacto = contactos[index];
          return ListTile(
            title: Text(contacto.nombre),
            subtitle: Text('No. Control: ${contacto.control}'),
          );
        },
      ),
    );
  }
}
