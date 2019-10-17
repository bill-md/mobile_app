import 'package:bill_md_mobile/constants.dart';
import 'package:bill_md_mobile/task.dart';
import 'package:flutter/material.dart';

class BMNavigatorView extends StatelessWidget {
  final Widget child;
  final String title;

  BMNavigatorView({@required this.child, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 80,
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: UIAssets.boxShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTapUp: (_) => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: 36,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: BMColors.dark_grey,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 36),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title, this.description});

  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            Text(title),
            FlatButton(
                child: Text("See More"),
                onPressed: () {
                  /** Push a named route to the stcak, which does not require data to be  passed */
                  // Navigator.pushNamed(context, "/task");

                  /** Create a new page and push it to stack each time the button is pressed */
                  // Navigator.push(context, MaterialPageRoute<void>(
                  //   builder: (BuildContext context) {
                  //     return Scaffold(
                  //       appBar: AppBar(title: Text('My Page')),
                  //       body: Center(
                  //         child: FlatButton(
                  //           child: Text('POP'),
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ));

                  /** Push a new page while passing data to it */
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                              title: title, description: description)));
                }),
          ],
        ),
      ),
    );
  }
}
