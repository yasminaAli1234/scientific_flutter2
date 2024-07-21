import 'package:flutter/material.dart';

import '../Screens/Task.dart';
import '../Screens/downloud.dart';
import '../Screens/materials.dart';

import '../Screens/member.dart';

class ScientificCommitted extends StatelessWidget {
  const ScientificCommitted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Lobna Khalifa'),
                accountEmail: Text('SC'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('L',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xff196B48)
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.black54,),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Head'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.black54,),
              ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Teammates'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.black54,),
              ListTile(
                leading: const Icon(Icons.task),
                title: const Text('Tasks'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.black54,),
              ListTile(
                leading: const Icon(Icons.group_add),
                title: const Text('Other Committees'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.black54,),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Scientific Committed",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),) ,
          bottom: const TabBar(

          indicatorColor: Colors.green,
              unselectedLabelColor: Colors.black12,
              unselectedLabelStyle: TextStyle(fontSize: 10),
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),

                Tab(
                  child: Text(
                    "Member",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Materials",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),

              ]),
        ),
        body: TabBarView(children: [
          TaskScreen(),
          Member(),
          MaterialPage1(),

        ]),
      ),
    );
  }
}