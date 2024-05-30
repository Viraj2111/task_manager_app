import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';
import 'package:task_manager/common/widget/common_%20button.dart';
import 'package:task_manager/constant/app_colors.dart';
import 'package:task_manager/constant/app_style.dart';
import 'package:task_manager/constant/static_decoration.dart';
import 'package:task_manager/helper/responsive.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/view/tasksScreen.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: buttonColor,
        body: Responsive.isMobile(context)
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                        flex: 7,
                        child:
                            Image.asset("assets/icon/png/boardingVector.png")),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Task Management",
                              style: AppTextStyle.normalSemiBold25,
                            ),
                            height05,
                            Text(
                              "Task management involves organizing, prioritizing, and tracking tasks to ensure efficient completion of work, enhancing productivity and meeting deadlines",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.normalRegularBold15,
                            ),
                            height10,
                            CommonButton(
                              color: Colors.white,
                              textColor: buttonColor,
                              title: "Explore The App",
                              onTap: () async {
                                await storage.write("isRead", true);
                                Get.offAll(() => const TaskScreen());
                              },
                            )
                          ],
                        ))
                  ],
                ),
              )
            : Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(150),
                        child:
                            Image.asset("assets/icon/png/boardingVector.png"),
                      )),
                  Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                        child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Task Management",
                                  style: AppTextStyle.normalSemiBold25
                                      .copyWith(color: buttonColor),
                                ),
                                height05,
                                Text(
                                  "Task management involves organizing, prioritizing, and tracking tasks to ensure efficient completion of work, enhancing productivity and meeting deadlines",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.normalRegularBold15
                                      .copyWith(color: buttonColor),
                                ),
                                height10,
                                CommonButton(
                                  color: buttonColor,
                                  textColor: appWhiteColor,
                                  title: "Explore The App",
                                  onTap: () async {
                                    await storage.write("isRead", true);
                                    Get.offAll(() => const TaskScreen());
                                  },
                                )
                              ],
                            )
                          
                      )),
                ],
              ));
  }
}
