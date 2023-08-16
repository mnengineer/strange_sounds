import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailScreenState();
  }
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with TickerProviderStateMixin {
  final _audioPlayer = AudioPlayer();
  AnimationController? animationController;

  final List<String> _listItem = [
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
    'assets/images/baby.jpg',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List<Widget>.generate(_listItem.length, (int index) {
            final int count = _listItem.length;
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController?.forward();
            return AnimatedBuilder(
              animation: animationController!,
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: animation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 50 * (1.0 - animation.value), 0.0),
                    child: Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(_listItem[index]),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.2),
                                    Colors.black.withOpacity(.05),
                                  ])),
                          child: Transform.translate(
                            offset: const Offset(50, -50),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 60),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                ),
                                onPressed: () {
                                  _audioPlayer.play(
                                    AssetSource('videos/baby.mp3'),
                                  );
                                },
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
