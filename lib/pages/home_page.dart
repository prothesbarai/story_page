import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_page/pages/story_page.dart';
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
  double boxBorderRadius = 10;

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

    final screenWidth = MediaQuery.of(context).size.width;
    const itemsToShow = 4.5;
    final itemWidth = screenWidth / itemsToShow;

    return Scaffold(
      appBar: CustomAppbar(pageTitle: "Home"),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: 180,
          margin: EdgeInsets.zero,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allStories.length,
              itemBuilder: (context, index) {
                final storyList = allStories[index];
                /*
                    Akta list er maje onk story list ase,
                    abr sei story list er maje onk story ase,
                    Sei Story theke   storyList[0]   1st Story Image + Text Display hobe,
                    Then Setay Navigate Korle Story Page e Sob Dekha Jabe
                */
                final firstStoryList = storyList[0];
                return GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => StoryPage(stories: storyList,),)),
                  child: SizedBox(
                    width: itemWidth,
                    child: _buildStoryBox(firstStoryList, index, allStories.length),
                  )
                );
              },
          ),

        ),
      ),
    );
  }


  /// >>> ============================= Home Page Items Builder Design Start Here ===========================
  Widget _buildStoryBox(StoryModel story, int index, int len){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(boxBorderRadius), image: DecorationImage(image: CachedNetworkImageProvider(story.image),fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(boxBorderRadius),bottomLeft: Radius.circular(boxBorderRadius)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black54,),
            padding: EdgeInsets.all(5),
            child: Text(story.title,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
        ),
      ),
    );
  }
  /// <<< ============================= Home Page Items Builder Design End Here =============================


}
