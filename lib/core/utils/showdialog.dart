 import 'package:Toxicon/Features/Authantication/changepass/view/resetpass.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

Future<dynamic> showdialogcustom(BuildContext context,String image) {
    return showDialog(
 context: context,
 builder: (BuildContext context) {
   return GiffyDialog.image(
    Image.asset(image,
       height: 200,
       fit: BoxFit.cover,
     ),
     title:const Text(
       'Check your Gmail',
       textAlign: TextAlign.center,
     ),
    
     actions: [
       TextButton(
         onPressed: () => Navigator.pop(context, 'CANCEL'),
         child: const Text('CANCEL'),
       ),
      const SizedBox(width: 100,),
       TextButton(
         onPressed: () =>Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResetPassword(),
                          ),
         ),
         child: const Text('OK'),
       ),
     ],
   );
 },
 );
  }
 Future<dynamic> showdialogcustomconvert(BuildContext context) {
    return showDialog(
 context: context,
 builder: (BuildContext context) {
   return GiffyDialog.image(
    Image.asset(
       ImageConstant.downloadsucsses,
       height: 200,
       fit: BoxFit.cover,
     ),
     title:const Text(
       'your file downloaded successfully',
       textAlign: TextAlign.center,
     ),
    
     actions: [
      
      const SizedBox(width: 100,),
       TextButton(
        onPressed: () => Navigator.pop(context, 'CANCEL'),
         child: const Text('OK'),
       ),
     ],
   );
 },
 );
  }


