import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyhub/core/common/custom_widgets.dart';
import 'package:studyhub/core/common/dropdown_widget.dart';
import 'package:studyhub/core/constants/global_variables.dart';
import 'package:studyhub/domain/provider/register_provider.dart';
import 'package:studyhub/screens/login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalVariables.height10,
                Stack(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    IconTitleWidget(h: h, w: w),
                  ],
                ),
                GlobalVariables.height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldwithHeading(
                        controller: registerProvider.firstNameController,
                        w: w,
                        h: h,
                        heading: 'First name',
                        hinttext: 'First name'),
                    TextFieldwithHeading(
                        controller: registerProvider.lastNameController,
                        w: w,
                        h: h,
                        heading: 'Last name',
                        hinttext: 'Last name'),
                  ],
                ),
                GlobalVariables.height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingWidget(text: 'Date of birth'),
                        GlobalVariables.height10,
                        Consumer<RegisterProvider>(
                          builder: (context, value, child) {
                            return Container(
                              // width: w * 0.4,
                              height: h * 0.05,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    registerProvider.dateOfBirth != null
                                        ? ' ${registerProvider.dateOfBirth!.toString().split(' ')[0]}'
                                        : 'Date of Birth',
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final DateTime? selectedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (selectedDate != null) {
                                        // Store the selected date of birth in your provider
                                        registerProvider
                                            .setDateOfBirth(selectedDate);
                                      }
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // Adjust as needed
                    CustomDropDownButton(
                        h: h), // Your existing CustomDropDownButton
                  ],
                ),
                GlobalVariables.height20,
                LocationDropdowns(w: w),
                GlobalVariables.height20,
                GlobalVariables.height20,
                TextFieldwithHeading(
                    controller: registerProvider.studyingforController,
                    w: w * 3,
                    h: h,
                    heading: 'Your are studying for',
                    hinttext: 'Studying for'),
                GlobalVariables.height20,
                TextFieldwithHeading(
                    controller: registerProvider.schoolCollegeController,
                    w: w * 3,
                    h: h,
                    heading: 'School/College/Institute',
                    hinttext: 'Enter School/College/Institute'),
                GlobalVariables.height20,
                Wrap(
                    spacing: 16,
                    children: List.generate(studyInterests.length, (index) {
                      final interest = studyInterests[index];

                      return Consumer<RegisterProvider>(
                        builder: (context, value, child) {
                          final isSelected =
                              value.selectedInterests.contains(interest);
                          return ActionChip(
                            onPressed: () {
                              value.toggleInterest(interest);
                            },
                            label: Text(interest),
                            backgroundColor:
                                isSelected ? Colors.blue.shade400 : null,
                          );
                        },
                      );
                    })),
                GlobalVariables.height20,
                TextFieldwithHeading(
                    controller: registerProvider.emailController,
                    w: w * 3,
                    h: h,
                    heading: 'Email',
                    hinttext: 'Enter your email'),
                GlobalVariables.height20,
                TextFieldwithHeading(
                    controller: registerProvider.passwordController,
                    w: w * 3,
                    h: h,
                    heading: 'Password',
                    hinttext: 'Enter a password'),
                GlobalVariables.height20,
                TextFieldwithHeading(
                    controller: registerProvider.confirmController,
                    w: w * 3,
                    h: h,
                    heading: 'Confirm Password',
                    hinttext: 'Enter a password'),
                GlobalVariables.height20,
                Row(
                  children: [
                    Checkbox(
                      value: registerProvider.isAgreed,
                      onChanged: (value) {
                        registerProvider.isAgreed = true;
                      },
                    ),
                    headingWidget(text: 'Agree the terms and conditions')
                  ],
                ),
                GlobalVariables.height20,
                CustomElevatedButton(
                  onTap: () {
                    final userData = {
                      'firstName': registerProvider.firstNameController.text,
                      'lastName': registerProvider.lastNameController.text,
                      'studyingFor':
                          registerProvider.studyingforController.text,
                      'schoolOrCollegeOrInsti':
                          registerProvider.schoolCollegeController.text,
                      'password': registerProvider.passwordController.text,
                      'email': registerProvider.emailController.text,
                      'dateOfBirth': registerProvider.dateOfBirth
                          .toString(), // Convert DateTime to string as needed
                      'country': registerProvider.country,
                      'state': registerProvider.state,
                      'city': registerProvider.city,
                      'interests': registerProvider.selectedInterests
                          .join(','), // Convert List to comma-separated string
                      'termsAgreed': registerProvider.isAgreed,
                    };
                    registerProvider.registerUser(userData);
                  },
                  text: 'Register',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldwithHeading extends StatelessWidget {
  const TextFieldwithHeading({
    Key? key,
    required this.controller,
    required this.w,
    required this.h,
    required this.heading,
    required this.hinttext,
  }) : super(key: key);

  final double w;
  final double h;
  final String heading;
  final String hinttext;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingWidget(text: heading),
        GlobalVariables.height10,
        CustomTextFormfield(
            hintText: hinttext,
            controller: controller,
            width: w * 0.35,
            height: h * 0.045),
      ],
    );
  }
}

