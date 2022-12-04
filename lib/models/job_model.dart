import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs {
  final DocumentReference jobRef;
  final String company;
  final String email;
  final String title;
  final String location;
  final String options;
  final String status;
  final String salary;
  final String description;
  final String type;

  Jobs(
      {this.jobRef,
      this.company,
      this.email,
      this.title,
      this.location,
      this.options,
      this.status,
      this.salary,
      this.description,
      this.type});

  factory Jobs.fromSnapshot(DocumentSnapshot job) {
    return Jobs(
      jobRef: job.reference,
      company: job.data['company'] ?? "",
      email: job.data['email'] ?? "",
      title: job.data['title'] ?? "",
      location: job.data['location'] ?? "",
      salary: job.data['salary'] ?? "",
      status: job.data['status'] ?? "",
      description: job.data['description'] ?? "",
      options: job.data['options'] ?? "",
      type: job.data['type'] ?? "",
    );
  }
}

// List<Jobs> jobData = [
//   Jobs(
//     title: 'WordPress Developer',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 2000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (React Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Flutter Developer (Flutter + Firebase)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Closed',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Closed',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Closed',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
//   Jobs(
//     title: 'Full Stack Dev (Rect Native + NodeJs)',
//     location: 'Accra-Ghana',
//     options: 'Remote',
//     status: 'Open',
//     salary: 9000,
//     description:
//         'Helped organized Facebook developer circle build day in my region. Introduced other developers to HTML5 Games to enable them participate in the developer challenge program.',
//   ),
// ];
