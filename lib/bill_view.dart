import 'package:bill_md_mobile/add_bill_view.dart';
import 'package:bill_md_mobile/userdata.dart';
import 'package:bill_md_mobile/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bill_md_mobile/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BillView extends StatefulWidget {
  @override
  State createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  List<BillData> userAccounts;

  @override
  void initState() {
    super.initState();

    fetchUserAccounts();
  }

  void tappedAddBill(_) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AddBillView(),
      ),
    );
  }

  List<BillData> getBillData( UserData){
    return UserData.bills;
  }

  void fetchUserAccounts() {
    // We use futures here because of their readability, and simplicity in parsing errors.
    Firestore.instance
        .collection(FirebaseCollections.user_accounts)
        .getDocuments()
        // On completion, update UI
        .then(
          (documents) =>
              setState(() => this.userAccounts = getBillData(UserData.fromJson(documents.documents[0].data))),
        )
        //Notice we are passing the print function as the param so that it just goes straight to the console. 
        // During development, this is helpful for seeing errors. In the future, we will want to use 
        // a package like (shameless plug for my package :) ) https://pub.dev/packages/dropdown_banner 
        // to inform the user of a failure
        .catchError(print);
    //We could've also done:
    // .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {

    // TODO Sandeep: look how we handle the case where we are still waiting for Firestore to load vs when it finishes
    // Determine our user body now to make further down more readable for now.
    // We can put this within the body later if we wanted.
    final Widget contentCards = userAccounts == null
        // Waiting on Firestore to load
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Loading..'),
                CircularProgressIndicator(),
              ],
            ),
          )
        //Show what we have
        : Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: userAccounts
                      .map((d) => CustomCard(
                            title: d.accountNum,
                            description: d.amountDue,
                          ))
                      .toList(),
                ),
              ),
            ],
          );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF90E2CD),
                Color(0xFF7CD3D0),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 48,
              ),
              Text(
                'YOUR BILLS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(48, 12, 48, 0),
                child: Text(
                  'Did you know this random fact about medical bills?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        //Show our content
        Expanded(child: contentCards),
        // TODO Sandeep: 
        // We can use two nifty syntaxes found in dart 2.3 to minimize the complexity of building a list
        // 1.) The ... syntax flatmaps an array within an array
        // 2.) If statements conditionally build elements into lists

        // Check https://medium.com/flutter-community/whats-new-in-dart-2-3-1a7050e2408d 
        // For a great explanation of the powers of these operators when building UI

        // If there are no users, prompt to add (a bill/user/idk :) )
        //if (userAccounts == []) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            child: Text(
              'It seems you don\'t have any bills,\nadd one?',
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTapUp: tappedAddBill,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: BMColors.alertOrange),
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        //],
      ],
    );
  }
}
