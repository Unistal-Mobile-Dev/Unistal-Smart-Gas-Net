import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/email_validation.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_success_widget.dart';

class ForgotPasswordHelper {


  static Future<dynamic> emailValidation({required String email, required BuildContext context}) async {

    try{
        if(email.isEmpty){
          SnackBarErrorWidget(context).show(message: "Please enter email id");
          return false;
        } else if(await EmailValidation.checkEmailValidation(emailId: email) == false){
          SnackBarErrorWidget(context).show(message: "Please enter valid email id");
          return false;
        }
        return true;
    }catch(e){
      return false;
    }
  }

  static Future<dynamic> submitEmailOnServer({required String email, required BuildContext context}) async {

    try{
      var checkEmailValidation =  await emailValidation(email: email, context: context);
      if(checkEmailValidation == false){
        return false;
      }
      String url =  APIs.forgotPasswordApi;
      var json =  {"email" : email};
      String queryString = Uri(queryParameters: json).query;
      var res =  await ServerRequest.getData(urlEndPoint: url +  '?' + queryString);
      if(res != null){
        if(res['status'] != null && res['status'] == 200 && res['response'] != null){
          SnackBarSuccessWidget(context).show(message: res['response']);
          return true;
        } else  if(res["status"] != null && res['status'] == 500 && res['response'] != null){
          SnackBarErrorWidget(context).show(message: res['response'].toString());
          return null;
        }else{
          if(res['error'] != null){
            _showSnackbar(message: res['error'], context: context);
            return false;
          }
        }
      }else{
        SnackBarErrorWidget(context).show(message: "Internal server error");
        return false;
      }
    }catch(e){
      SnackBarErrorWidget(context).show(message: "Internal server error");
      return false;
    }
  }

  static _showSnackbar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message,style: new TextStyle(color: Colors.white,fontSize: 14.0, fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
    ));
    return;
  }

}