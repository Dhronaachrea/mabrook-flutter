import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_bloc.dart';
import 'package:mabrook/ui/home_screen/home_screen.dart';
import 'package:mabrook/utility/screens.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int pageIndex = 0;

  final pages = [
    BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: const HomeScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: const EdgeInsets.all(8),
                  elevation: 0),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  const Icon(Icons.home_outlined),
                  Text(context.l10n.home)
                ],
              ),
            ),

            //hows it work button
            ElevatedButton(
              onPressed: () {
             /*   setState(() {
                  pageIndex = 1;
                });*/
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: const EdgeInsets.all(8),
                  elevation: 0),
              child: GestureDetector(
                onTap: () {

                },
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    const Icon(Icons.help),
                    Text(context.l10n.how_it_works)
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
               /* setState(() {
                  pageIndex = 2;
                });*/
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: const EdgeInsets.all(8),
                  elevation: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Screen.profile_screen);
                },
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    const Icon(Icons.person),
                    Text(context.l10n.my_account)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
