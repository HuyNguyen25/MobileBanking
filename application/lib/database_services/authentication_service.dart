import 'package:application/constants/pocketbase.dart';
import 'package:application/models/user.dart';

class AuthenticationService {
  static Future<User?> signIn ({required String accountId, required String password}) async {
    final records = await PocketbaseConstants.pocketbaseObject.collection('accounts').getFullList(expand: "contacts");
    for(final item in records) {
      if(item.getDataValue("account_id") == accountId && item.getDataValue("password") == password) {
        final contactsList = <String>[];

        if(item.expand["contacts"] != null) {
          for(final contactId in item.expand["contacts"]!) {
            contactsList.add(contactId.id);
          }
        }

        //Indicates signing in successfully
        return User(
          id: item.id,
          email: item.getDataValue("email"),
          password: item.getDataValue("password"),
          accountId: item.getDataValue("account_id"),
          name: item.getDataValue("name"),
          balance: item.getIntValue("balance"),
          contactIds: contactsList
        );
      }
    }

    return null; //Indicates signing in not successfully
  }
}