import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magic_note/color/colors.dart';
import 'package:magic_note/views/create_note_view.dart';
import 'package:magic_note/widgets/content_home_page_all.dart';
import 'package:magic_note/widgets/content_home_page_list.dart';
import 'package:magic_note/widgets/sidemenubar.dart';
import 'package:magic_note/widgets/svices_google/signInWithGoogle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = true; //
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => CreatNoteView()));
        },

        child: Icon(Icons.add, size: 25,),
      ),
        endDrawerEnableOpenDragGesture: true,
        key: _drawerKey,
        drawer: SideMenu(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: white.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3)
                        ]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _drawerKey.currentState!.openDrawer();
                            },
                            icon: Icon(Icons.menu, color: Colors.black)),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 55,
                          width: 170,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Seach your notes",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 16),
                                )
                              ]),
                        ),
                        IconButton(
                            onPressed: () {setState(() {
                              isGridView = !isGridView;
                            });},
                            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view, color: Colors.black)),
                        SizedBox(
                          width: 9,
                        ),
                        _user == null
                        ?
                        GestureDetector(
                          onTap: (){
                            signInWithGoogle();
                          },
                          child:
                          CircleAvatar(
                            radius: 15,
                              backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHfd3PPulVSp4ZbuBFNkePoUR_fLJQe474Ag&s"),
                          ),
                        )
                            :
                            GestureDetector(
                              onTap: (){
                                signOut();
                              },
                              child:
                              CircleAvatar(
                                backgroundImage: NetworkImage(_user!.photoURL!),
                                radius: 15,
                              ),
                            )

                      ],
                    ),
                  ),
                  ContentHomePage(isGridView : isGridView),
                ],
              ),
            ),
          ),
        ));
  }
}
