// ignore_for_file: dead_code, avoid_print, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:Toxicon/Features/molecule/cubit/molecule_cubit.dart';
import 'package:Toxicon/Features/molecule/result.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import '../../core/utils/function/arrowpop.dart';
DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);
// ignore: must_be_immutable
class MoleculeScreen extends StatefulWidget {
  const MoleculeScreen({super.key});
  static String id = 'MoleculeScreen';
  @override
  State<MoleculeScreen> createState() => _MoleculeScreenState();
}
class _MoleculeScreenState extends State<MoleculeScreen> {
  TextEditingController mol = TextEditingController();
  @override
  Widget build(BuildContext context) {
      MoleculeCubit cubit = MoleculeCubit.get(context);
    bool result = cubit.toxicityScore > 1 || cubit.toxicityScore == 1 ? true : false;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;

    final size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => MoleculeCubit(),
        child: BlocConsumer<MoleculeCubit, MoleculeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: Container(
              decoration: BoxDecoration(gradient: gradientTop(isDark)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        arrowpop(isDark: isDark),
                        SizedBox(
                          width: size.width * .2,
                        ),
                        Image.asset(
                          ImageConstant.molresult,
                          width: 190,
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? black : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 9,
                            offset: const Offset(0, -2),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 10, right: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextfont24_600(text: 'Input'),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              CustomFormField(
                                  ispass: false,
                                  hint: 'Enter your Smile',
                                  preicon: const Icon(
                                    Icons.edit,
                                    size: 19,
                                    color: kcolor,
                                  ),
                                  controller: mol),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print(cubit.saScore);
                                    print(cubit.toxicityScore);
                                    setState(() {
                                     cubit.predictToxicity(mol.text);
                                     cubit.calculateSaScore(mol.text);
                                      cubit.computeGasteigerCharges(mol.text);
                                      cubit.generate3DStructure(mol.text);
                                     cubit.processSmiles(mol.text);
                                      cubit.addhistory(date: date,mol:mol.text,prediction:   cubit.toxicityScore > 1 || cubit.toxicityScore == 1 ? 'toxic' : 'non-toxic',);
                                      MoleculeCubit.get(context).viewResult();
                                    });
                                  },
                                  child: submit(size: size, isDark: isDark),
                                ),
                              ),
                              SizedBox(height: size.height * .02),
                              MoleculeCubit.get(context).issubmit
                                  ? resultmolecule(
                                      atom: cubit.atoms,
                                      gester: cubit.gester,
                                      size: size,
                                      sascore: cubit.saScore,
                                      toxscore: cubit.toxicityScore,
                                      imagepath:cubit.imagePath,
                                      bond:cubit.resultmol,
                                      result: result,
                                      isDark: isDark)
                                  : Center(
                                      child: Image.asset(
                                      ImageConstant.molbefor,
                                      width: size.width * .9,
                                      height: size.height * .5,
                                    ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          },
        ));
  }
}


    // Future<void> addhistory() {
    //   // Call the user's CollectionReference to add a new user
    //   return history
    //       .add({
    //         'result':
    //             cubit.toxicityScore > 1 || cubit.toxicityScore == 1 ? 'toxic' : 'non-toxic',
    //         'input': mol.text,
    //         'date': date,
    //         'category': 'molecule Toxicity',
    //         'id': FirebaseAuth.instance.currentUser!.uid,
    //       })
    //       .then((value) => print("history Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }
     // CollectionReference history =
    //     FirebaseFirestore.instance.collection('history');
    // 