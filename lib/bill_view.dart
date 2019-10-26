import 'package:bill_md_mobile/add_bill_view.dart';
import 'package:bill_md_mobile/userdata.dart';
import 'package:bill_md_mobile/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bill_md_mobile/constants.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class BillView extends StatefulWidget {
  @override
  State createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  List<BillData> userAccounts;
  bool loading;

  @override
  void initState() {
    super.initState();

    loading = false;
    fetchBills();
  }

  void tappedAddBill(_) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => AddBillView(),
        ),
      );

  void fetchBills() async {
    setState(() => loading = true);

    UserData.getUsers()
        .then(
          (users) => setState(
            () {
              this.userAccounts = users.bills;
              this.loading = false;
            },
          ),
        )
        .catchError(print);
  }

  @override
  Widget build(BuildContext context) {
    // TODO Sandeep: look how we handle the case where we are still waiting for Firestore to load vs when it finishes
    // Determine our user body now to make further down more readable for now.
    // We can put this within the body later if we wanted.
    final Widget contentCards = loading
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
                  children: userAccounts.map((b) => _StatementCard(b)).toList(),
                ),
              ),
            ],
          );

    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 5),
          ColorTween(begin: Color(0xFF90E2CD), end: Color(0xFF7CD3D0))),
      Track("color2").add(Duration(seconds: 5),
          ColorTween(begin: Color(0xFF7CD3D0), end: Color(0xFF90E2CD))),
    ]);

    final body = Column(
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
    );

    return Column(
      children: [
        ControlledAnimation(
          playback: Playback.MIRROR,
          tween: tween,
          duration: tween.duration,
          builder: (context, animation) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    animation["color1"],
                    animation["color2"],
                  ],
                ),
              ),
              child: body,
            );
          },
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
        if ((userAccounts ?? []) == []) ...[
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
        ]
        //],
      ],
    );
  }
}

class _StatementCard extends StatelessWidget {
  final BillData billData;

  _StatementCard(this.billData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: UIAssets.boxShadow,
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: BMColors.actionableBlue,
              borderRadius: BorderRadius.circular(3),
            ),
            width: 44,
            height: 44,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Due: Nov. 19th',
                    style: TextStyle(
                        color: BMColors.alertOrange,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Statement 1',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          '\$0 / \$2,5000.00',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12, letterSpacing: -0.3),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: 40 / 100,
                      backgroundColor: BMColors.lightGrey,
                      valueColor:
                          AlwaysStoppedAnimation(BMColors.actionableBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
