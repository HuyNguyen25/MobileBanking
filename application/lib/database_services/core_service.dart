import 'package:application/constants/pocketbase.dart';
import 'package:application/models/transaction.dart';

/// Money transfer, getting and adding contacts, get account name for money transfer confirmation
class CoreService {
  static Future<String?> getAccountName({required String accountId}) async {
    try{
      final record = await PocketbaseConstants.pocketbaseObject.collection("accounts").getOne(
        accountId
      );
      return record.getDataValue("name");
    } catch(e) {
      return null;
    }
  }

  static Future<void> transferMoney({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amountOfMoney
  }) async {
    final sourceRecord = await PocketbaseConstants.pocketbaseObject
        .collection("accounts").getOne(sourceAccountId);

    final destinationRecord = await PocketbaseConstants.pocketbaseObject
        .collection("accounts").getOne(destinationAccountId);

    await PocketbaseConstants.pocketbaseObject.collection("accounts").update(
      sourceAccountId,
      body: {
        "balance": sourceRecord.getDoubleValue("balance") - amountOfMoney
      }
    );

    await PocketbaseConstants.pocketbaseObject.collection("accounts").update(
        destinationAccountId,
        body: {
          "balance": destinationRecord.getDoubleValue("balance") + amountOfMoney
        }
    );
  }
  
  static Future<bool> addContact({required String accountId, required String contactId}) async {
    final contactName = await getAccountName(accountId: contactId);
    if(contactName != null) {
      await PocketbaseConstants.pocketbaseObject.collection("accounts").update(
        accountId,
        body: {
          "contacts+": contactId
        }
      );
      return true;
    }
    return false;
  }

  static Future<void> addTransaction({required Transaction transaction}) async {
    final record = await PocketbaseConstants.pocketbaseObject.collection("transactions").create(
      body: {
        "source_account_id": transaction.sourceAccountId,
        "destination_account_id": transaction.destinationAccountId,
        "details": transaction.details,
        "amount_of_money": transaction.amountOfMoney
      }
    );
  }
}