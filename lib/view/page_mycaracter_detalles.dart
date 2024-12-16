import 'package:flutter/material.dart';
import '../models/datos_model.dart';

class PersonajePage extends StatefulWidget {
  final Personaje personaje;

  PersonajePage({required this.personaje});

  @override
  _PersonajePageState createState() => _PersonajePageState();
}

class _PersonajePageState extends State<PersonajePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _urlImagenController;
  late TextEditingController _filmsController;
  late TextEditingController _shortFilmsController;
  late TextEditingController _tvShowsController;
  late TextEditingController _videoGamesController;
  late TextEditingController _parkAttractionsController;
  late TextEditingController _alliesController;
  late TextEditingController _enemiesController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the personaje data
    _nombreController = TextEditingController(text: widget.personaje.nombre);
    _urlImagenController = TextEditingController(text: widget.personaje.urlimagen);
    _filmsController = TextEditingController(text: widget.personaje.films.join(", "));
    _shortFilmsController = TextEditingController(text: widget.personaje.shortFilms.join(", "));
    _tvShowsController = TextEditingController(text: widget.personaje.tvShows.join(", "));
    _videoGamesController = TextEditingController(text: widget.personaje.videoGames.join(", "));
    _parkAttractionsController = TextEditingController(text: widget.personaje.parkAttractions.join(", "));
    _alliesController = TextEditingController(text: widget.personaje.allies.join(", "));
    _enemiesController = TextEditingController(text: widget.personaje.enemies.join(", "));
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveEdits() {
    if (_formKey.currentState!.validate()) {
      // Use temporary variables to hold the new values
      String newNombre = _nombreController.text;
      String newUrlImagen = _urlImagenController.text;
      List<String> newFilms = _filmsController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newShortFilms = _shortFilmsController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newTvShows = _tvShowsController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newVideoGames = _videoGamesController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newParkAttractions = _parkAttractionsController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newAllies = _alliesController.text.split(", ").where((e) => e.isNotEmpty).toList();
      List<String> newEnemies = _enemiesController.text.split(", ").where((e) => e.isNotEmpty).toList();

      // Set the new values to the personaje object
      setState(() {
        widget.personaje.nombre = newNombre;
        widget.personaje.urlimagen = newUrlImagen;
        widget.personaje.films = newFilms;
        widget.personaje.shortFilms = newShortFilms;
        widget.personaje.tvShows = newTvShows;
        widget.personaje.videoGames = newVideoGames;
        widget.personaje.parkAttractions = newParkAttractions;
        widget.personaje.allies = newAllies;
        widget.personaje.enemies = newEnemies;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos guardados exitosamente')),
      );

      // Pass the updated personaje back to the previous screen
      Navigator.pop(context, widget.personaje);
    } else {
      print("Form validation failed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Personaje' : 'Detalles del Personaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_isEditing) _buildEditForm() else _buildDetailView(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isEditing) {
            _saveEdits();
          } else {
            _toggleEditMode();
          }
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(_isEditing ? Icons.save : Icons.edit),
      ),
    );
  }

  Widget _buildDetailView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: widget.personaje.urlimagen.isNotEmpty
                ? Image.network(
              widget.personaje.urlimagen,
              height: 200,
              fit: BoxFit.cover,
            )
                : Container(
              height: 200,
              color: Colors.grey,
              child: Icon(
                Icons.image_not_supported,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Nombre: ${widget.personaje.nombre}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 8),
        ..._buildInfoRows(),
      ],
    );
  }

  List<Widget> _buildInfoRows() {
    return [
      _buildInfoRow(Icons.movie, 'Films', widget.personaje.films.join(", ")),
      _buildInfoRow(Icons.short_text, 'Short Films', widget.personaje.shortFilms.join(",")),
      _buildInfoRow(Icons.tv, 'TV Shows', widget.personaje.tvShows.join(",")),
      _buildInfoRow(Icons.videogame_asset, 'Video Games', widget.personaje.videoGames.join(",")),
      _buildInfoRow(Icons.attractions, 'Park Attractions', widget.personaje.parkAttractions.join(",")),
      _buildInfoRow(Icons.group, 'Allies', widget.personaje.allies.join(",")),
      _buildInfoRow(Icons.warning, 'Enemies', widget.personaje.enemies.join(",")),
    ];
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nombreController,
          decoration: InputDecoration(labelText: 'Nombre'),
          validator: (value) => value!.isEmpty ? 'El nombre no puede estar vacío' : null,
        ),
        TextFormField(
          controller: _urlImagenController,
          decoration: InputDecoration(labelText: 'URL de Imagen'),
          validator: (value) => value!.isEmpty ? 'La URL de imagen no puede estar vacía' : null,
        ),
        TextFormField(controller:_filmsController, decoration :InputDecoration(labelText:'Films')),
        TextFormField(controller:_shortFilmsController, decoration :InputDecoration(labelText:'Short Films')),
        TextFormField(controller:_tvShowsController, decoration :InputDecoration(labelText:'TV Shows')),
        TextFormField(controller:_videoGamesController, decoration :InputDecoration(labelText:'Video Games')),
        TextFormField(controller:_parkAttractionsController, decoration :InputDecoration(labelText:'Park Attractions')),
        TextFormField(controller:_alliesController, decoration :InputDecoration(labelText:'Allies')),
        TextFormField(controller:_enemiesController, decoration :InputDecoration(labelText:'Enemies')),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            '$label:',
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
