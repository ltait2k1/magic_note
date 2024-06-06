import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
            child: Container(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: Text(
                "Google Keep",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ),
          sectionOne(),
          SizedBox(height: 5,),
          sectionTwo(),
          sectionThree(),
          sectionFour(),
        ],
      ),
    )));
  }
}
Widget sectionOne()
{
  return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                  )
              )

          ),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 25, color: Colors.black.withOpacity(0.7)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18),
                  ),
                ],
              ))));
}
Widget sectionTwo()
{
  return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                  )
              )

          ),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(Icons.archive_outlined,
                      size: 25, color: Colors.black.withOpacity(0.7)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Archive",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18),
                  ),
                ],
              ))));
}
Widget sectionThree()
{
  return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                  )
              )

          ),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(Icons.settings_outlined,
                      size: 25, color: Colors.black.withOpacity(0.7)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18),
                  ),
                ],
              ))));
}
Widget sectionFour()
{
  return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )
                  )
              )

          ),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(Icons.delete,
                      size: 25, color: Colors.black.withOpacity(0.7)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Recycle Bin",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18),
                  ),
                ],
              ))));
}