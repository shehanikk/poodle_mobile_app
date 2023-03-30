import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:poodle_mobie_application/controllers/task_controller.dart';
import 'package:poodle_mobie_application/model/task.dart';
import 'package:poodle_mobie_application/services/notification_services.dart';
import 'package:poodle_mobie_application/sub_pages/add_task.dart';
import 'package:poodle_mobie_application/ui_design/theme.dart';
import 'package:poodle_mobie_application/ui_design/widgets/button.dart';

import '../ui_design/widgets/task_title.dart';

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState(){
    //TODO:implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('Reminder'),
      ),

      body: Column(
        children: [
          _appTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showTasks(),

        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
        child:Obx((){
          return ListView.builder(
            itemCount: _taskController.taskList.length,
              itemBuilder: (_, index){

              Task task = _taskController.taskList[index];
              print(task.toJson());
              if(task.repeat=='Daily'){
                DateTime date = DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper. scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  _showBottomSheet(context, task);
                                },
                                child:TaskTile(task)
                            )
                          ],
                        ),
                      ),
                    ));
              }
              if(task.date==DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: (){
                                  _showBottomSheet(context, task);
                                },
                                child:TaskTile(task)
                            )
                          ],
                        ),
                      ),
                    ));
              }else{
                return Container();
              }

          });
        }),
    );
  }

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
            MediaQuery.of(context).size.height*0.24:
            MediaQuery.of(context).size.height*0.32,
            color:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
            ),
            Spacer(),
            task.isCompleted==1
            ?Container()
                : _bottomSheetButton(
                label: "Vaccination Completed",
                onTap:(){
                  _taskController.markTaskCompleted(task.id!);
                  Get.back();
                },
                clr: Color(0xFF072972),
                context:context,
            ),

            _bottomSheetButton(
              label: "Delete Reminder",
              onTap:(){
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[400]!,
              context:context,
            ),
            SizedBox(height: 20,),
            _bottomSheetButton(
              label: "Close",
              onTap:(){
                Get.back();
              },
              clr: Colors.red[400]!,
              isClose: true,
              context:context,
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),

        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top:20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color(0xFF072972),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
            )
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },

      ),
    );
  }

  _appTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today", style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "Add Reminder", onTap: ()async{
           await Get.to(()=>AddTaskPage());
           _taskController.getTasks();
          }
          )
        ],
      ),
    );
  }
}
