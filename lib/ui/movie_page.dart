import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/model/movie_model.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  // 検索Formの値を保存する変数.
  var title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.redAccent,
            // AppBar検索Form.
            title: Card(
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: '映画を検索...'),
                onChanged: (val) {
                  // ここにFormの値が入ってくる.
                  setState(() {
                    title = val; // 上で定義した変数に値を保存する.
                  });
                },
              ),
            )),
        body: StreamBuilder<QuerySnapshot<Movie>>(
          // StreamBuilderで全てのデータを習得.
          // クラスを型として使う.
          stream: moviesRef.snapshots(), // withConverterのデータをstreamで流す.
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            return ListView.builder(
                itemCount: data.size, // データの数をカウントする.
                itemBuilder: (context, index) {
                  if (title.isEmpty) {
                    // ここから、検索ワードを調べる.
                    final doc = data.docs[index].data();
                    return ListTile(
                      title: Text(
                        doc.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        doc.genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  final doc = data.docs[index].data();
                  if (doc.title
                      .toString()
                      .toLowerCase()
                      .startsWith(title.toLowerCase())) {
                    return ListTile(
                      title: Text(
                        doc.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        doc.genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Container(); // データがなかったら何もないContainerを表示する.
                });
          },
        ));
  }
}
