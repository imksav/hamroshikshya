import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  var onTap;
 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.lime,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Grade XI", style: TextStyle(color: Colors.purple, fontSize: 30)),
                SizedBox(height: 10),
                Text("Grade XII", style: TextStyle(color: Colors.purple, fontSize: 30)),
                SizedBox(height: 10),
                Text("About Us", style: TextStyle(color: Colors.purple, fontSize: 30)),
                SizedBox(height: 10),
                Text("Terms & Policy", style: TextStyle(color: Colors.purple, fontSize: 30)),
                SizedBox(height: 10),
                Text("Feedbacks", style: TextStyle(color: Colors.purple, fontSize: 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(80)),
          elevation: 8,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.black),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("Hamro Shikshya", style: TextStyle(fontSize: 32, color: Colors.green)),
                      Icon(Icons.search, color: Colors.black),
                        
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                    
                      pageSnapping: true,
                      children: <Widget>[
                        Row(
                         
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                          SizedBox(height: 30),
                          Scrollbar(
                            child: Icon(Icons.library_books),
                          ),
                          Text("Welcome to our Official App", style: TextStyle(fontSize: 21, color: Colors.blue),),
                          Scrollbar(
                            child: Icon(Icons.library_books),
                          ),
                    ]
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("Recently Opened Chapters", style: TextStyle(color: Colors.purple, fontSize: 25, fontFamily: "cursive"),),
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text("Grade XII"),
                      title: Text("Physics"),
                      subtitle: Text("Dynamics"),
                      trailing: Text("Chapter - 4"),
                    );

                  }, separatorBuilder: (context, index) {
                    return Divider(height: 25);
                  }, itemCount: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}