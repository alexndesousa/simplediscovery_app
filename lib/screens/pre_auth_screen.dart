import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';
import 'package:simplediscovery_app/widgets/web_auth_widget.dart';

class PreAuthScreen extends StatefulWidget {
  @override
  _PreAuthScreenState createState() => _PreAuthScreenState();
}

class _PreAuthScreenState extends State<PreAuthScreen> {
  bool authenticated;
  @override
  void initState() {
    super.initState();
    authenticated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("please authenticate your account"),
            FlatButton(
              color: Colors.orange,
              onPressed: () => Navigator.push(context, _createRoute()),
              child: Text("auth"),
            ),
            FlatButton(
              color: Colors.orange,
              onPressed: () async {
                Map<String, dynamic> response = await (DiscoveryService().getUserProfileInformation());
                print(response);
              },
              child: Text("auth"),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) =>
            WebAuthWidget(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var curve = Curves.linear;
          
          var tween = Tween<Offset>(begin: begin, end: end)
              .chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
