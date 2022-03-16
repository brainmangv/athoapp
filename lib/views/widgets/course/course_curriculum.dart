import 'package:atho/models/chapter.dart';
import 'package:atho/models/lecture.dart';
import 'package:atho/stores/app.store.dart';
import 'package:atho/utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCurriculum extends StatelessWidget {
  final List<ChapterModel> chapters;
  final int selectedLecture;
  final List<int> completedLectures;

  const CourseCurriculum(
      {required this.chapters, required this.selectedLecture, required this.completedLectures, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStore>(builder: (context, store, child) {
      print('Build curriculum');
      return ListView.builder(
          //  separatorBuilder: (BuildContext context, int index) => const Divider(),
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: this.chapters.length,
          itemBuilder: (BuildContext context, int i) {
            // print('ListView.builder');
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  title: Text('Capitulo ${i + 1} - ' + this.chapters[i].title,
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14), overflow: TextOverflow.ellipsis)),
              this.chapters[i].lectures != null
                  ? ListLectures(
                      lectures: this.chapters[i].lectures!,
                      completedLectures: this.completedLectures,
                    )
                  : Container(),
              if (i == this.chapters.length - 1)
                ListTile(
                  title: Container(
                      width: 376,
                      child: Text(
                        "Questionario",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      )),
                  // selectedTileColor: Colors.lightBlue[50],
                  // selected: i == selectedLecture ? true : false,
                  autofocus: false,
                  enabled: true,
                  onTap: () {
                    print('Questionario onTap');
                    // Provider.of<AppStore>(context, listen: false)
                    //     .setCurrentLecture(completedLectures[i]);
                  },
                  leading: Icon(Icons.app_registration_sharp, color: Colors.lightBlue[200], size: 20),
                ),
            ]);
          });
    });
  }
}

class ListLectures extends StatefulWidget {
  final List<LectureModel> lectures;
  final List<int> completedLectures;

  const ListLectures({required this.lectures, required this.completedLectures, Key? key}) : super(key: key);

  @override
  State<ListLectures> createState() => _ListLecturesState();
}

class _ListLecturesState extends State<ListLectures> {
  var selectedLecture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.selectedLecture = Provider.of<AppStore>(context, listen: true).currentLecture!.id;

    return ListView.builder(
        // padding: const EdgeInsets.all(8),
        itemCount: widget.lectures.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          print('ListLecture build ' + selectedLecture.toString());
          return widget.lectures[i].asset != null
              ? ListTile(
                  selectedTileColor: Colors.lightBlue[200],
                  selected: widget.lectures[i].id == selectedLecture,
                  autofocus: false,
                  enabled: true,
                  onTap: () {
                    print('ListLecture onTap ' + this.selectedLecture.toString());
                    setState(() {
                      Provider.of<AppStore>(context, listen: false).setCurrentLecture(widget.lectures[i]);
                    });
                  },
                  minLeadingWidth: 10,
                  // horizontalTitleGap: 0,
                  // dense: true,
                  leading: Text(
                    (i + 1).toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  title: Row(children: [
                    if (widget.completedLectures.contains(widget.lectures[i].id))
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.lightBlue[200],
                        size: 20,
                      ),
                    Container(
                        width: 376,
                        child: Text(
                          widget.lectures[i].title,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ))
                  ]),
                  subtitle: Text('Video - ' + formatTime(widget.lectures[i].asset!.length),
                      style: TextStyle(color: Colors.black)))
              : Container();
        });
  }
}
