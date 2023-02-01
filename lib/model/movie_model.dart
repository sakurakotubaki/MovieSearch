import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  Movie({required this.title, required this.genre});

  Movie.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          genre: json['genre']! as String,
        );

  final String title;
  final String genre;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'genre': genre,
    };
  }
}

final moviesRef =
    FirebaseFirestore.instance.collection('movies').withConverter<Movie>(
          fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
