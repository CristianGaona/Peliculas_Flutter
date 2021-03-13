import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(

              [
                SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting( pelicula )

              ]
            )
          )

        ]
      )
  
    );
  }
// Portada de la pelicula
  Widget _crearAppbar(Pelicula pelicula){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 400.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        
        background: FadeInImage(
          
          image: NetworkImage(pelicula.getBackgroundImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
         // fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
          
        
      ),
      ),
    );
  }

// Imagen pequeña
 Widget _posterTitulo(BuildContext context, Pelicula pelicula){
   return Container(
     padding: EdgeInsets.symmetric(horizontal:20.0),
     child: Row(
       children: <Widget>[
         Hero(
           tag: pelicula.uniqueId,
             child: ClipRRect(
             borderRadius: BorderRadius.circular(20.0),
               child: Image(
                 image: NetworkImage( pelicula.getPosterImg()),
                 height: 200.0,
             ),
           ),
         ),
         SizedBox(width:20.0),
         Flexible(
           child: Column(
             crossAxisAlignment:  CrossAxisAlignment.start,
             children: <Widget>[
               // ignore: deprecated_member_use
               Text(pelicula.title, style: Theme.of(context).textTheme.headline3, overflow: TextOverflow.ellipsis),
               // ignore: deprecated_member_use
               Text(pelicula.originalTitle, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis),
               Text(pelicula.releaseDate, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis),
               Row(
                 children:<Widget>[
                   Icon(Icons.star_border),
                   // ignore: deprecated_member_use
                   Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                 ]
               )
             ]
           ) ,)
       ],
     ),
     );
 }
 
 // Descripción de la pelicula
 Widget _descripcion(Pelicula pelicula){
   return Container(
     padding: EdgeInsets.symmetric(horizontal:10.0, vertical:20.0),
     child: Text(
       pelicula.overview,
       textAlign: TextAlign.justify,
     ),
     
     );
 }

 Widget _crearCasting( Pelicula pelicula) {
   final peliProvider = new PeliculasProvider();

   return FutureBuilder(
     future:  peliProvider.getCast(pelicula.id.toString()),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot){
      if (snapshot.hasData){
        return _crearActoresPageView( snapshot.data);
      }else{
        return Center(child: CircularProgressIndicator());
      }
     },
   );
 }
 // Crear PageBuiilder
 Widget _crearActoresPageView(List<Actor> actores){
   return SizedBox(
     height: 400.0,
     child: PageView.builder(
       pageSnapping: false,
       itemBuilder: ( context, i)=>_actorTarjeta( actores[i]),
       controller:  PageController(
         viewportFraction: 0.3,
         initialPage: 1),
       itemCount: actores.length,
       ) ,
     );

 }

 //Tarjeta para cada actor en particular
 Widget _actorTarjeta( Actor actor){
   return Container(
     child: Column(
       children:<Widget> [
         ClipRRect(
           borderRadius: BorderRadius.circular(20.0),
             child: FadeInImage(
             placeholder: AssetImage ('assets/img/no-image.jpg'),
             height: 300.0,
             fit: BoxFit.cover,
             image: NetworkImage( actor.getFoto())
             ),
         ),
         Text(actor.name,
         overflow: TextOverflow.ellipsis
         )
       ],


     )
   );

 }
}