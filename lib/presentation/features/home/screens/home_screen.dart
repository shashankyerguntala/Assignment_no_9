import 'package:assignment_9/core/constants.dart';
import 'package:assignment_9/core/utils/firebase_utils.dart';
import 'package:assignment_9/presentation/features/home/bloc/home_bloc.dart';
import 'package:assignment_9/presentation/features/all_chats/screens/all_chats_screen.dart';
import 'package:assignment_9/presentation/features/home/widgets/icon_chip.dart';
import 'package:assignment_9/presentation/features/login/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchUsers());
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "WhatsUp",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        actions: [
          IconChip(icon: Icons.search),
          const SizedBox(width: 8),
          IconChip(icon: Icons.more_vert),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              dividerColor: Colors.grey.shade400,
              labelColor: Constants.primary,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
              tabs: const [
                Tab(text: "CHATS"),
                Tab(text: "STATUS"),
                Tab(text: "CALLS"),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.chat)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('HOME'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('SIGN OUT'),
                  onTap: () {
                    FirebaseUtils().signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          AllChatsScreen(),
          Center(
            child: Text(
              "Coming Soon **",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Center(
            child: Text(
              "Coming Soon **",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
