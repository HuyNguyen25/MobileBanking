import 'package:application/constants/pocketbase.dart';
import 'package:application/models/user.dart';

class SynchronizationService {
  //fetch current user data
  static Future<User> getCurrentUserUpdate({required String id}) async {
    final result = await PocketbaseConstants.pocketbaseObject
        .collection("accounts").getOne(id, expand: "contacts");

    final contactsList = <String>[];

    if(result.expand["contacts"] != null) {
      for(final contactId in result.expand["contacts"]!) {
        contactsList.add(contactId.id);
      }
    }

    return User(
        id: result.id,
        email: result.getDataValue("email"),
        password: result.getDataValue("password"),
        accountId: result.getDataValue("account_id"),
        name: result.getDataValue("name"),
        balance: result.getDoubleValue("balance"),
        contactIds: contactsList
    );
  }
}