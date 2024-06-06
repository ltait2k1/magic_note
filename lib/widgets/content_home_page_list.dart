import 'package:flutter/material.dart';

class ContentHomePageList extends StatelessWidget {
  const ContentHomePageList({super.key});

  @override
  Widget build(BuildContext context) { String note = "Content Content Content Content Content Content";
  String note2 =
      "Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content  Content ContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContentContent";

    return  Container(
        height: MediaQuery.of(context).size.height,
        padding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TITLE",
                    style: TextStyle(
                        color: Colors.black, fontSize: 25),
                  ),
                  Text(index.isEven ? note : note2,),
                ],
              ),
            )));
  }
}
