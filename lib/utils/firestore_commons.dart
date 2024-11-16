import 'package:books_app/models/GBook.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';

updateInFB(GBook gbook, bool delete) async {
  final userId = FirebaseAuth.instance.userId;
  var ref = Firestore.instance.collection('users').document( userId ).collection('favorites');

  if(delete) {
    await ref.document(gbook.id!).delete();
  } else {
    await ref.document(gbook.id!).set({
      'bookName': gbook.volumeInfo!.title,
      'imageUrl': gbook.volumeInfo!.getThumbnail(),
      'authors': gbook.volumeInfo!.authors.toString(),
      'publisher': gbook.volumeInfo!.publisher,
      'description': gbook.volumeInfo!.description,
    });
  }
}

Future<bool> checkFavInFB(String bookId) async {

  try {
    final userId = FirebaseAuth.instance.userId;
    final bookExists = await Firestore.instance.collection('users').document( userId ).collection('favorites').document(bookId).exists;
    print('checkFavInFB()=$bookExists');
    return bookExists;
  } catch (e) {
    print(e);
  }

  return false;
}