import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
class AutoFillOtp extends StatefulWidget {
  const AutoFillOtp({Key? key}) : super(key: key);

  @override
  State<AutoFillOtp> createState() => _AutoFillOtpState();
}

class _AutoFillOtpState extends State<AutoFillOtp> with CodeAutoFill{
  String codeValue="";
  @override
  void codeUpdated(){
    debugPrint("Update code is : $code");
    setState((){
      debugPrint("codeUpdated");
    });
  }
  @override
  void initState(){
    super.initState();
    listenOtp();
  }
  void listenOtp()async{
    await SmsAutoFill().unregisterListener();     // for used in resend otp
    listenForCode();
    await SmsAutoFill().listenForCode();
    debugPrint("OTP listen Called");
  }
  @override
  void dispose(){
    super.dispose();
    SmsAutoFill().unregisterListener();
  }
  @override
  Widget build(BuildContext context) {
    Map args=ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Fill Otp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                  PinFieldAutoFill(
                    currentCode: codeValue,
                    codeLength: 4,
                    onCodeChanged: (code){
                      debugPrint("OnCodeChanged $code");
                      setState((){
                        codeValue=code.toString();
                      });
                    },
                    onCodeSubmitted: (val){
                      debugPrint("onCodeSubmitted $val");
                    },
                  ),
              const SizedBox(height: 50,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/home_page',(Route<dynamic> route) => false);
                },style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.all(10),
                ), child: const Text('Verify Otp'),),
              ),
              Text('Mobile No is : ${args['Mobile_Number']}',style: const TextStyle(fontSize: 20),),
              Text('App Signature id is : ${args['app_signature_id']}',style: const TextStyle(fontSize: 20),),
              const Text('You can send message through phone for testing ',style: TextStyle(fontSize: 20),),
              const Text('For Ex.',style: TextStyle(fontSize: 20),),
              Text("<#> your Otp is 8573 ${args['app_signature_id']}",style:const TextStyle(fontSize: 20),),
              Text('Send message to this mobile number : ${args['Mobile_Number']}',style: const TextStyle(fontSize: 20),),

            ],
          ),
        ),
      ),
    );
  }
}
