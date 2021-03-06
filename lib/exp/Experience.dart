import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/exp/project/Project.dart';
import 'package:my_portfolio/models/Experience.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Experience extends StatefulWidget {
  @override
  _ExperienceState createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  final companyStyle = GoogleFonts.merriweatherSans(
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue);
  final positionStyle = GoogleFonts.openSans(
    fontSize: 18,
    fontStyle: FontStyle.italic,
  );
  var exps = [
    ExperienceModel(
        company: "ELCA Viet Nam",
        time: "From August 2020 to present",
        title: "Associate Engineer",
        projects: [
          ProjectModel(
            projectName: "ZH Services",
            position: "Enginner",
            stack:
                "Java, Spring, MariaDB, Atermis, MinIO, Docker, Jenkins, Cucumber, Microservices",
            description:
                "The government system built with microservice architect, which helps canton ZH in Switzerland manage their population, administrative formalities.. This system includes: naturalization, documents, registration, etc",
            task:
                "Develop building blocks in the system, prepare and maintain integration tests for that ones",
          ),
          ProjectModel(
              projectName: "Papillon",
              position: "Fullstack",
              stack: "Java, Spring, Ant, HTML, Javascript",
              description:
                  "A goverment's project to help them manage prisoners, and their's profiles.",
              task:
                  "Maintain project, write a new module for managing documents, the leave days of prisoners. Write the batch to migrate all data from the old system to the new one "),
          ProjectModel(
            projectName: "Phoenix",
            position: "Fullstack",
            stack: "Java, Spring, Ant, HTML, Javascript",
            description:
                "A project with the process that can provide license tests for railway drivers. Also, help railways companies register, train new drivers ",
            task: "",
          ),
        ]),
    ExperienceModel(
        company: "KMS Technology",
        time: "From August 2019 to January 2020",
        title: "Internship",
        isActive: false,
        projects: [
          ProjectModel(
              projectName: "KMS Library",
              position: "Backend",
              stack: "Golang, Elasticsearch, Docker, VueJS, MongoDB",
              description:
                  "An internal project for whole company, help the administrators manage the book-borrow or kindle-borrow transactions,",
              task:
                  "Write backend documents, new APIs, migrate data from the old system to the new one and deploy the application to server with Docker")
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    return Container(
        padding: EdgeInsets.only(top: 20),
        height: height - (height / (exps.length + 1)) + 80,
        width: MediaQuery.of(context).size.width *
            MediaQuery.of(context).devicePixelRatio,
        child: Column(
          children: exps.map((e) {
            return TimelineTile(
              axis: TimelineAxis.vertical,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                  width: 30,
                  height: 30,
                  color: e.isActive ? Colors.green : Colors.red,
                  iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: e.isActive
                          ? Icons.check_circle_outline
                          : Icons.radio_button_unchecked,
                      fontSize: 20)),
              startChild: Container(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(e.time),
                ),
              ),
              endChild: Container(
                height: height / (exps.length + 1),
                width: 200,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.black),
                    Text(
                      e.company,
                      style: companyStyle,
                    ),
                    Text(e.title, style: positionStyle),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: e.projects
                              .asMap()
                              .map((i, project) {
                                return MapEntry(
                                    i,
                                    Container(
                                        padding: i == e.projects.length - 1
                                            ? null
                                            : EdgeInsets.only(bottom: 10),
                                        child: Project(project: project)));
                              })
                              .values
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}
