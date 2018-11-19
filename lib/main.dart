import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:summer/characted.controller.dart';
import 'package:summer/character.model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.yellow
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Result>> fetchCharacters(){
    CharacterController charactersController = new CharacterController();
    return charactersController.fetchCharacters();
  }

  Widget grid(List<Result> characters){
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) => buildCharacter(characters[index]),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget buildCharacter(Result character){
    return Container(
          child: Column(
            children: <Widget>[
              Image.network(
                character.image,
                height: 200.0,
                fit: BoxFit.cover),
              Text(character.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
            ],
          ),
    );
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text('Summer'),
      ),

      body: FutureBuilder<List<Result>>(
        future: fetchCharacters(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.active:
            case ConnectionState.waiting:
              return new Text('Loading data ..');
            case ConnectionState.done:
              if(snapshot.hasError){
                return new Text('Error with data ${snapshot.error}');
              }else{
                final characters = snapshot.data;
                return grid(characters);
                // return ListView.builder(
                //   itemCount: characters.length,
                //   itemBuilder: (context,index){
                //     final character = characters[index];
                //     return InkWell(
                //       splashColor: Colors.green,
                //       child: buildCharacter(character),
                //     );

                //   },
                // );
              }
              break;
            case ConnectionState.none:
              return new Text('None');
          }
        },
      ),

      // body: new Center(
      //   child: new Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[],
      //   ),
      // ),
    );
  }
}
