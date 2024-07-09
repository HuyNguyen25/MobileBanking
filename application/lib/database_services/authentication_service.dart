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
          balance: item.getDoubleValue("balance"),
          contactIds: contactsList
        );
      }
    }

    return null; //Indicates signing in not successfully
  }

  static Future<bool> changePassword({required String accountId, required String oldPassword, required String newPassword}) async {
    final record = await PocketbaseConstants.pocketbaseObject.collection("accounts").getOne(accountId);
    if(record.getDataValue("password") == oldPassword) {
      await PocketbaseConstants.pocketbaseObject.collection("accounts").update(
        accountId,
        body: {
          "password": newPassword
        }
      );
      return true;
    }
    return false;
  }

  static Future<bool> changeEmail({required String accountId, required String password, required String newEmail}) async {
    final record = await PocketbaseConstants.pocketbaseObject.collection("accounts").getOne(accountId);
    if(record.getDataValue("password") == password) {
      await PocketbaseConstants.pocketbaseObject.collection("accounts").update(
          accountId,
          body: {
            "email": newEmail
          }
      );
      return true;
    }
    return false;
  }
}