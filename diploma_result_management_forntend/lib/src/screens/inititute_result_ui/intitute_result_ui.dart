import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html';

class IntituteResultUi extends StatelessWidget {
  final Map result;
  final String semester;
  final String heldOn;
  final String providan;
  const IntituteResultUi(
      {super.key,
      required this.result,
      required this.semester,
      required this.heldOn,
      required this.providan});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mainResult = result['result'];
    List allKeyOfRoll = mainResult.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText("Institution Result"),
        actions: [
          TextButton(
            onPressed: () async {
              List<List<String>> csvData = [
                ["NO", "Roll", "Result (CGPA)", "Failed"]
              ];
              for (int index = 0; index < mainResult.length; index++) {
                List<String> row = [];
                row.add(allKeyOfRoll[index].toString());
                row.add(allKeyOfRoll[index]);
                row.add((mainResult[allKeyOfRoll[index]]['result'] ?? "")
                    .toString());

                row.add((mainResult[allKeyOfRoll[index]]['failed'] ?? "")
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', ''));
                csvData.add(row);
              }
              String csv = const ListToCsvConverter().convert(csvData);
              final blob = Blob([csv], 'text/plain', 'native');
              final url = Url.createObjectUrlFromBlob(blob);
              AnchorElement(href: url)
                ..setAttribute("download",
                    "${result['name'].toString()}_providan-${providan}_held on-${heldOn}_semester-$semester.csv")
                ..click();
              Url.revokeObjectUrl(url);
            },
            child: const Row(
              children: [
                SelectableText(
                  "Download CSV",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Gap(5),
                Icon(Icons.download),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SelectableText(
              result['name'].toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SelectableText(
                  "Pass: ${result['passed']}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(),
                SelectableText(
                  "Refeared: ${result['refeared']}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SizedBox(
                width: 600,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: mainResult.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Center(
                                child: SelectableText(
                                  "NO",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: SelectableText(
                                  "Roll",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                child: SelectableText(
                                  "Result (CGPA)",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Center(
                                child: SelectableText(
                                  "Failed",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    bool isPassed =
                        mainResult[allKeyOfRoll[index - 1]]['pass'] == true;
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: isPassed
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        border: const Border(
                          left: BorderSide(color: Colors.grey),
                          right: BorderSide(
                            color: Colors.grey,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: SelectableText(
                                index.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: SelectableText(
                                allKeyOfRoll[index - 1],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: SelectableText(
                                mainResult[allKeyOfRoll[index - 1]]['result'] ??
                                    "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Center(
                              child: SelectableText(
                                (mainResult[allKeyOfRoll[index - 1]]
                                            ['failed'] ??
                                        "")
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
