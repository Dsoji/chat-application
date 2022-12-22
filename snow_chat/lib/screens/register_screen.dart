import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snow_chat/constants/constants.dart';
import 'package:snow_chat/widgets/reusable_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "234",
      countryCode: "NG",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nigeria",
      example: "Nigeria",
      displayName: "Nigeria",
      displayNameNoCountryCode: "NG",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(TextPosition(
      offset: phoneController.text.length,
    ));
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey.shade50),
                child: Image.asset('assets/images/pana.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's get started",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "A simple way to communicate, now add phone number to get your code.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: mOnboardingColor1,
                controller: phoneController,
                onChanged: ((value) {
                  setState(() {
                    phoneController.text = value;
                  });
                }),
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  labelText: "Phone number",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: mOnboardingColor1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: mOnboardingColor1)),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500),
                              onSelect: ((value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              }));
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: TextStyle(
                              fontSize: 18,
                              color: mOnboardingColor1,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  suffixIcon: phoneController.text.length > 9
                      ? Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(Icons.done,
                              color: Colors.white, size: 15),
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ColorButton(
                width: 300.w,
                color: mOnboardingColor1,
                text: "Next",
                onPressed: (() {}),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
