import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;

class PeliculasProvider{
    String _apiKey = 'd6a7b4f3f264762ec0b4258791bcd6d4';
    String _url = 'api.themoviedb.org';
    String _language = 'es-ES';

    int _popularesPage = 0;
    bool _cargando = false;

    List<Pelicula> _populares = new List();
    final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


    Function(List<Pelicula>) get  popularesSink => _popularesStreamController .sink.add;
    Stream<List<Pelicula>> get popularesStream => _popularesStreamController .stream;



    void disposeStreams(){
      _popularesStreamController ?.close();
    }

    // metodo compartido entre getCines y getPopulares
    Future<List<Pelicula>> _precesarRespuesta(Uri url) async {
      final resp = await http.get( url );
      final decodedData = json.decode(resp.body);
      final peliculas = new Peliculas.fromJsonList(decodedData['results']);
      return peliculas.items;
    }

    // Obtener peliculas recientes
    Future<List<Pelicula>> getEnCines() async {
      final url =Uri.https(_url, '3/movie/now_playing', {
        'api_key' : _apiKey,
        'language' : _language

      });
      return await _precesarRespuesta(url);

    }
    // Obtener la peliculas mas populares
    Future<List<Pelicula>> getPopulares() async{
      if( _cargando) return[];
      _cargando = true;
      _popularesPage++;

      final url =Uri.https(_url, '3/movie/popular', {
        'api_key' : _apiKey,
        'language' : _language,
        'page'      : _popularesPage.toString()

      });

      final resp =  await _precesarRespuesta(url);
      _populares.addAll(resp);
      popularesSink(_populares);
      _cargando = false;
      return resp;
    }
    

    // Obtener la lista de actores 
    Future<List<Actor>>getCast( String peliId) async{
      final url = Uri.https(_url, '3/movie/$peliId/credits', {
         'api_key' : _apiKey,
        'language' : _language,
      }); // Url con parametros necesarios

      final resp = await http.get(url); //await espera la respuesta, http consume la info del endpoint
      final decodeData = jsonDecode(resp.body); // Toma el Boddy del json y lo transfoma a map

      final cast = new Cast.fromJsonList(decodeData['cast']); // se envia el mapa en la propiedad de cast

      return cast.actores;

    }





}