import 'package:diploma_result_management_forntend/theme/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/break_point.dart';
import '../../../widgets/step_number.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Widget leftWidget = Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.only(
          bottomRight:
              Radius.circular(MediaQuery.of(context).size.width * .350),
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
            child: Form(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Fill the form",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                          ),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            getStepWidget("1"),
                            const Gap(15),
                            Expanded(
                              child: TextFormField(
                                decoration: getInputDecoration(
                                  hint: "What is your Regulation?",
                                  label: "Regulation",
                                ),
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
                              child: TextFormField(
                                decoration: getInputDecoration(
                                  hint: "What is your Regulation?",
                                  label: "Regulation",
                                ),
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
                              child: TextFormField(
                                decoration: getInputDecoration(
                                  hint: "What is your Regulation?",
                                  label: "Regulation",
                                ),
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
                              child: TextFormField(
                                decoration: getInputDecoration(
                                  hint: "What is your Regulation?",
                                  label: "Regulation",
                                ),
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
                                decoration: getInputDecoration(
                                  hint: "What is your Regulation?",
                                  label: "Regulation",
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
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
                  ),
                  const Gap(50),
                  if (MediaQuery.of(context).size.width < breakPoint) leftWidget
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
