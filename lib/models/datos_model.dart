class DatosApi{
  final int? id;
  final String nombre;
  final String urlimagen;
  final List<String> films;
  final List<String> shortFilms;
  final List<String> tvShows;
  final List<String> videojuegos;
  final List<String> parquesAtracciones;
  final List<String> aliados;
  final List<String> enemigos;

  //Constructor
  DatosApi({
  required this.id,
  required this.nombre,
  required this.urlimagen,
  required this.films,
  required this.shortFilms,
  required this.tvShows,
  required this.videojuegos,
  required this.parquesAtracciones,
  required this.aliados,
  required this.enemigos,
  });

  factory DatosApi.fromJson(Map<String, dynamic> json) {
    return DatosApi(
      id: json['_id'] ?? 0,
      nombre: json['name'] ?? 'Unknown',
      urlimagen: json['imageUrl'] ?? '',
      films: List<String>.from(json['films'] ?? []),
      shortFilms: List<String>.from(json['shortFilms'] ?? []),
      tvShows: List<String>.from(json['tvShows'] ?? []),
      videojuegos: List<String>.from(json['videoGames'] ?? []),
      parquesAtracciones: List<String>.from(json['parkAttractions'] ?? []),
      aliados: List<String>.from(json['allies'] ?? []),
      enemigos: List<String>.from(json['enemies'] ?? []),
    );
  }
}

class Personaje {
  final int id;
  String nombre;  // Removed 'final' and 'late'
  String urlimagen;  // Removed 'final' and 'late'
  List<String> films;
  List<String> shortFilms;
  List<String> tvShows;
  List<String> videoGames;
  List<String> parkAttractions;
  List<String> allies;
  List<String> enemies;

  Personaje({
    required this.id,
    required this.nombre,
    required this.urlimagen,
    required this.films,
    required this.shortFilms,
    required this.tvShows,
    required this.videoGames,
    required this.parkAttractions,
    required this.allies,
    required this.enemies,
  });
}

