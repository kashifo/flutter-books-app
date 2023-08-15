import 'package:flutter/material.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyBooksState();
  }
}

class MyBooksState extends State<MyBooks> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isGrid = !isGrid;
            });
          },
          child: getListIcon(isGrid),
        ),
        appBar: AppBar(
          title: const Text(
            'My Books',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: getWidget(isGrid));
  }
}

Widget getListIcon(bool isGrid) {
  if (isGrid) {
    return const Icon(
      Icons.list
    );
  } else {
    return const Icon(
        Icons.grid_on
    );
  }
} //getWidget

Widget getWidget(bool isGrid) {
  if (isGrid) {
    return GridView.extent(
      primary: false,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      maxCrossAxisExtent: 150.0,
      children: getChildrens(isGrid),
    );
  } else {
    return ListView(
      children: getChildrens(isGrid),
    );
  }
} //getWidget


List<Widget> getChildrens(bool isGrid) {
  return [
    ItemBook(
      img: 'jobs.jpg',
      title: 'Steve Jobs',
      author: 'Walter Isaacson',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'friends.jpg',
      title: 'How to Win Friends and Influence People',
      author: 'Dale Carnegie',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'attitude.jpg',
      title: 'Attitude is Everything',
      author: 'Jeff Keller',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'habit.jpg',
      title: 'The Power of Habit: Why We Do What We Do, and How to Change',
      author: 'Charles Duhigg',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'rich_dad.jpg',
      title: 'Rich Dad Poor Dad',
      author: 'Robert Kiyosaki',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'atlas.jpg',
      title: 'Atlas',
      author: 'Oxford University',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'think.jpg',
      title: 'Think & Grow Rich',
      author: 'Napolean Hill',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'babylon.jpg',
      title: 'Richest Man in Babylon',
      author: 'Walter',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'believe.jpg',
      title: 'Believe in Yourself',
      author: 'Joseph Murphy',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'meditations.jpg',
      title: 'Meditations',
      author: 'Marcus Aurelius',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'positive.jpg',
      title: 'The power of positive thinking',
      author: 'Norman Vincent Peale',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'benjamin.jpg',
      title: 'Autobiography of Benjamin Franklin',
      author: 'Benjamin Franklin',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'alchemist.jpg',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      isGrid: isGrid,
    ),
    ItemBook(
      img: 'gatsby.jpg',
      title: 'Great Gatsby',
      author: 'Scot Fitzgerald',
      isGrid: isGrid,
    ),
  ];
}

class ItemBook extends StatelessWidget {
  const ItemBook(
      {required this.img,
      required this.title,
      required this.author,
      required this.isGrid});

  final String img;
  final String title;
  final String author;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return Image(
        image: AssetImage('assets/images/books/$img'),
        width: 150,
        height: 150,
      );
    } else {
      return Container(
        height: 100,
        child: Card(
          color: Colors.white,
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/books/$img'),
                width: 100,
                height: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prata'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      author,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Prata'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}