class LocationDropdowns extends StatefulWidget {
  final double w;

  const LocationDropdowns({Key? key, required this.w}) : super(key: key);

  @override
  LocationDropdownsState createState() => LocationDropdownsState();
}

class LocationDropdownsState extends State<LocationDropdowns> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalVariables.height10,
        CSCPicker(
          showStates: true,
          showCities: true,
          flagState: CountryFlag.DISABLE,
          dropdownDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          countrySearchPlaceholder: "Country",
          stateSearchPlaceholder: "State",
          citySearchPlaceholder: "City",
          countryDropdownLabel: "*Country",
          stateDropdownLabel: "*State",
          cityDropdownLabel: "*City",
          selectedItemStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          onCountryChanged: (value) {
            setState(() {
              countryValue = value;
              registerProvider
                  .setCountry(value); // Set country value in provider
            });
          },
          onStateChanged: (value) {
            setState(() {
              stateValue = value.toString();
              registerProvider
                  .setState(value.toString()); // Set state value in provider
            });
          },
          onCityChanged: (value) {
            setState(() {
              cityValue = value.toString();
              registerProvider
                  .setCity(value.toString()); // Set city value in provider
            });
          },
        ),
      ],
    );
  }
}

Text headingWidget({required String text}) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.w600),
  );
}

List<String> preparingforSuggestionsIndia = [
  "RRB (Railway Recruitment Board) Exams",
  "SSC (Staff Selection Commission) Exams",
  "UPSC (Union Public Service Commission) Civil Services Exams",
  "PSC (Public Service Commission) Exams (State-specific)",
  "Engineering Entrance Exams (e.g., JEE Main, JEE Advanced)",
  "Medical Entrance Exams (e.g., NEET, AIIMS)",
  "Law Entrance Exams (e.g., CLAT)",
  "MBA Entrance Exams (e.g., CAT, MAT, XAT)",
  "GATE (Graduate Aptitude Test in Engineering)",
  "GRE (Graduate Record Examination)",
  "GMAT (Graduate Management Admission Test)",
  "Agriculture Competitive Exams",
  "Banking Exams (e.g., IBPS PO, SBI PO)",
  "Insurance Exams (e.g., LIC AAO, NIACL AO)",
  "Defense Exams (e.g., NDA, CDS)",
  "Teaching Exams (e.g., CTET, UGC NET)",
  "Chartered Accountancy (CA) Exams",
  "Company Secretary (CS) Exams",
  "Cost and Management Accountancy (CMA) Exams",
  "Hotel Management Entrance Exams (e.g., NCHM JEE)",
  "Fashion Designing Entrance Exams",
  "Entrance Exams for Architecture Courses (e.g., NATA)",
  "Entrance Exams for Pharmacy Courses (e.g., GPAT)",
  "Entrance Exams for Media and Communication Studies",
  "Entrance Exams for Fine Arts Courses",
  "Civil Engineering",
  "Mechanical Engineering",
  "Electrical Engineering",
  "Electronics and Communication Engineering",
  "Computer Science and Engineering",
  "Information Technology",
  "Chemical Engineering",
  "Aerospace Engineering",
  "Biotechnology",
  "Agricultural Engineering",
  "Environmental Engineering",
  "Marine Engineering",
  "Petroleum Engineering",
  "Textile Engineering",
  "Food Technology",
  "Dairy Technology",
  "Forestry and Wildlife",
  "Horticulture",
  "Fisheries Science",
  "Veterinary Science",
  "Nutrition and Dietetics",
  "Home Science",
  "Social Work",
  "Psychology",
  "Sociology",
  /////////////////////////////////////////
  "Mathematics",
  "Science",
  "Language Learning",
  "History",
  "Geography",
  "Literature",
  "Computer Skills",
  "Coding and Programming",
  "Data Science",
  "Web Development",
  "Digital Marketing",
  "Graphic Design",
  "Photography",
  "Business Management",
  "Entrepreneurship",
  "Finance and Accounting",
  "Economics",
  "Marketing",
  "Human Resources Management",
  "Project Management",
  "Communication Skills",
  "Public Speaking",
  "Leadership Skills",
  "Time Management",
  "Critical Thinking",
  "Problem Solving",
  "Research Skills",
  "Writing Skills",
  "Presentation Skills",
  "Health and Wellness",
  "Fitness and Exercise",
  "Nutrition",
  "Mental Health Awareness",
  "Art and Creativity",
  "Music",
  "Dance",
  "Theater",
  "Crafts and DIY",
  "Cooking and Culinary Skills",
  "Fashion and Styling",
  "Interior Design",
  "Travel and Tourism",
  "Hospitality",
  "Customer Service",
  "Language Translation and Interpretation",
  "Environmental Awareness",
  "Sustainability Practices",
  "Disaster Management",
  "First Aid and Emergency Response",
  "Social Media Management",
  "Content Creation",
  "Online Teaching and Tutoring",
  "Career Development",
  "Resume Writing",
  "Interview Preparation",
  "Networking Skills",
  "Freelancing Skills",
  "Remote Work Skills"
];

