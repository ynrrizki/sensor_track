import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensor_track/presentation/pages/feat_a/feat_a_page.dart';
import 'package:sensor_track/presentation/pages/feat_b/feat_b_page.dart';
import 'package:sensor_track/presentation/pages/feat_c/feat_c_page.dart';
// import 'package:sensor_track/ui/widgets/logo_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
              pinned: false,
              toolbarHeight: 55,
              stretch: true,
              title: const Text('Hello, Yanuar!👋'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/camera');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.blue,
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
              title: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Text(
                      'A',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'B',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'C',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
          body: const TabBarView(
            children: [
              FeatAPage(),
              FeatBPage(),
              FeatCPage(),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: 200,
                width: double.infinity,
                child: Center(
                  child: ListTile(
                    leading: Container(
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                    ),
                    title: Text(
                      'Yanuar Rizki',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
