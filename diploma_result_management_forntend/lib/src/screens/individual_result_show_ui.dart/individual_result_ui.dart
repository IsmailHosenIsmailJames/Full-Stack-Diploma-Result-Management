import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IndividualResultUi extends StatelessWidget {
  final Map result;
  const IndividualResultUi({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Individual Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            result['pass'] == true
                ? CircleAvatar(
                    backgroundColor: Colors.blue.shade900,
                    radius: 80,
                    child: const Icon(
                      Icons.done_all_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 80,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
            const Gap(20),
            result['pass'] == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Result",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            result['result'].toString(),
                            style: TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Text(
                              "CGPA",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                          Text(
                            "Failed in ${List.from(result['failed']).length} ${{
                                  List.from(result['failed']).length
                                }.length > 1 ? "subjects" : "subject"}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(20)
                        ] +
                        List.generate(
                          List.from(result['failed']).length,
                          (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue.shade900,
                                  child: Text(
                                    "${index + 1}.",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                Text(
                                  List.from(result['failed'])[index],
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
