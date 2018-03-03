import 'package:flutter/material.dart';
import 'places.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
      ),
      home: new HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Song extends StatelessWidget {
  const Song({ this.title, this.author, this.likes });

  final String title;
  final String author;
  final int likes;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: new IntrinsicHeight(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 10.0),
              child: new CircleAvatar(
                  child: new Text('DE'),
                  backgroundColor: Colors.blue,

               // radius: 20.0,
              ),
            ),
            new Expanded(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(title, style: textTheme.subhead),
                    new Text(author, style: textTheme.caption),
                  ],
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Icon(Icons.play_arrow, size: 40.0),
                onTap: () {
                  // TODO(implement)
                },
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.favorite, size: 25.0),
                    new Text('${likes ?? ''}'),
                  ],
                ),
                onTap: () {
                  // TODO(implement)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: _burgerplaces.map((place) => new PlaceWidget(place)).toList(),
      //children: [
       /* new Song(title: 'Trapadelic lobo', author: 'lillobobeats', likes: 4),
        new Song(title: 'Different', author: 'younglowkey', likes: 23),
        new Song(title: 'Future', author: 'younglowkey', likes: 2),
        new Song(title: 'ASAP', author: 'tha_producer808', likes: 13),
        new Song(title: '🌲🌲🌲', author: 'TraphousePeyton'),
        new Song(title: 'Something sweet...', author: '6ryan'),
        new Song(title: 'Sharpie', author: 'Fergie_6'),*/
    )),
    );
  }
}*/

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  CustomTabBar({ this.pageController, this.pageNames })
      : super(listenable: pageController);

  final PageController pageController;
  final List<String> pageNames;

  @override
  final Size preferredSize = new Size(0.0, 40.0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.5),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List.generate(pageNames.length, (int index) {
          return new InkWell(
              child: new Text(
                  pageNames[index],
                  style: textTheme.subhead.copyWith(
                    color: Colors.white.withOpacity(
                      index == pageController.page ? 1.0 : 0.2,
                    ),
                  )
              ),
              onTap: () {
                pageController.animateToPage(
                  index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              }
          );
        })
            .toList(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

/*class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController = new PageController(initialPage: 2);
  final GlobalKey<_HomeScreenState> _pizzaplaceskey = new GlobalKey<_HomeScreenState>();
  int _selectedItem;
  int _nextItem;
  List<Place> _burgerplaces = <Place>[];
  ListModel<Place> _pizzaplaces = <Place>[];
  List<Place> _burritoplaces = <Place>[];
  List<Place> _wingsplaces = <Place>[];
  @override
  initState() {
    super.initState();
    listenForPlaces();
    _pizzaplaces = new ListModel<Place>(

    )
  }

  listenForPlaces() async {
    var stream1 = await getPlaces(39.683723, -75.749657, 'wings'); //await waits until gets results
    stream1.listen((place) =>
        setState(() => _wingsplaces.add(place))
    );
  /*  var stream2 = await getPlaces(39.683723, -75.749657, 'pizza'); //await waits until gets results
    stream2.listen((place) =>
        setState(() => _pizzaplaces.add(place))
    );*/
    var stream3 = await getPlaces(39.683723, -75.749657, 'burrito'); //await waits until gets results
    stream3.listen((place) =>
        setState(() => _burritoplaces.add(place))
    );
    var stream4 = await getPlaces(39.683723, -75.749657, 'hamburgers'); //await waits until gets results
    stream4.listen((place) =>
        setState(() => _burgerplaces.add(place))
    );
  }

    @override
    build(BuildContext context) {
      final Map<String, Widget> pages = <String, Widget>{
        'Wings': new Center(
            child: new ListView(
              children: _wingsplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Pizza': new Center(
            child: new ListView(
              children: _pizzaplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Burritos': new Center(
            child: new ListView(
              children: _burritoplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Burgers': new Center(
            child: new ListView(
              children: _burgerplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
      };
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Stack(
      children: [
        new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 253, 72, 72),
                    const Color.fromARGB(255, 87, 97, 249),
                  ],
                  stops: [0.0, 1.0],
                )
            ),
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    'T I Z E',
                    style: textTheme.headline.copyWith(
                      color: Colors.grey.shade800.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            )
        ),
        new Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: new AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: new Center(
              child: new ClipOval(
                child: new Image.network(
                  'http://ridesafeworld.com/wp-content/uploads/2017/11/DE_StateIcon.png',
                ),
              ),
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  // TODO: implement
                },
              ),
            ],
            title: const Text('Newark Eats'),
            bottom: new CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: new PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        ),
      ],
    );
  }
}*/
class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController = new PageController(initialPage: 2);
  List<Place> _burgerplaces = <Place>[];
  List<Place> _pizzaplaces = <Place>[];
  List<Place> _burritoplaces = <Place>[];
  List<Place> _wingsplaces = <Place>[];
  List<Place> _breakfastplaces = <Place>[];
  List<String> locations = <String>['Newark Eats', 'Wilmington Eats'];
  int a = 1;
  @override
  initState() {
    super.initState();
    listenForPlacesWilm();
  }

  listenForPlaces() async {
    var stream1 = await getPlaces(39.683723, -75.749657, 'wings'); //await waits until gets results
    stream1.listen((place) =>
        setState(() => _wingsplaces.add(place))
    );
    var stream2 = await getPlaces(39.683723, -75.749657, 'pizza'); //await waits until gets results
    stream2.listen((place) =>
        setState(() => _pizzaplaces.add(place))
    );
    var stream3 = await getPlaces(39.683723, -75.749657, 'burrito'); //await waits until gets results
    stream3.listen((place) =>
        setState(() => _burritoplaces.add(place))
    );
   /* var stream4 = await getPlaces(39.683723, -75.749657, 'hamburgers'); //await waits until gets results
    stream4.listen((place) =>
        setState(() => _burgerplaces.add(place))
    );*/
    var stream5 = await getPlaces(39.683723, -75.749657, 'breakfast'); //await waits until gets results
    stream5.listen((place) =>
        setState(() => _breakfastplaces.add(place))
    );
  }

  listenForPlacesWilm() async {
    var stream1 = await getPlaces(39.8024060,-75.5654010, 'wings'); //await waits until gets results
    stream1.listen((place) =>
        setState(() => _wingsplaces.add(place))
    );
    var stream2 = await getPlaces(39.8024060,-75.5654010, 'pizza'); //await waits until gets results
    stream2.listen((place) =>
        setState(() => _pizzaplaces.add(place))
    );
    var stream3 = await getPlaces(39.8024060,-75.5654010, 'burrito'); //await waits until gets results
    stream3.listen((place) =>
        setState(() => _burritoplaces.add(place))
    );
   /* var stream4 = await getPlaces(39.8024060,-75.5654010, 'hamburgers'); //await waits until gets results
    stream4.listen((place) =>
        setState(() => _burgerplaces.add(place))
    );*/
    var stream5 = await getPlaces(39.8024060,-75.5654010, 'breakfast'); //await waits until gets results
    stream5.listen((place) =>
        setState(() => _breakfastplaces.add(place))
    );
  }

    @override
    build(BuildContext context) {
      final Map<String, Widget> pages = <String, Widget>{
        'Wings': new Center(
            child: new ListView(
              children: _wingsplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Pizza': new Center(
            child: new ListView(
              children: _pizzaplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Burritos': new Center(
            child: new ListView(
              children: _burritoplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
        'Breakfast': new Center(
            child: new ListView(
              children: _breakfastplaces.map((place) => new PlaceWidget(place)).toList(),
            )),
      };
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return new Stack(
      children: [
        new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 253, 72, 72),
                    const Color.fromARGB(255, 87, 97, 249),
                  ],
                  stops: [0.0, 1.0],
                )
            ),

        ),
        new Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: new AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: new Center(
              child: new ClipOval(
                child: new Image.network(
                  'http://ridesafeworld.com/wp-content/uploads/2017/11/DE_StateIcon.png',
                ),
              ),
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  _pizzaplaces.clear();
                  _burgerplaces.clear();
                  _burritoplaces.clear();
                  _wingsplaces.clear();
                  _breakfastplaces.clear();
                  if (a==0) {
                    listenForPlacesWilm();
                    a=1;
                    // TODO: implement
                  } else {
                    listenForPlaces();
                    a=0;
                  }
                },
              ),
            ],
            title: new Text(locations[a]),
            bottom: new CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: new PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        ),
      ],
    );
  }
}

