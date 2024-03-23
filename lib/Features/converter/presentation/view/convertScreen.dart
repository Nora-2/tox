// ignore_for_file: avoid_print, unused_field, avoid_web_libraries_in_flutter, camel_case_types, use_build_context_synchronously

import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/Features/converter/cubit/convert_cubit.dart';
import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class convertScreen extends StatefulWidget {
  const convertScreen({super.key});
  @override
  State<convertScreen> createState() => _convertScreenState();
}

class _convertScreenState extends State<convertScreen> {
  final TextEditingController _smilesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String fileName = 'input.sdf';
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => ConvertCubit(),
        child: BlocConsumer<ConvertCubit, ConvertState>(
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
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.converttop,
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
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextfont24_600(text: 'Input Smile'),
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
                                    controller: _smilesController),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                CustomTextfont24_600(text: 'Input Sdf'),
                                SizedBox(
                                  height: size.height * .015,
                                ),
                                Container(
                                  height: size.height * .055,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(.8)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          fileName,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles();

                                              if (result != null) {
                                                setState(() {
                                                  fileName =
                                                      result.files.single.name;
                                                  ConvertCubit.get(context).selectedFile =
                                                      result.files.single;
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.upload_file,
                                              color: kcolor,
                                              size: 28,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              ConvertCubit.get(context)
                                                  .convertAndDownloadpdb(
                                                      _smilesController.text);
                                            });
                                          },
                                          child:   Container(
                                            height: 38,
                                            width: size.width * .3,
                                            decoration: BoxDecoration(
                                              color: kcolor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Center(
                                              child: Text('Pdb',
                                                  style: TextStyle(
                                                    fontFamily: 'sanchez',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              ConvertCubit.get(context)
                                                  .convertAndDownload(
                                                      _smilesController.text);
                                            });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: size.width * .3,
                                            decoration: BoxDecoration(
                                              color: kcolor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Center(
                                              child: Text('Sdf',
                                                  style: TextStyle(
                                                    fontFamily: 'sanchez',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          )),
                                    ),
                                    SizedBox(width: size.width * .02),
                                    Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              ConvertCubit.get(context)
                                                  .uploadFile(
                                                      context);
                                            });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: size.width * .3,
                                            decoration: BoxDecoration(
                                              color: kcolor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Center(
                                              child: Text('Smile',
                                                  style: TextStyle(
                                                    fontFamily: 'sanchez',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * .02),
                                Center(
                                    child: Image.asset(
                                  ImageConstant.converthome,
                                  width: size.width * .9,
                                  height: size.height * .45,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
