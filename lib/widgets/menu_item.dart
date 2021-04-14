import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function navigateHandler;
  final String title;
  final IconData icon;

  MenuItem(
      {@required this.navigateHandler,
      @required this.icon,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateHandler,
      child: Container(
        height: 500,
        width: 500,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 400,
              ),
              Container(
                height: 50,
                color: Colors.green,
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
