import 'package:bill_md_mobile/bm_widgets.dart';
import 'package:bill_md_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddBillView extends StatefulWidget {
  @override
  State createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  final accountController = TextEditingController(text: '');
  final statementController = TextEditingController(text: '');
  final amountController = TextEditingController(text: '');
  final dueDateController = TextEditingController(text: '');

  @override
  void dispose() {
    super.dispose();

    [
      accountController,
      statementController,
      amountController,
      dueDateController,
    ].forEach((c) => c.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final textChildren = [
      {'controller': accountController, 'placeholder': 'Account #'},
      {'controller': statementController, 'placeholder': 'Statement #'},
      {'controller': amountController, 'placeholder': 'Amount due'},
      {'controller': dueDateController, 'placeholder': 'Due Date'},
    ]
        .map(
          (m) => Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: BMColors.light_grey, width: 0.5))),
            child: CupertinoTextField(
              decoration: BoxDecoration(border: null),
              controller: m['controller'],
              placeholder: m['placeholder'],
              placeholderStyle: TextStyle(
                  color: BMColors.light_grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
          ),
        )
        .toList();
    return BMNavigatorView(
      title: 'Add Bill',
      child: Container(
        color: BMColors.background_grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Statement Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: BMColors.grey,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: BMColors.light_grey, width: 0.5),
                ),
              ),
              child: Column(
                children: textChildren,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Additional Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 48,
              margin: EdgeInsets.all(24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BMColors.alert_orange,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'Add Bill',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
