// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:diploma_result_management_forntend/src/api/apis.dart';
import 'package:diploma_result_management_forntend/src/models/individual_result_query.dart';
import 'package:diploma_result_management_forntend/src/models/institute_result_query.dart';
import 'package:diploma_result_management_forntend/src/screens/individual_result_show_ui.dart/individual_result_ui.dart';
import 'package:diploma_result_management_forntend/src/screens/inititute_result_ui/intitute_result_ui.dart';
import 'package:diploma_result_management_forntend/src/theme/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/break_point.dart';
import '../../widgets/step_number.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listOfFiles = [];
  bool isListOfFilesLoading = true;

  @override
  void initState() {
    getFilesInfo();
    super.initState();
  }

  void getFilesInfo() async {
    http.Response response = await http.get(Uri.parse(filesListAPIURL));
    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      listOfFiles = List<String>.from(decodedData['files-list']);
      filterFiles();
      setState(() {
        isListOfFilesLoading = false;
      });
    }
  }

  String examType = "";
  String regulation = "";
  String heldOn = "";
  String semester = "";
  List<String> listOfexamType = [];
  List<String> listOfregulation = [];
  List<String> listOfheldOn = [];
  List<String> listOfsemester = [];

  TextEditingController rollOrEIINController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void filterFiles() {
    listOfexamType = [];
    listOfregulation = [];
    listOfheldOn = [];
    listOfsemester = [];
    for (String e in listOfFiles) {
      if (e.contains(examType) &&
          e.contains(regulation) &&
          e.contains(heldOn) &&
          e.contains(semester)) {
        List<String> splitedInfo = e.split("_");
        if (!listOfexamType.contains(splitedInfo[0]) ||
            listOfexamType.isEmpty) {
          listOfexamType.add(splitedInfo[0]);
        }

        if (!listOfregulation.contains(splitedInfo[1]) ||
            listOfregulation.isEmpty) {
          listOfregulation.add(splitedInfo[1]);
        }

        if (!listOfheldOn.contains(splitedInfo[2]) || listOfheldOn.isEmpty) {
          listOfheldOn.add(splitedInfo[2]);
        }

        if (!listOfsemester.contains(splitedInfo[3]) ||
            listOfsemester.isEmpty) {
          listOfsemester.add(splitedInfo[3]);
        }
      }
    }
    listOfexamType.sort();
    listOfregulation.sort();
    listOfregulation = listOfregulation.reversed.toList();
    listOfheldOn.sort();
    listOfsemester.sort();
    setState(() {});
  }

  bool isInstitution = false;
  bool isResultLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget leftWidget = Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.only(
          bottomRight:
              Radius.circular(MediaQuery.of(context).size.width * .250),
        ),
      ),
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Welcome ...\n",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                  ),
                ),
                TextSpan(
                  text:
                      "A open source fullstack Diploma Result Management project. Here we tried to add best features as we can.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(
                  SimpleIcons.github,
                  color: Colors.grey.shade800,
                ),
              ),
              const Gap(10),
              const Text(
                "Github link for Frontend",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    "https://github.com/IsmailHosenIsmailJames/Full-Stack-Diploma-Result-Management",
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.link),
                  const Gap(10),
                  Text(
                    "https://github.com/IsmailHosenIsmailJames/Full-Stack-Diploma-Result-Management",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          const Gap(15),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(
                  SimpleIcons.github,
                  color: Colors.grey.shade800,
                ),
              ),
              const Gap(10),
              const Text(
                "Github link for Backend",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    "https://github.com/IsmailHosenIsmailJames/backend_python_fast_api",
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.link),
                  const Gap(10),
                  Text(
                    "https://github.com/IsmailHosenIsmailJames/backend_python_fast_api",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          const Gap(10),
          const Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.orange,
              ),
              Gap(10),
              Text(
                "Make sure you give a start on github project!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(50),
          const Text(
            "Follow me",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          const Gap(10),
          Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(
                      "https://github.com/IsmailHosenIsmailJames",
                    ),
                  );
                },
                icon: const Icon(SimpleIcons.github),
              ),
              const Gap(20),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(
                      "https://www.facebook.com/mdismailhosen.james/",
                    ),
                  );
                },
                icon: const Icon(SimpleIcons.facebook),
              ),
              const Gap(20),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(
                      "https://www.linkedin.com/in/ismail-hosen-james-3756a4211/",
                    ),
                  );
                },
                icon: const Icon(SimpleIcons.linkedin),
              ),
            ],
          ),
          const Gap(15),
        ],
      ),
    );
    Widget formWidget = Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fill the form",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 50,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (route) => true,
                  );
                },
                icon: const Icon(Icons.restore),
                label: const Text("Reset"),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              getStepWidget("1"),
              const Gap(15),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: getInputDecoration(
                      label: "Exam Type", hint: "Select your exam type..."),
                  items: listOfexamType
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      examType = value!;
                    });
                    filterFiles();
                  },
                ),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: [
              getStepWidget("2"),
              const Gap(15),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: getInputDecoration(
                      hint: "Select your Regulation...", label: "Regulation"),
                  items: listOfregulation
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      regulation = value!;
                    });
                    filterFiles();
                  },
                ),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: [
              getStepWidget("3"),
              const Gap(15),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: getInputDecoration(
                      hint: "Select your Semester...", label: "Semester"),
                  items: listOfsemester
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      semester = value!;
                    });
                    filterFiles();
                  },
                ),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: [
              getStepWidget("4"),
              const Gap(15),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: getInputDecoration(
                      hint: "When your exam Held in?", label: "Held in"),
                  items: listOfheldOn
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      heldOn = value!;
                    });
                    filterFiles();
                  },
                ),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: [
              getStepWidget("5"),
              const Gap(15),
              Expanded(
                child: TextFormField(
                  controller: rollOrEIINController,
                  validator: (value) {
                    try {
                      int.parse("$value");
                      return null;
                    } catch (e) {
                      return "This is not valid";
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: getInputDecoration(
                    hint: isInstitution
                        ? "type institue EIIN?"
                        : "type your roll?",
                    label: isInstitution ? "EIIN" : "Roll",
                  ),
                ),
              ),
            ],
          ),
          const Gap(50),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width > breakPoint
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isResultLoading = true;
                  });
                  if (isInstitution == true) {
                    print(InstituteResultQuery(
                      examType: examType,
                      regulation: int.parse(regulation),
                      heldOn: heldOn,
                      semester: int.parse(semester),
                      eiin: int.parse(rollOrEIINController.text),
                    ).toJson());
                    final response = await http.post(
                      Uri.parse(institutionAPIURL),
                      headers: {"content-type": "application/json"},
                      body: InstituteResultQuery(
                        examType: examType,
                        regulation: int.parse(regulation),
                        heldOn: heldOn,
                        semester: int.parse(semester),
                        eiin: int.parse(rollOrEIINController.text),
                      ).toJson(),
                    );
                    if (response.statusCode == 200 && response.body != "null") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntituteResultUi(
                            result: jsonDecode(response.body),
                            providan: regulation,
                            heldOn: heldOn,
                            semester: semester,
                          ),
                        ),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const Center(
                          child: Text(
                            "Something went worng",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    final response = await http.post(
                      Uri.parse(individualAPIURL),
                      headers: {"content-type": "application/json"},
                      body: IndividualResultQuery(
                        examType: examType,
                        regulation: int.parse(regulation),
                        heldOn: heldOn,
                        semester: int.parse(semester),
                        roll: int.parse(rollOrEIINController.text),
                      ).toJson(),
                    );
                    if (response.statusCode == 200 && response.body != "null") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndividualResultUi(
                            result: jsonDecode(response.body),
                          ),
                        ),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const Center(
                          child: Text(
                            "Something went worng",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  setState(() {
                    isResultLoading = false;
                  });
                }
              },
              child: isResultLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      "Get your result",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > breakPoint)
            Expanded(
              child: leftWidget,
            ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Institution Result",
                            style: TextStyle(
                              fontSize: 18,
                              color: isInstitution
                                  ? Colors.grey
                                  : Colors.blue.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (!isInstitution)
                            SizedBox(
                              width: 150,
                              child: Divider(
                                height: 2,
                                color: Colors.blue.shade900,
                              ),
                            )
                        ],
                      ),
                      const Gap(15),
                      Switch.adaptive(
                        value: isInstitution,
                        onChanged: (value) {
                          setState(() {
                            isInstitution = !isInstitution;
                          });
                        },
                      ),
                      const Gap(10),
                      Column(
                        children: [
                          Text(
                            "Institution Result",
                            style: TextStyle(
                              fontSize: 18,
                              color: isInstitution
                                  ? Colors.blue.shade900
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (isInstitution)
                            SizedBox(
                              width: 150,
                              child: Divider(
                                height: 2,
                                color: Colors.blue.shade900,
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: isListOfFilesLoading
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Gap(10),
                              Text("it take a while"),
                            ],
                          )
                        : formWidget),
                const Gap(50),
                if (MediaQuery.of(context).size.width < breakPoint) leftWidget
              ],
            ),
          ),
        ],
      ),
    );
  }
}
