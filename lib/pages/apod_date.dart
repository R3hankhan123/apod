import 'package:apod/models/fetch_data.dart';
import 'package:apod/models/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class ApodDate extends StatefulWidget {
  String date;
  ApodDate({Key? key, required this.date}) : super(key: key);

  @override
  State<ApodDate> createState() => _ApodDateState();
}

class _ApodDateState extends State<ApodDate> {
  final spinkit = const SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=BBAyRBTfsOU")!,
      flags: const YoutubePlayerFlags(
        loop: true,
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) => Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                'Astronomy Picture of the Day',
                style: TextStyle(color: Colors.deepOrange),
              )),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: FutureBuilder<List<ApodData>?>(
              future: FetchData().getDataStartDate(widget.date),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            snapshot.data![index].mediaType == 'image'
                                ? Image.network(
                                    snapshot.data![index].hdurl,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : YoutubePlayer(
                                    controller: _controller
                                      ..load(YoutubePlayer.convertUrlToId(
                                          snapshot.data![index].url)!)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              snapshot.data![index].title,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data![index].explanation,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "${snapshot.error}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 20),
                  ));
                }
                return spinkit;
              },
            ),
          ));
}
