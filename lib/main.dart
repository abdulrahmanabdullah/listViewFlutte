import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = new WordPair.random();
    return new MaterialApp(
      title: "ListEnglish",
      theme: new ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home:new RandomWords(),
    ) ;
  }
}


// Each StatefulWidget contain two classes ..
class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }

}
class RandomWordsState extends State<RandomWords>{
  // Build method here .
  final List<WordPair> _suggestion = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  // Favorite icon
  final Set<WordPair> _savedWord = new Set<WordPair>();

  Widget _buildSuggestion(){
    return new ListView.builder(
     padding: const EdgeInsets.all(16.0) ,
      itemBuilder: (BuildContext _context, int i ){

       if(i.isOdd){
         return new Divider();
       }

       final int index =  i ~/ 2 ;
       if(index  >= _suggestion.length){
         _suggestion.addAll(generateWordPairs().take(100));
       }
        return _buildRow(_suggestion[index]) ;
      },
    );
  }

  Widget _buildRow(WordPair words){
    // check if word saved
    final bool isSaved = _savedWord.contains(words);
    return new ListTile(
       title:new Text(
         words.asPascalCase,
         style: _biggerFont,
       ),
      trailing: new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color : isSaved ? Colors.red : null ,
      ),
      // this like onClickListener
      onTap: (){
         setState(() {
           if(isSaved){
            _savedWord.remove(words);
           }else{
            _savedWord.add(words);
           }
         });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

  return new Scaffold(
    appBar: new AppBar(
      title : const Text("Startup generated "),
      actions: <Widget>[
        new IconButton(icon: const Icon(Icons.list), onPressed: _pushState),
      ],
    ),
    body : _buildSuggestion(),
  );

  }

  void _pushState(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _savedWord.map(
                  (WordPair pair)
              {
               return new ListTile(
                 title: new Text(
                 pair.asPascalCase,
                 style: _biggerFont
                 ),
               );
              }
          );
          final List<Widget> dividers = ListTile.divideTiles(
            context: context ,
            tiles: tiles ,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text("Saved word page"),

            ),
            body: new ListView(children:dividers),
          );
        },
      ),
    );
  }



}

