import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_page/widget/loader/overlay_loading.dart';
import 'package:story_page/widget/scafold_part/custom_appbar.dart';
import 'package:story_page/widget/scafold_part/custom_drawer.dart';

import '../model/story_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<StoryModel>> allStories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchStoriesData();
    });
  }


  /// >>> ================================ Fetch Online Data And Get Data Start Here ====================
  Future<void> _fetchStoriesData() async {
    try {
      OverlayLoading.show(context, "Loading", Colors.black, Colors.white, Colors.white);
      final response = await http.get(Uri.parse("https://prothesbarai.github.io/collect/stories.json"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() { allStories = data.map<List<StoryModel>>((list) => (list as List<dynamic>).map<StoryModel>((item) => StoryModel.fromJson(item)).toList()).toList(); });
      }
      if (mounted) OverlayLoading.hide(context);

    } catch (e) {
      debugPrint("Something went wrong: $e");
    }
  }
  /// <<< ================================ Fetch Online Data And Get Data End Here ======================


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppbar(pageTitle: "Home"),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(


        ),
      ),
    );
  }
}
