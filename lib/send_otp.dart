import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  TextEditingController phoneController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Otp'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  validator: (value){
                    if(value!.trim().isEmpty || value == "null")
                      {
                        return '* Required Phone Number';
                      }
                    if(value.length>10 || value.length<10){
                      return '* Enter Valid Phone Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    // hoverColor: Colors.white,
                    // focusColor: Colors.white,
                    labelText: 'Enter Mobile Number',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),

                    border: OutlineInputBorder(
                        borderSide:const BorderSide(color: Colors.grey),
                        borderRadius:BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color: Colors.blueGrey,width: 2),
                        borderRadius:BorderRadius.circular(10)
                    ),
                  ),
                ),
                const SizedBox(height: 100,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()) {
                      submit(context);
                    }
                  },style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ), child: const Text('Submit'),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void submit(BuildContext context)async{
    String appSignatureId = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "Mobile_Number":phoneController.text,
      "app_signature_id": appSignatureId
    };
    debugPrint("$sendOtpData");
    Navigator.pushNamed(context,'/verify_otp',arguments:  sendOtpData);
  }
}
