import 'package:flutter/material.dart';
import '../models/datos_model.dart';
import 'package:uuid/uuid.dart';

class AgregarPersonaje extends StatefulWidget {
  @override
  _AgregarPersonajeState createState() => _AgregarPersonajeState();
}

class _AgregarPersonajeState extends State<AgregarPersonaje> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _urlImagenController = TextEditingController();

  final _filmsController = TextEditingController();
  final _shortFilmsController = TextEditingController();
  final _tvShowsController = TextEditingController();
  final _videoGamesController = TextEditingController();
  final _parkAttractionsController = TextEditingController();
  final _alliesController = TextEditingController();
  final _enemiesController = TextEditingController();

  List<String> _films = [];
  List<String> _shortFilms = [];
  List<String> _tvShows = [];
  List<String> _videoGames = [];
  List<String> _parkAttractions = [];
  List<String> _allies = [];
  List<String> _enemies = [];

  void _saveCharacter() {
    if (_formKey.currentState!.validate()) {
      final id = Uuid().v4();
      final nuevoPersonaje = Personaje(
        id: id.hashCode,
        nombre: _nombreController.text,
        urlimagen: _urlImagenController.text,
        films: _films,
        shortFilms: _shortFilms,
        tvShows: _tvShows,
        videoGames: _videoGames,
        parkAttractions: _parkAttractions,
        allies: _allies,
        enemies: _enemies,
      );
      Navigator.pop(context, nuevoPersonaje);
    }
  }

  void _addToList(TextEditingController controller, List<String> list) {
    if (controller.text.isNotEmpty) {
      setState(() {
        list.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Personaje'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  icon: Icon(Icons.person, color: Colors.purple),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
              // URL de Imagen
              TextFormField(
                controller: _urlImagenController,
                decoration: InputDecoration(
                  labelText: 'URL de Imagen',
                  icon: Icon(Icons.image, color: Colors.purple),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una URL de imagen';
                  }
                  return null;
                },
              ),

              // Films
              _buildListField(
                  controller: _filmsController,
                  list: _films,
                  labelText: 'Films',
                  icon: Icons.movie
              ),

              // Short Films
              _buildListField(
                  controller: _shortFilmsController,
                  list: _shortFilms,
                  labelText: 'Short Films',
                  icon: Icons.short_text
              ),

              // TV Shows
              _buildListField(
                  controller: _tvShowsController,
                  list: _tvShows,
                  labelText: 'TV Shows',
                  icon: Icons.tv
              ),

              // Video Games
              _buildListField(
                  controller: _videoGamesController,
                  list: _videoGames,
                  labelText: 'Video Games',
                  icon: Icons.videogame_asset
              ),

              // Park Attractions
              _buildListField(
                  controller: _parkAttractionsController,
                  list: _parkAttractions,
                  labelText: 'Park Attractions',
                  icon: Icons.location_on
              ),

              // Allies
              _buildListField(
                  controller: _alliesController,
                  list: _allies,
                  labelText: 'Allies',
                  icon: Icons.group
              ),

              // Enemies
              _buildListField(
                  controller: _enemiesController,
                  list: _enemies,
                  labelText: 'Enemies',
                  icon: Icons.warning
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCharacter,
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListField({
    required TextEditingController controller,
    required List<String> list,
    required String labelText,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            icon: Icon(icon, color: Colors.purple),
            suffixIcon: IconButton(
              icon: Icon(Icons.add, color: Colors.purple),
              onPressed: () => _addToList(controller, list),
            ),
          ),
          onFieldSubmitted: (value) => _addToList(controller, list),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: list.map((item) => Chip(
            label: Text(item),
            onDeleted: () {
              setState(() {
                list.remove(item);
              });
            },
          )).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}