import 'package:flutter/material.dart';
import 'package:tarea_api_disney/view/page_api.dart';
import 'package:tarea_api_disney/view/pages_mycaracterhome.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFF1E5D1),
      appBar: AppBar(
        backgroundColor: Color(0xFF1B5E9E),
        title: Text(
          'Disney API',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/view/images/disney.jpg'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStyledButton(
                text: 'Disney Personajes',
                icon: Icons.movie_filter_rounded,
                color: Color(0xFFFF4081),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiPage()),
                ),
              ),

              SizedBox(height: 20),
              _buildStyledButton(
                text: 'Mis caracteres',
                icon: Icons.favorite_rounded,
                color: Color(0xFF4CAF50), // Green
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCaractersHome()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Estilo botones
  Widget _buildStyledButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
