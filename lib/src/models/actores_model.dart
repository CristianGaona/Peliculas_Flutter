// Generated by https://quicktype.io

// Recibir lista completa de actores
class Cast{
  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList){
    if ( jsonList == null) return;

    jsonList.forEach((item) { // recorrer el jsonList
      final actor = Actor.fromJsonMap(item); // crear instancia de actor
      actores.add(actor); // Agregar a los actores a la lista
     });
  }
}


// Clase model para manejar un solo actor
class Actor {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

// Mapear la información
  Actor.fromJsonMap(Map<String, dynamic> json){
    adult        = json ['adult'];
    gender       = json ['gender'];
    id           = json ['id'];
    name         = json ['name'];
    originalName = json ['original_name'];
    popularity   = json ['popularity'];
    profilePath  = json ['profile_path'];
    castId       = json ['cast_id'];
    character    = json ['character'];
    creditId     = json ['credit_id'];
    order        = json ['order'];
    job          =json ['job'];
  }


  getFoto(){

      if ( profilePath == null ){
        return 'https://icons-for-free.com/iconfiles/png/512/avatar+circle+male+profile+user+icon-1320196710301016992.png';
      }else{
        return 'https://image.tmdb.org/t/p/w500/$profilePath';
      }
   
    }
}
