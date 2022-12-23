import 'package:flutter/material.dart';

typedef Callback = void Function(bool isFavorited);

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(
          150,
          (i) =>
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${i + 1}.png'), // generate a list of 150 Pokemon
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Pokemon List';

    return MaterialApp(
      title: title,
      home: HomePage(title: title, items: items),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  final String title;
  final List<String> items;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void updateCounter(bool isFavorited) {
    setState(() {
      if (!isFavorited) {
        count++;
      } else {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + (count != 0 ? "($count)" : "")),
      ),
      body: ListView.builder(
        itemCount: widget.items.length ~/
            3, // 3 items per row so we divide the number of items by 3
        itemBuilder: (context, index) {
          return Row(
            children: [
              FavoriteWidget(
                item: widget.items[index * 3],
                onChanged: (isFavorited) {
                  updateCounter(isFavorited);
                },
              ),
              FavoriteWidget(
                item: widget.items[index * 3 + 1],
                onChanged: (isFavorited) {
                  updateCounter(isFavorited);
                },
              ),
              FavoriteWidget(
                item: widget.items[index * 3 + 2],
                onChanged: (isFavorited) {
                  updateCounter(isFavorited);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key, required this.item, required this.onChanged})
      : super(key: key);

  final String item;
  final Callback onChanged;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      // Stack is for overlaying Favorite icon on top of image
      children: [
        Image.network(widget.item),
        IconButton(
          onPressed: () {
            widget.onChanged(isFavorited);
            isFavorited = !isFavorited;
          },
          icon: isFavorited
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 50,
                )
              : const Icon(
                  Icons.favorite_border,
                  size: 50,
                ),
        )
      ],
    ));
  }
}
