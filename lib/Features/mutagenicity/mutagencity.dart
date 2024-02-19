// ignore_for_file: dead_code
import 'package:Toxicon/Features/mutagenicity/cubit/dna_cubit.dart';
import 'package:Toxicon/Features/mutagenicity/mutresult.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';

// ignore: must_be_immutable
class MutagencityScreen extends StatefulWidget {
  const MutagencityScreen({super.key});
  static String id = 'MutagencityScreen';
  @override
  State<MutagencityScreen> createState() => _MutagencityScreenState();
}

class _MutagencityScreenState extends State<MutagencityScreen> {
  TextEditingController dna = TextEditingController();
  String fileName = 'mol.sdf'; // Default file name

  // Function to handle file selection
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        // Perform any additional actions with the selected file if needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return BlocProvider(
        create: (context) => DnaCubit(),
        child: BlocConsumer<DnaCubit, DnaState>(
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
                      ImageConstant.dnaresult,
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
                          SizedBox(
                            height: size.height * .055,
                            child: CustomFormField(
                                ispass: false,
                                hint: 'Enter your Smile',
                                preicon: const Icon(
                                  Icons.edit,
                                  size: 19,
                                  color: kcolor,
                                ),
                                controller: dna),
                          ),
                          SizedBox(
                            height: size.height * .01,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Text(
                                    fileName,
                                    style:const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  IconButton(
                                      onPressed: _pickFile,
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
                          Center(
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      DnaCubit.get(context).viewResult();
                                    });
                                  },
                                  child: submit(size: size, isDark: isDark))),
                          SizedBox(height: size.height * .04),
                          DnaCubit.get(context).issubmit
                              ? dnaresult(
                                  size: size,
                                  result: DnaCubit().result,
                                  isDark: isDark)
                              : Center(
                                  child: Image.asset(
                                  ImageConstant.dnabefor,
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
            ));
          },
        ));
  }
}
