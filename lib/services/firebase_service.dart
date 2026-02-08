import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/videojuego_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE
  Future<void> insertVideojuego(Videojuego v) async {
    await _db.collection('videojuegos').add(v.toMap());
  }

  // READ
  Future<List<Videojuego>> getVideojuegos() async {
    final snapshot = await _db.collection('videojuegos').get();
    return snapshot.docs
        .map((doc) => Videojuego.fromMap(doc.id, doc.data()))
        .toList();
  }

  // UPDATE
  Future<void> updateVideojuego(String id, Videojuego v) async {
    await _db.collection('videojuegos').doc(id).update(v.toMap());
  }

  // DELETE
  Future<void> deleteVideojuego(String id) async {
    await _db.collection('videojuegos').doc(id).delete();
  }
}