List<String> globalPreparationSuggestions = [
  "Mathematics",
  "Science",
  "Language Learning",
  "History",
  "Geography",
  "Literature",
  "Computer Skills",
  "Coding and Programming",
  "Data Science",
  "Web Development",
  "Digital Marketing",
  "Graphic Design",
  "Photography",
  "Business Management",
  "Entrepreneurship",
  "Finance and Accounting",
  "Economics",
  "Marketing",
  "Human Resources Management",
  "Project Management",
  "Communication Skills",
  "Public Speaking",
  "Leadership Skills",
  "Time Management",
  "Critical Thinking",
  "Problem Solving",
  "Research Skills",
  "Writing Skills",
  "Presentation Skills",
  "Health and Wellness",
  "Fitness and Exercise",
  "Nutrition",
  "Mental Health Awareness",
  "Art and Creativity",
  "Music",
  "Dance",
  "Theater",
  "Crafts and DIY",
  "Cooking and Culinary Skills",
  "Fashion and Styling",
  "Interior Design",
  "Travel and Tourism",
  "Hospitality",
  "Customer Service",
  "Language Translation and Interpretation",
  "Environmental Awareness",
  "Sustainability Practices",
  "Disaster Management",
  "First Aid and Emergency Response",
  "Social Media Management",
  "Content Creation",
  "Online Teaching and Tutoring",
  "Career Development",
  "Resume Writing",
  "Interview Preparation",
  "Networking Skills",
  "Freelancing Skills",
  "Remote Work Skills"
];

final List<String> studyInterests = [
  "Mathematics",
  "English",
  "Social Science",
  "Mechanical Engineering",
  "Information Technology",
  "Biology",
  "Medical Science",
  "Physics",
  "Chemistry",
  "History",
  "Geography",
  "Computer Science",
  "Economics",
  "Psychology",
  "Environmental Science",
  "Linguistics",
  "Anthropology",
  "Sociology",
  "Political Science",
  "Philosophy",
  "Artificial Intelligence",
  "Data Science",
  "Electrical Engineering",
  "Civil Engineering",
  "Architecture",
  "Business Administration",
  "Finance",
  "Marketing",
  "Management",
  "Digital Marketing",
  "Graphic Design",
  "Interior Design",
  "Fashion Design",
  "Criminal Justice",
  "Law",
  "International Relations",
  "Public Administration",
  "Public Health",
  "Nursing",
  "Pharmacy",
  "Dentistry",
  "Veterinary Science",
  "Agriculture",
];
