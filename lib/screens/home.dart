// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:we_work/models/job_model.dart';
// import 'package:we_work/providers/jobs_provider.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/services/search.dart';
import 'package:we_work/services/fetch_jobs.dart';
import 'package:we_work/utils/colors.dart';
import 'package:we_work/utils/responsive.dart';
import 'package:we_work/widgets/input_decoration.dart';
import 'package:we_work/widgets/jobscard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;
  final searchController = TextEditingController();
  Auth auth = Auth();
  List queryResultSet = [];
  List tempSearchStore = [];
  List tempReferences = [];
  List references = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context, listen: false);
    // print(user.uid);
    return Scaffold(
      backgroundColor: UiColors.bg,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sort,
                          size: 25.0,
                          color: UiColors.color2,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            auth.signOut();
                          },
                          child: Icon(
                            Icons.notifications_none,
                            size: 25.0,
                            color: UiColors.color2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    Container(
                      height: screenHeight(context, 0.734),
                      child: ListView(
                        children: [
                          Container(
                            height: screenHeight(context, 0.09),
                            decoration: BoxDecoration(
                              color: UiColors.color1,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) =>
                                  initiateSearch(value.trim()),
                              decoration: textInputDecoration(
                                hintText: 'Search jobs',
                                sicon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context, 0.04),
                          ),
                          Row(
                            children: [
                              Text(
                                'Recent jobs',
                                style: TextStyle(
                                    color: UiColors.color2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/alljobs');
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: screenHeight(context, 1),
                            child: searchController.text.isNotEmpty
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: tempSearchStore.length,
                                    itemBuilder: (context, index) {
                                      return JobCard(
                                        jobRef: tempReferences[index],
                                        company: tempSearchStore[index]
                                            ["company"],
                                        email: tempSearchStore[index]["email"],
                                        title: tempSearchStore[index]["title"],
                                        location: tempSearchStore[index]
                                            ["location"],
                                        options: tempSearchStore[index]
                                            ["options"],
                                        type: tempSearchStore[index]["type"],
                                        salary: tempSearchStore[index]
                                            ["salary"],
                                        status: tempSearchStore[index]
                                            ["status"],
                                        description: tempSearchStore[index]
                                            ["description"],
                                      );
                                    },
                                  )
                                : StreamBuilder<Future<List<Jobs>>>(
                                    stream: new FetchJobs().jobsStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 120.0),
                                          child: Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.lightBlue),
                                            ),
                                          ),
                                        );
                                      }

                                      return FutureBuilder<List<Jobs>>(
                                          future: snapshot.data,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 120.0),
                                                child: Container(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors
                                                                    .lightBlue),
                                                  ),
                                                ),
                                              );
                                            }
                                            List job = snapshot.data;
                                            return ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: job.length,
                                              itemBuilder: (context, index) {
                                                return JobCard(
                                                  jobRef: job[index].jobRef,
                                                  company: job[index].company,
                                                  email: job[index].email,
                                                  title: job[index].title,
                                                  location: job[index].location,
                                                  options: job[index].options,
                                                  type: job[index].type,
                                                  salary: job[index].salary,
                                                  status: job[index].status,
                                                  description:
                                                      job[index].description,
                                                );
                                              },
                                            );
                                          });
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initiateSearch(String query) {
    if (query.length == 0) {
      setState(() {
        print("DATA CLEARED");
        queryResultSet = [];
        tempSearchStore = [];
        references = [];
        tempReferences = [];
      });
      return;
    }
    String capitalizeValue =
        query.substring(0, 1).toUpperCase() + query.substring(1);
    if (queryResultSet.length == 0 && query.length == 1) {
      new SearchService().searchData(query).then((QuerySnapshot snapshot) {
        print("ABOUT TO ENTER FIRESTORE...");
        if (snapshot.documents.length <= 0) {
          print("No result found");
        } else {
          for (int i = 0; i < snapshot.documents.length; ++i) {
            queryResultSet.add(snapshot.documents[i].data);
            references.add(snapshot.documents[i].reference);
            setState(() {
              tempReferences.add(references[i]);
              tempSearchStore.add(queryResultSet[i]);
            });
          }
        }
      });
    } else {
      tempSearchStore = [];
      tempReferences = [];
      print("REFERENCES  ====> ${tempReferences.length}");
      print("ACTUAL DATA  ====> ${tempSearchStore.length}");
      // print(queryResultSet);
      queryResultSet.asMap().forEach((index, element) {
        print(index);
        if (element['title'].toLowerCase().contains(query.toLowerCase()) ==
            true) {
          if (element['title'].toLowerCase().indexOf(query.toLowerCase()) ==
              0) {
            setState(() {
              tempReferences.add(references[index]);
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && query.length > 1) {
      setState(() {});
    }
  }
}
