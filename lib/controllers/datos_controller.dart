import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tarea_api_disney/models/datos_model.dart';


class ControladorDatos {

  Future<DatosApi> obtenerUnDato(int id) async {

    final response = await http.get(Uri.parse('https://api.disneyapi.dev/character/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      if (data != null) {
        return DatosApi.fromJson(data);
      } else {
        throw Exception('Character not found');
      }
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<DatosApi>> obtenerTodosLosDatos(int page) async {
    final respuesta = await http.get(Uri.parse('https://api.disneyapi.dev/character/?page=$page'));

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = json.decode(respuesta.body)['data'];
      return datos.map((json) => DatosApi.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los datos');
    }
  }

  Future<List<DatosApi>> filtrarDatos(String queryParams) async {
    final response = await http.get(Uri.parse('https://api.disneyapi.dev/character?$queryParams'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => DatosApi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to filter characters');
    }
  }
}