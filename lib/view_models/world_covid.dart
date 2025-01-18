import 'package:covid_app/services/api_services.dart';
import 'package:covid_app/utils/model_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import '../model/WorldCovidModel.dart';

class WorldCovid extends StatefulWidget {
  const WorldCovid({super.key});

  @override
  State<WorldCovid> createState() => _WorldCovidState();
}

class _WorldCovidState extends State<WorldCovid> {
  ApiServices _apiServices=ApiServices();
String selected='Global';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new_sharp),
        title: ModelText(text: 'Statistics', size: 20.sp),
      ),
      body: Column(
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             GestureDetector(
               onTap: (){
                 setState(() {
                   selected ='Global';
                 });
               },
               child: Container(
                 height: 60.h,
                 width: 100.w,
                 decoration: BoxDecoration(
                     color:  selected=='Global'? Colors.blue:Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   border: Border.all(
                     color:selected=='Global'? Colors.blue:Colors.black,
                   ),
                 ),
                 child: Center(child: ModelText(text: 'Global', size: 16.sp)),
               ),
             ),
             SizedBox(
               width: 10.w,
             ),
             GestureDetector(
               onTap: (){
                 setState(() {
                   selected ='Country';
                 });
               },
               child: Container(
                 height: 60.h,
                 width: 100.w,
                 decoration: BoxDecoration(
                   color:  selected=='Country'? Colors.blue:Colors.white,
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(
                     color:selected=='Country'? Colors.blue:Colors.black,
                   ),
                 ),
                 child: Center(child: ModelText(text: 'Country', size: 16.sp)),
               ),
             ),

           ],
         ),

          Center(
            child:selected=='Global'?
            FutureBuilder(
                future: _apiServices.worldCovid(),
                builder: (context,AsyncSnapshot<WorldCovidModel>snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 120.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color:   Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue,
                              ),
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ModelText(text: 'Cases', size: 16.sp),
                                    ModelText(text: snapshot.data!.cases.toString(), size: 16.sp),
                                  ],
                                )),
                          ),
                          SizedBox(width: 15.w,),
                          Container(
                            height: 120.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color:   Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.red,
                              ),
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ModelText(text: 'Deaths', size: 16.sp),
                                ModelText(text: snapshot.data!.deaths.toString(), size: 16.sp),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120.h,
                      child: ListView(
                        padding: EdgeInsets.all(10.r),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color:   Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ModelText(text: 'Recovered', size: 16.sp),
                                    ModelText(text: snapshot.data!.recovered.toString(), size: 16.sp),
                                  ],
                                )),
                          ),
                          SizedBox(width: 5.w,),
                          Container(
                            height: 80.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:Colors.white,
                              ),
                            ),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ModelText(text: 'Active', size: 16.sp),
                                    ModelText(text: snapshot.data!.active.toString(), size: 16.sp),
                                  ],
                                )),
                          ),
                          SizedBox(width: 5.w,),
                          Container(
                            height: 80.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ModelText(text: 'Critical', size: 16.sp),
                                    ModelText(text: snapshot.data!.critical.toString(), size: 16.sp),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    PieChart(
                      dataMap: {
                        'Active per(M)':snapshot.data!.activePerOneMillion!.toDouble(),
                        'Recovered per(M)':snapshot.data!.recoveredPerOneMillion!.toDouble(),
                        'Critical per(M)':snapshot.data!.criticalPerOneMillion!.toDouble(),
                        'Death per(M)':snapshot.data!.deathsPerOneMillion!.toDouble(),
                        'Test per(M)':snapshot.data!.testsPerOneMillion!.toDouble(),
                      },
                    )
                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }):
            Text('afdgf'),)
        ],
      ),
    );
  }
}
