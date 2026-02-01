import 'package:flutter/material.dart';
import 'package:smart_home/data/static/globals.dart';

class BottomNav extends StatefulWidget {
  const BottomNav(
      {super.key,
      required this.pageController,
      required this.isAddDeviceShown});
  final PageController pageController;
  final bool isAddDeviceShown;
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      color: const Color.fromARGB(255, 97, 192, 174),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 42,
              child: IconButton(
                style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                icon: Image.asset(
                  "asset/hut.png",
                  scale: 1,
                  color:
                      Globals.navItemClicked == 0 ? Colors.white :  const Color.fromARGB(255, 223, 223, 223),
                ),
                onPressed: () async {
                  if (!widget.isAddDeviceShown) {
                    setState(() {
                      Globals.navItemClicked = 0;
                    });
                    await widget.pageController.animateToPage(0,
                        duration: const Duration(microseconds: 3000),
                        curve: Curves.easeInOut);
                  }
                },
              ),
            ),
            SizedBox(
              height: 42,
              child: IconButton(
                style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)),
                icon: Image.asset(
                  "asset/devices.png",
                  scale: 1,
                  color:
                      Globals.navItemClicked == 1 ? Colors.white : const Color.fromARGB(255, 223, 223, 223),
                ),
                onPressed: () async {
                  if (!widget.isAddDeviceShown) {
                    setState(() {
                      Globals.navItemClicked = 1;
                    });

                    await widget.pageController.animateToPage(1,
                        duration: const Duration(microseconds: 2000),
                        curve: Curves.bounceInOut);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
