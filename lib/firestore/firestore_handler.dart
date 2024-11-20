import 'package:chat_app/firestore/models/message.dart';
import 'package:chat_app/firestore/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  static CollectionReference<User> getUserCollection() {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection(User.collectionName).withConverter(
      fromFirestore: (snapshot, options) {
        return User.fromFirestore(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> createUser(User user) async {
    final collection = getUserCollection();
    final docRef = collection.doc(user.id);
    docRef.set(user);
  }

  static CollectionReference<Message> getMessageCollection(String userId) {
    final userCollection = getUserCollection();
    final collection = userCollection
        .doc(userId)
        .collection(Message.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) {
        return Message.fromFirestore(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }

  static CollectionReference<Message> getCommonMessageCollection() {
    final collection =
        FirebaseFirestore.instance.collection('Common Messages').withConverter(
      fromFirestore: (snapshot, options) {
        return Message.fromFirestore(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }

  static createMessage(Message message, String userId) {
    final collection = getMessageCollection(userId);
    final docRef = collection.doc();
    docRef.set(message);
  }

  static createCommonMessage(Message message, String userId) {
    final collection = getCommonMessageCollection();
    final docRef = collection.doc();
    docRef.set(message);
  }

  static Stream<List<Message>> getMessages(String userId) async* {
    final collection =
        getMessageCollection(userId).orderBy('Time', descending: true);
    final querySnapshot = collection.snapshots();
    final messagesList =
        querySnapshot.map((event) => event.docs.map((e) => e.data()).toList());
    yield* messagesList;
  }

  static Stream<List<Message>> getCommonMessages() async* {
    final collection =
        getCommonMessageCollection().orderBy('Time', descending: true);
    final querySnapshot = collection.snapshots();
    final messagesList =
        querySnapshot.map((event) => event.docs.map((e) => e.data()).toList());
    yield* messagesList;
  }
}
