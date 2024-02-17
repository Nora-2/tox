// ignore_for_file: dead_code, camel_case_types
import 'package:Toxicon/Features/smilarty/cubit/smilarty_cubit.dart';
import 'package:Toxicon/Features/smilarty/resultsmilarty.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';


// ignore: must_be_immutable
class smilartyScreen extends StatefulWidget {
  const smilartyScreen({super.key});
static String id = 'smilartyScreen';
  @override
  State<smilartyScreen> createState() => _smilartyScreenState();
}

class _smilartyScreenState extends State<smilartyScreen> {
  TextEditingController smile1 = TextEditingController();
TextEditingController smile2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    bool result = false;

    return BlocProvider(
        create: (context) => SmilartyCubit(),
        child: BlocConsumer<SmilartyCubit, SmilartyState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: SafeArea(
                    child: Container(
              decoration: BoxDecoration(gradient: gradientTop(isDark)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      arrowpop(isDark: isDark),
                      SizedBox(
                        width: size.width * .2,
                      ),
                      Image.asset(
                        ImageConstant.similartyhome,
                        width: 190,
                        height: 100,
                      )
                    ],
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
                            blurRadius: 10,
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
                                controller: smile1),
                                
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
                                controller: smile2),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    SmilartyCubit.get(context).viewResult();
                                  });
                                },
                                child: submit(size: size, isDark: isDark),
                              ),
                            ),
                            SizedBox(height: size.height * .04),
                            SmilartyCubit.get(context).issubmit
                                ? resultsimilarty(
                                    size: size, result: result, isDark: isDark)
                                : Center(
                                    child: Image.asset(
                                    ImageConstant.similartybefor,
                                    width: size.width * .9,
                                    height: size.height * .4,
                                  ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
          },
        ));
  }
}
