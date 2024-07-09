import 'package:application/constants/pocketbase.dart';
import 'package:application/models/user.dart';

class AuthenticationService {
  static Future<User?> signIn ({required String accountId, required String password}) async {
    try{
      final record = await PocketbaseConstants.pocketbaseObject.collection('accounts').getOne(accountId, expand: "contacts");

      if(record.getDataValue("password") == password) {
        final contactsList = <String>[];

        if(record.expand["contacts"] != null) {
          for(final contactId in record.expand["contacts"]!) {
            contactsList.add(contactId.id);
          }
        }

        //Indicates signing in successfully
        return User(
          email: record.getDataValue("email"),
          password: record.getDataValue("password"),
          accountId: record.id,
          name: record.getDataValue("name"),
          balance: record.getDoubleValue("balance"),
          contactIds: contactsList
        );
      }
      return null;
    }

    catch(e) {
      return null; //Indicates signing in not successfully
    }
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