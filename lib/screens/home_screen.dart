import 'package:flutter/material.dart';

import 'package:denizey/components/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              width: width,
              height: height / 3.5,
              color: Colors.purple[50],
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.list),
                            SizedBox(width: 16.0),
                            Text(
                              'Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.graphic_eq),
                            SizedBox(width: 16.0),
                            Icon(Icons.notification_add),
                          ],
                        )
                      ],
                    ),
                    searchFormField(),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[50],
            )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          child: Container(
            height: 80.0,
            color: Colors.grey[300],
            child: TabBar(
              indicatorColor: Colors.purple,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey[200],
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.black54),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.apps),
                ),
                Tab(
                  icon: Icon(Icons.shopping_cart),
                ),
                Tab(
                  icon: Icon(Icons.more_vert),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
