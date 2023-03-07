import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';
import 'widget/text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController dateofbirthController;
  late TextEditingController genderController;
  int remainchar = 64;
  @override
  void initState() {
    nameController = TextEditingController(text: 'Shreya Singh');
    emailController = TextEditingController(text: 'shreyasingh123@gmail.com');
    usernameController = TextEditingController();
    dateofbirthController = TextEditingController();
    genderController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6.0),
            child: LinearProgressIndicator(
              backgroundColor: CustomTheme.white,
              valueColor:
                  AlwaysStoppedAnimation<Color>(CustomTheme.primaryColor),
              value: 0.5,
            ),
          ),
          backgroundColor: CustomTheme.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: CustomTheme.black)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: CustomTheme.white,
                      boxShadow: [
                        BoxShadow(
                            color: CustomTheme.lightgrey1,
                            offset: Offset(0, 0.5),
                            blurRadius: 10,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.asset('assets/profile_icon.png'),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Center(
                    child:
                        Text('Edit Profile', style: TextStyle(fontSize: 33))),
                TextFieldWidget(
                  title: 'What’s your name?',
                  hintText: 'Write your full name here',
                  controller: nameController,
                  onChanged: (e) {
                    setState(() {
                      remainchar = 64 - nameController.text.length;
                    });
                  },
                  remainChar: remainchar.toString(),
                  textWeight: FontWeight.bold,
                ),
                TextFieldWidget(
                  title: 'Your Email',
                  hintText: 'Write your full name here',
                  controller: emailController,
                  onChanged: (e) {
                    setState(() {
                      remainchar = 64 - nameController.text.length;
                    });
                  },
                  remainChar: remainchar.toString(),
                  showchar: false,
                  textWeight: FontWeight.bold,
                ),
                TextFieldWidget(
                  title: 'Username',
                  hintText: 'Enter Username',
                  controller: usernameController,
                  onChanged: (e) {
                    setState(() {
                      remainchar = 64 - nameController.text.length;
                    });
                  },
                  remainChar: remainchar.toString(),
                  showchar: false,
                  textWeight: FontWeight.bold,
                ),
                TextFieldWidget(
                  title: 'Date of Birth',
                  hintText: 'Write your date of Birth',
                  controller: dateofbirthController,
                  onChanged: (e) {
                    setState(() {
                      remainchar = 64 - nameController.text.length;
                    });
                  },
                  remainChar: remainchar.toString(),
                  showchar: false,
                  textWeight: FontWeight.bold,
                ),
                TextFieldWidget(
                  title: 'Gender',
                  hintText: 'Write your gender',
                  controller: dateofbirthController,
                  onChanged: (e) {
                    setState(() {
                      remainchar = 64 - nameController.text.length;
                    });
                  },
                  remainChar: remainchar.toString(),
                  showchar: false,
                  textWeight: FontWeight.bold,
                ),
                Text(
                  'Interest',
                  style: TextStyle(
                    color: CustomTheme.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.all(6),
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Sleeping',
                        style: TextStyle(color: CustomTheme.white),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.all(6),
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Photography',
                        style: TextStyle(color: CustomTheme.white),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.all(6),
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Astrology',
                        style: TextStyle(color: CustomTheme.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