class PlaceWidget extends StatelessWidget {
  final Place _place;

  PlaceWidget(this._place);

  Color getColor(double rating) {
    return Color.lerp(Colors.red, Colors.green, rating / 5);
  }


  @override
  Widget build(BuildContext context) {
    // return new ListTile(
    return new Dismissible(
      key: new Key(_place.name),
      background: new Container(color: Colors.green),
      secondaryBackground: new Container(color: Colors.red),
      onDismissed: (direction) {
        direction == DismissDirection.endToStart ? Scaffold.of(context)
            .showSnackBar(
            new SnackBar(content: new Text('Naaaa'))) : print('I like');
      },
      child: new ListTile(
        leading: new CircleAvatar(
          child: new Text(_place.rating.toString()),
          backgroundColor: getColor(_place.rating),
        ),
        title: new Text(_place.name),
        subtitle: new Text(_place.address),
      ),
      // feedback:
    );
  }
// Center is a layout widget. It takes a single
}
/*
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  }) : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index, (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}
class DraggablePlaceWidget extends StatelessWidget {
  final Place _pizzaplace;
  int _selecteditem;
  int _nextItem;

  DraggablePlaceWidget(this._pizzaplace);

  Color getColor(double rating) {
    return Color.lerp(Colors.red, Colors.green, rating / 5);
  }

  @override
  Widget build(BuildContext context, int index, Animation<double> animation){
  // return new ListTile(
  return new CardItem(
    animation: animation,
    item: _pizzaplaces[index]
    background: new Container(color: Colors.green),
    secondaryBackground: new Container(color: Colors.red),
    onDismissed: (direction){
      direction == DismissDirection.endToStart ? Scaffold.of(context).showSnackBar(
          new SnackBar(content:new Text('Naaaa'))) : print('I like');
    },
    child: new ListTile(
      leading: new CircleAvatar(
        child: new Text(_place.rating.toString()),
        backgroundColor: getColor(_place.rating),
      ),
      title: new Text(_place.name),
      subtitle:new Text(_place.address),
    ),
    // feedback:
  );

}
// Center is a layout widget. It takes a single
}*/