import 'package:flutter/material.dart';
import 'package:story_page/widget/scafold_part/custom_appbar.dart';
import 'package:story_page/widget/scafold_part/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(pageTitle: "Home"),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
