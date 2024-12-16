import 'package:flutter/material.dart';
import 'package:tarea_api_disney/view/page_crear_personaje.dart';
import 'package:tarea_api_disney/view/page_mycaracter_detalles.dart';
import '../models/datos_model.dart';

class MyCaractersHome extends StatefulWidget {
  @override
  _MyCaractersHomeState createState() => _MyCaractersHomeState();
}

class _MyCaractersHomeState extends State<MyCaractersHome> {
  final TextEditingController _searchController = TextEditingController();
  List<Personaje> _personajes = [];
  List<Personaje> _filteredPersonajes = [];

  @override
  void initState() {
    super.initState();
    _filteredPersonajes = _personajes;
  }

  void _addPersonaje(Personaje personaje) {
    setState(() {
      _personajes.add(personaje);
      _filteredPersonajes = _personajes;
    });
  }

  void _deletePersonaje(int id) {
    setState(() {
      _personajes.removeWhere((personaje) => personaje.id == id);
      _filteredPersonajes = _personajes;
    });
  }

  void _searchPersonajes(String query) {
    final filtered = _personajes.where((personaje) {
      final nombreLower = personaje.nombre.toLowerCase();
      final queryLower = query.toLowerCase();
      return nombreLower.contains(queryLower);
    }).toList();
    setState(() {
      _filteredPersonajes = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis personajes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por nombre',
                labelStyle: TextStyle(color: Colors.deepPurple),
                suffixIcon: Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
              onChanged: _searchPersonajes,
            ),
            SizedBox(height: 10),
            _filteredPersonajes.isEmpty
                ? Center(
              child: Text(
                'No se encontraron personajes.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            )
                : Container(
              height: 400,
              child: ListView.builder(
                itemCount: _filteredPersonajes.length,
                itemBuilder: (context, index) {
                  final personaje = _filteredPersonajes[index];
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          personaje.urlimagen,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        personaje.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontSize: 18,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePersonaje(personaje.id),
                      ),
                      onTap: () async {
                        final updatedPersonaje = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonajePage(personaje: personaje),
                          ),
                        );

                        if (updatedPersonaje != null) {
                          setState(() {
                            int index = _personajes.indexWhere(
                                    (p) => p.id == updatedPersonaje.id);
                            if (index != -1) {
                              _personajes[index] = updatedPersonaje;
                              _filteredPersonajes = _personajes;
                            }
                          });

                          // Mostrar mensaje de actualización exitosa
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Personaje actualizado correctamente'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPersonaje = await Navigator.push<Personaje>(
            context,
            MaterialPageRoute(builder: (context) => AgregarPersonaje()),
          );
          if (newPersonaje != null) {
            _addPersonaje(newPersonaje);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Nuevo personaje agregado correctamente'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
