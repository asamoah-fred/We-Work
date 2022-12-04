import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:we_work/models/job_model.dart';
import 'package:we_work/services/auth.dart';
import 'package:we_work/services/fetch_jobs.dart';
import 'package:we_work/utils/colors.dart';
import 'package:we_work/utils/responsive.dart';
import 'package:we_work/widgets/input_decoration.dart';
import 'package:we_work/widgets/jobscard.dart';

class AllJobs extends StatefulWidget {
  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  bool _loading = false;
  Auth auth = Auth();
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.bg,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: UiColors.color2,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.02),
                    ),
                    Container(
                      height: screenHeight(context, 0.9),
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
                            height: screenHeight(context, 0.025),
                          ),
                          Text(
                            'Browse jobs',
                            style: TextStyle(
                                color: UiColors.color2,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                          ),
                          Spacer(),
                          Container(
                            height: screenHeight(context, 0.9),
                            child: StreamBuilder<Future<List<Jobs>>>(
                              stream: new FetchJobs().jobsStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 120.0),
                                    child: Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            backgroundColor: Colors.lightBlue),
                                      ),
                                    ),
                                  );
                                }

                                return FutureBuilder<List<Jobs>>(
                                    future: snapshot.data,
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
                                      List job = snapshot.data;
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: job.length,
                                        itemBuilder: (context, index) {
                                          return JobCard(
                                            jobRef: job[index].jobRef,
                                            company: job[index].company,
                                            title: job[index].title,
                                            location: job[index].location,
                                            options: job[index].options,
                                            type: job[index].type,
                                            salary: job[index].salary,
                                            status: job[index].status,
                                            description: job[index].description,
                                          );
                                        },
                                      );
                                    });
                              },
                            ),
                          )
                          // ...jobData
                          //     .getRange(0, 10)
                          //     .map((index) => jobCard(context, index))
                          //     .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
