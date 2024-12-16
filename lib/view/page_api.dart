import 'package:flutter/material.dart';
import '../controllers/datos_controller.dart';
import '../models/datos_model.dart';
import 'page_character.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  final TextEditingController _busquedaController = TextEditingController();
  List<DatosApi> _datosList = [];
  List<DatosApi> _filteredDatosList = [];
  int _paginaActual = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData(_paginaActual);
    _busquedaController.addListener(_onSearchChanged);
  }

  void _fetchData(int page) {
    setState(() {
      _isLoading = true;
    });
    ControladorDatos().obtenerTodosLosDatos(page).then((data) {
      setState(() {
        _datosList = data;
        _filteredDatosList = data;
        _isLoading = false;
      });
    });
  }

  void _onSearchChanged() {
    final query = _busquedaController.text;
    if (query.isEmpty) {
      setState(() {
        _filteredDatosList = _datosList;
      });
    } else {
      ControladorDatos().filtrarDatos('name=$query').then((filteredData) {
        setState(() {
          _filteredDatosList = filteredData;
        });
      });
    }
  }

  void _siguientePagina() {
    _paginaActual++;
    _fetchData(_paginaActual);
  }

  void _paginaAnterior() {
    if (_paginaActual > 1) {
      _paginaActual--;
      _fetchData(_paginaActual);
    }
  }

  @override
  void dispose() {
    _busquedaController.removeListener(_onSearchChanged);
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disney Characters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                labelStyle: TextStyle(color: Colors.deepPurple),
                prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _filteredDatosList.isEmpty
                  ? Center(
                child: Text(
                  'No hay datos disponibles',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredDatosList.length,
                itemBuilder: (context, index) {
                  final datos = _filteredDatosList[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: datos.urlimagen != null &&
                            datos.urlimagen!.isNotEmpty
                            ? Image.network(
                          datos.urlimagen!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        )
                            : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                          child: Icon(
                              Icons.image_not_supported),
                        ),
                      ),
                      title: Text(
                        datos.nombre ?? 'Unknown',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PageCaracter(id: datos.id!),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _paginaActual > 1 ? _paginaAnterior : null,
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    'Previous',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _datosList.length == 50 ? _siguientePagina : null,
                  icon: Icon(Icons.arrow_forward),
                  label: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
