import 'package:bill_md_mobile/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String userid;
  final List<BillData> bills;

  UserData({this.userid, this.bills});

  static Future<UserData> getUsers() {
    return Firestore.instance
        .collection(FirebaseCollections.user_accounts)
        .getDocuments()
        // On completion, update UI
        .then(
          (documents) => UserData.fromJson(documents.documents[0].data),
        );
  }

  factory UserData.fromJson(Map<dynamic, dynamic> parsedJson) {
    var list = parsedJson['DataFields'] as List;
    print(list.runtimeType);
    List<BillData> billsList = list.map((i) => BillData.fromJson(i)).toList();

    return UserData(userid: parsedJson['userid'], bills: billsList);
  }
}

class BillData {
  final String accountNum;
  final String statementNum;
  final String amountDue;
  //final DateTime dueDate;

  BillData(
      {this.accountNum, this.statementNum, this.amountDue}); //, this.dueDate});

  factory BillData.fromJson(Map<dynamic, dynamic> parsedJson) {
    return BillData(
        accountNum: parsedJson['accountnum'],
        statementNum: parsedJson['statementnum'],
        amountDue: parsedJson['amountdue']
        //dueDate:parsedJson['duedate']
        );
  }
}
