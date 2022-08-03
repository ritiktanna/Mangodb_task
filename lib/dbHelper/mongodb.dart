import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb/MongoDBModel.dart';

import 'const.dart';

class MangoDatabaseHelper {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(AppConstant.url);
    await db.open();
    userCollection = db.collection(AppConstant.collectionName);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      await connect();
      var result = await userCollection.insertOne(data.toJson());

      if (result.isSuccess) {
        return "Data added";
      } else {
        return "Something is wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
