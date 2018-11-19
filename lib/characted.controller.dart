import 'package:summer/character.model.dart';
import 'package:http/http.dart';

class CharacterController{

  Future<List<Result>> fetchCharacters() async{
    Client client = new Client();

    String endPoint = 'https://rickandmortyapi.com/api/character/';
    final Response response = await client.get(endPoint);

    final json = response.body;
    final characterData = characterFromJson(json);

    client.close();



    return characterData.results;
  }

}