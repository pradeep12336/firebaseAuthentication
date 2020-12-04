import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nayaproject/model/data_model.dart';

class FirestoreProvider {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userTable = 'user_table';

  Future insertDataToFirestore(DataModel dataModel) async {
    final uid = await firebaseFirestore.collection(userTable).doc().id;
    dataModel.id = uid;
    await firebaseFirestore.collection(userTable).doc(uid).set(dataModel.toMap());
  }

  Stream<List<DataModel>> FetchDataFromFirestore(String email) {
    final datalist = firebaseFirestore.collection(userTable).snapshots().map((qsnap) {
      return qsnap.docs
          .map((dqsnap) {
            return DataModel.fromMap(dqsnap.data());
          })
          .where((element) => element.email == email)
          .toList();
    });
    return datalist;
  }
}
