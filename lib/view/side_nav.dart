// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:autorepair/imports.dart';

class SideNav extends StatefulWidget {
  const SideNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  final drawer = TabControllers();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    height: 50.0,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black12,
                            offset: Offset(1, 1),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          'assets/user.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBuilder(
                              text: 'Mohit Panchal',
                              textAlign: TextAlign.start,
                              fontSize: 10,
                            ),
                            TextBuilder(
                              text: '+91 8003478***',
                              textAlign: TextAlign.start,
                              fontSize: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: drawer.drawer.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MainView(initRoute: i)),
                            (route) => false);
                      },
                      leading: Icon(
                        drawer.drawer[i].icon,
                        color: Colors.black,
                        size: 17,
                      ),
                      title: TextBuilder(
                        text: drawer.drawer[i].title,
                        fontSize: 13.0,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Splash()),
                        (route) => false);
                  },
                  leading: const Icon(
                    Icons.power_settings_new,
                    color: Colors.black,
                    size: 17,
                  ),
                  title: const TextBuilder(
                    text: 'Log out',
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
