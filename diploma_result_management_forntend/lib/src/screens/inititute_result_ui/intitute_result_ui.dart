import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IntituteResultUi extends StatelessWidget {
  final Map result;
  const IntituteResultUi({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mainResult = result['result'];
    List allKeyOfRoll = mainResult.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Institution Result"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Text("Download CSV"),
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
            Text(
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
                Text(
                  "Pass: ${result['passed']}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(),
                Text(
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
                                child: Text(
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
                                child: Text(
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
                                child: Text(
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
                                child: Text(
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
                              child: Text(
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
                              child: Text(
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
                              child: Text(
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
                              child: Text(
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
