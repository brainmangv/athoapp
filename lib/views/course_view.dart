import 'package:atho/models/chapter.dart';
import 'package:atho/models/course.dart';
import 'package:atho/models/curriculum.dart';
import 'package:atho/models/lecture.dart';
import 'package:atho/repositories/course_repository.dart';
import 'package:atho/stores/app.store.dart';
import 'package:atho/utilities/helper.dart';
import 'package:atho/views/widgets/course/course_curriculum.dart';
import 'package:atho/views/widgets/course/course_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// int selectedLecture = 0;
var _urlKey = UniqueKey();

class CourseView extends StatefulWidget {
  CourseView({Key? key}) : super(key: key);
  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late TabController _tabController;
  // int selectedIndex = 0;
  late SubscribedCourse course;
  late CurriculumModel curriculum;
  late List<int> completedLectures;
  // final courseVideoPlayer = CourseVideoPlayer(videoUrl: '');
  String videoUrl = '';

  final courseRepository = CourseRepository();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Aulas'),
    Tab(text: 'Mais'),
  ];

  @override
  void initState() {
    super.initState();
    setState(() => _isLoading = true);
    _tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
    print('CourseView initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    course = ModalRoute.of(context)?.settings.arguments as SubscribedCourse;
    setState(() => _isLoading = true);
    loadAsync();
    print('CourseView didChange');
  }

  Future<void> loadAsync() async {
    curriculum = await this.courseRepository.curriculum(course.id);
    completedLectures =
        await this.courseRepository.completedLectures(course.id);

    Provider.of<AppStore>(context, listen: false)
        .setCurrentLecture(curriculum.chapters.first.lectures?.first);
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('CourseView build');
    // final store = Provider.of<AppStore>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text(course.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.black,
                      child:
                          Consumer<AppStore>(builder: (context, store, child) {
                        _urlKey = UniqueKey();
                        print('consumer: ${_urlKey.hashCode}');
                        return Column(children: [
                          store.currentLecture?.asset?.mediaSource != null
                              ? CourseVideoPlayer(
                                  // "https://athoapp.com.br/storage/videos/course11/chapter19/lecture32/6KzWYt9d0mKH8H4CGSMmMl2dMvgD7UGkd39Y2I9H.mp4",
                                  store.currentLecture!.asset!.mediaSource!,
                                  _urlKey)
                              : Container(),
                        ]);
                      }),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor),
                    child: TabBar(
                      controller: _tabController,
                      tabs: myTabs,
                      onTap: (int index) {
                        setState(() {
                          // selectedIndex = index;
                          _tabController.animateTo(index);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child:
                        // ListTiles(chapters: curriculum.chapters!)
                        IndexedStack(
                      // index: selectedIndex,
                      index: _tabController.index,
                      children: [
                        Visibility(
                          visible: _tabController.index == 0,
                          child: CourseCurriculum(
                            chapters: curriculum.chapters,
                            selectedLecture: 0,
                            completedLectures: completedLectures,
                          ),
                        ),
                        Visibility(
                            visible: _tabController.index == 1,
                            child: Text('This is the  tab 2',
                                style: const TextStyle(fontSize: 26)))
                      ],
                    ),
                  )
                ],
              ));
  }
}
