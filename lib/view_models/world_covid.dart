import 'package:covid_app/services/api_services.dart';
import 'package:covid_app/utils/model_text.dart';
import 'package:covid_app/utils/reuseable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import '../model/CountryModel.dart';
import '../model/WorldCovidModel.dart';

class WorldCovid extends StatefulWidget {
  const WorldCovid({super.key});

  @override
  State<WorldCovid> createState() => _WorldCovidState();
}

class _WorldCovidState extends State<WorldCovid> {
  int selectedIndex=0;
  ApiServices _apiServices=ApiServices();
   String selected='Global';
   List<CountryModel>_countryList=[ ];
   fetchCountrycovid(){
     _apiServices.countryCovid().then((onValue){
       _countryList=onValue;
     }).onError((error,strackTrace){
       debugPrint(error.toString());
     });
   }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountrycovid();
  }

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
                          ReuseableContainer(
                              height: 120.h,
                              weight: 150.w,
                              text1: 'Cases',
                              size:  16.sp,
                            text2: snapshot.data!.cases.toString(),
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15.w,),
                          ReuseableContainer(
                            height: 120.h,
                            weight: 150.w,
                            text1: 'Deaths',
                            size:  16.sp,
                            text2: snapshot.data!.deaths.toString(),
                            color: Colors.red,
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
                          ReuseableContainer(
                            height: 80.h,
                            weight: 100.w,
                            text1: 'Recovered',
                            size:  16.sp,
                            text2: snapshot.data!.recovered.toString(),
                            color: Colors.white,
                          ),

                          SizedBox(width: 5.w,),
                          ReuseableContainer(
                            height: 80.h,
                            weight: 100.w,
                            text1: 'Active',
                            size:  16.sp,
                            text2: snapshot.data!.active.toString(),
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.w,),
                          ReuseableContainer(
                            height: 80.h,
                            weight: 100.w,
                            text1: 'Critical',
                            size:  16.sp,
                            text2: snapshot.data!.critical.toString(),
                            color: Colors.white,
                          ),

                        ],
                      ),
                    ),
                    PieChart(
                      dataMap: {
                        'Active per(M)':snapshot.data!.activePerOneMillion!.toDouble(),
                        'Recovered per(M)':snapshot.data!.recoveredPerOneMillion!.toDouble(),
                       // 'Test per(M)':snapshot.data!.testsPerOneMillion!.toDouble(),
                      },
                    )
                  ],
                );
              }else{
                return Column(

                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    LinearProgressIndicator(),
                  ],
                );
              }
            }):
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _countryList.length,
                          itemBuilder: (context,index){
                          final country=_countryList[index];
                            return GestureDetector(
                              onTap: (){
                              setState(() {
                                selectedIndex=index;
                              });
                              },
                              child: Card(
                                color:selectedIndex== index ? Colors.orangeAccent:Colors.white,
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(8.0),
                                      child: ModelText(text: country.country.toString(), size: 14.sp),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 20.w,right: 12.w,top: 10.h),
                      child: Row(
                        children: [
                          ReuseableContainer(
                            height: 120.h,
                            weight: 150.w,
                            text1: 'Cases',
                            size:  16.sp,
                            text2: _countryList[selectedIndex].cases.toString(),
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15.w,),
                          ReuseableContainer(
                              height: 120.h,
                              weight: 150.w,
                              text1: 'Deaths',
                              size:  16.sp,
                              text2: _countryList[selectedIndex].deaths.toString(),
                            color: Colors.red,
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
                          ReuseableContainer(
                              height: 80.h,
                              weight: 100.w,
                              text1: 'Recovered',
                              size:  16.sp,
                              text2: _countryList[selectedIndex].recovered.toString(),
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.w,),
                          ReuseableContainer(
                              height: 80.h,
                              weight: 100.w,
                              text1: 'Active',
                              size:  16.sp,
                              text2: _countryList[selectedIndex].active.toString(),
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.w,),
                          ReuseableContainer(
                              height: 80.h,
                              weight: 100.w,
                              text1: 'Critical',
                              size:  16.sp,
                              text2: _countryList[selectedIndex].critical.toString(),
                            color: Colors.white,
                          ),

                        ],
                      ),
                    ),
                    PieChart(
                      dataMap: {
                        'Active per(M)':_countryList[0].activePerOneMillion!.toDouble(),
                        'Recovered per(M)':_countryList[0].recoveredPerOneMillion!.toDouble(),


                        // 'Test per(M)':snapshot.data!.testsPerOneMillion!.toDouble(),
                      },
                    )



                  ],

                ),

              ],
            )

          )
        ],
      ),
    );
  }
}
