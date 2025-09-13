import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_page/model/story_model.dart';

class StoryPage extends StatefulWidget {
  final List<StoryModel> stories;
  const StoryPage({super.key,required this.stories});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with SingleTickerProviderStateMixin{
  late int currentIndex;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _setUpAnimation();
  }

  /// >>> ============ Set Animation with Progress Bar Start Here ==============
  void _setUpAnimation(){
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: widget.stories[currentIndex].duration));
    _animationController.addStatusListener((status) {
      if(!mounted) return;
      if(status == AnimationStatus.completed) _nextStory();
    });
    _animationController.forward();
  }
  /// <<< ============ Set Animation with Progress Bar End Here ================



  /// >>> ==================== Next Story Function Start Here ==================
  void _nextStory(){
    if(!mounted) return;
    if(currentIndex < widget.stories.length - 1){
      setState(() {currentIndex++;});
      _restartAnimation();
    }else{
      if(!mounted) return;
      Navigator.pop(context);
    }
  }
  /// <<< ==================== Next Story Function Start Here ==================



  /// >>> ==================== Previous Story Function Start Here ==============
  void _previousStory(){
    if(!mounted) return;
    if(currentIndex > 0){setState(() {currentIndex --;});}
    _restartAnimation();
  }
  /// <<< ==================== Previous Story Function End Here ================



  /// >>> ==================== Restart Animation Start Here ====================
  void _restartAnimation(){
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = Duration(seconds: widget.stories[currentIndex].duration);
    _animationController.forward();
  }
  /// <<< ==================== Restart Animation End Here ======================

  @override
  void dispose() {
    _animationController.removeStatusListener((status){});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final story = widget.stories[currentIndex];

    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if(details.globalPosition.dx > screenWidth / 2){
            _nextStory();
          }else{
            _previousStory();
          }
        },
        child: Stack(
          fit: StackFit.expand, // Full Screen Image Expanded
          children: [
            /// >>>  Body Image Show
            CachedNetworkImage(
              imageUrl: story.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.red, size: 50),),
            ),
            /// <<<  Body Image Show


            /// >>> Image Overlay Color
            Container(color: Colors.black38,),
            /// <<< Image Overlay Color



            /// >>> Progress Bar
            Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: Row(
                  children: List.generate(widget.stories.length, (index){
                    return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(left: index == 0 ? 2:0, right: 2),
                          decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.circular(2)),
                          child: index == currentIndex ? AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor: _animationController.value,
                                  alignment: Alignment.centerLeft,
                                  child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(2)),),
                                );
                              },
                          ) : null,
                        )
                    );
                  },),
                )
            ),
            /// <<< Progress Bar


            /// >>> Close Icon
            Positioned(
                top: 50,
                right: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10),),
                  child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close,color: Colors.white,))
                )
            ),
            /// <<< Close Icon



            /// >>> Story title & subtitle & navigate button
            Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(story.title, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10),
                    Text(story.subtitle, style: TextStyle(color: Colors.white70, fontSize: 18),),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text("Visit : ${widget.stories[currentIndex].navigatePage}")
                    )
                  ],
                )
            )
            /// <<< Story title & subtitle & navigate button
          ],
        ),
      ),
    );
  }
}
