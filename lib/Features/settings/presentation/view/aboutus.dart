import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/Customaboutcard.dart';

// ignore: camel_case_types
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    List widgets = [
      Center(
          child: Image.asset(
        ImageConstant.information,
        width: size.width * .9,
        height: size.height * .25,
      )),
      CustomInfoCard(
        titel: 'How can users utilize the program to research drug toxicity ?',
        subtitel:
            'Users can input drug information via SMILES or images to investigate its toxicity',
        size: size,
      ),
      CustomInfoCard(
        titel:
            'How are the toxicity results presented to users, and what specific information do they receive ?',
        subtitel:
            'Results are displayed, indicating whether the drug is toxic or non-toxic, along with SA Score and Tox Score.',
        size: size,
      ),
      CustomInfoCard(
        titel:
            'How does the program handle the Mutagenicity analysis, and what are the expected results?',
        subtitel:
            'The Mutagenicity analysis processes SMILES input and provides information on whether the substance is mutagenic or not.',
        size: size,
      ),
      CustomInfoCard(
        titel:
            'How can the user check if the drug induces liver injury (DILI) ,and what are the expected results?',
        subtitel:
            'Users can input SMILES to check its ability to induce liver injury, and the program outputs either positive or negative results',
        size: size,
      ),
      CustomInfoCard(
        titel:
            "What is the significance and usage of SA Score and Tox Score in the program's results?",
        subtitel:
            "SA Score and Tox Score provide insights into the drug's safety ,helping users interpret drug potential toxicity and its probability to be synthesized",
        size: size,
      ),
      CustomInfoCard(
        titel:
            "How can users benefit from the Chatbot service in the program, and how does it respond to their questions?",
        subtitel:
            "The Chatbot addresses user queries related to the program's field or other domains, providing informative responses.",
        size: size,
      ),
      CustomInfoCard(
        titel:
            "What technologies or methods does Toxikon use in drug toxicity research?",
        subtitel:
            "Toxikon employs advanced technologies and methods for comprehensive drug toxicity research.",
        size: size,
      ),
      CustomInfoCard(
        titel:
            "Is Toxikon available to the general public, or is it targeted towards a specific group of researchers or specialists?",
        subtitel:
            "Toxikon is accessible to both the general public and specific groups of researchers or specialists.",
        size: size,
      ),
    ];
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
        color: isDark ? black : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arrowpop(isDark: isDark),
                const SizedBox(
                  width: 40,
                ),
              const customtext60020(text: 'Information')
              ],
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Expanded(
            child: SizedBox(
              height: size.height * .98,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
