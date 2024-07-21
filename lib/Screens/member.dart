import 'package:flutter/material.dart';
import '../models/member_model.dart';
import 'task.dart'; // Assuming TaskScreen is correctly imported from 'task.dart'

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final List<MemberModel> members = [
    MemberModel(name: 'Lobna', image: '', email: 'lobna@gmail.com', score: 90),
    MemberModel(name: 'Yasmin', image: '', email: 'yasmin@gmail.com', score: 90),
    MemberModel(name: 'Mariam', image: '', email: 'mariam@gmail.com', score: 90),
  ];
  List<MemberModel> filteredMembers = []; // Initialize filteredMembers
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMembers.addAll(members);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                onChanged: (value) {
                  _handleSearch(value); // Call _handleSearch when text changes
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search ",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    // Replace with a placeholder image or default image
                    backgroundImage: NetworkImage(filteredMembers[index].image),
                    backgroundColor: Colors.black12,
                    child: Text(
                      filteredMembers[index].name[0],
                      style: const TextStyle(
                        color: Color(0xff196B48),
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  title: Text(
                    filteredMembers[index].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    filteredMembers[index].email,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    filteredMembers[index].score.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch(String input) {

    setState(() {
      filteredMembers = members.where((member) =>
      member.name.toLowerCase().contains(input.toLowerCase()) ||
          member.email.toLowerCase().contains(input.toLowerCase())).toList();
    });
  }
}
