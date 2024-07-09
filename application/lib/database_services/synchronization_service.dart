import 'package:application/constants/pocketbase.dart';
import 'package:application/models/user.dart';

class SynchronizationService {
  //fetch current user data
  static Future<User> getCurrentUserUpdate({required String accountId}) async {
    final result = await PocketbaseConstants.pocketbaseObject
        .collection("accounts").getOne(accountId);

    return User(
        email: result.getDataValue("email"),
        password: result.getDataValue("password"),
        accountId: result.id,
        name: result.getDataValue("name"),
        balance: result.getDoubleValue("balance"),
        contactIds: result.getDataValue("contacts")
    );
  }
}