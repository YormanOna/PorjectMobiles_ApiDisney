import 'package:flutter/material.dart';
import '../controllers/datos_controller.dart';
import '../models/datos_model.dart';

class PageCaracter extends StatelessWidget {
  final int id;

  PageCaracter({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Character Details'),
      ),
      body: FutureBuilder<DatosApi>(
        future: ControladorDatos().obtenerUnDato(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No hay datos disponibles'));
          } else {
            final datos = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: datos.urlimagen.isNotEmpty
                          ? Image.network(
                        datos.urlimagen,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    datos.nombre,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  InfoRow(
                    icon: Icons.badge,
                    label: 'ID',
                    value: datos.id.toString(),
                  ),
                  InfoRow(
                    icon: Icons.movie,
                    label: 'Films',
                    value: datos.films.isNotEmpty ? datos.films.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.short_text,
                    label: 'Short Films',
                    value: datos.shortFilms.isNotEmpty ? datos.shortFilms.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.tv,
                    label: 'TV Shows',
                    value: datos.tvShows.isNotEmpty ? datos.tvShows.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.videogame_asset,
                    label: 'Video Games',
                    value: datos.videojuegos.isNotEmpty ? datos.videojuegos.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.attractions,
                    label: 'Park Attractions',
                    value: datos.parquesAtracciones.isNotEmpty ? datos.parquesAtracciones.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.group,
                    label: 'Allies',
                    value: datos.aliados.isNotEmpty ? datos.aliados.join(", ") : 'None',
                  ),
                  InfoRow(
                    icon: Icons.warning,
                    label: 'Enemies',
                    value: datos.enemigos.isNotEmpty ? datos.enemigos.join(", ") : 'None',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
