// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:responsivedasboard/component/appBarActionItems.dart';
import 'package:responsivedasboard/component/barChart.dart';
import 'package:responsivedasboard/component/header.dart';
import 'package:responsivedasboard/component/historyTable.dart';
import 'package:responsivedasboard/component/infoCard.dart';
import 'package:responsivedasboard/component/paymentDetailList.dart';
import 'package:responsivedasboard/component/sideMenu.dart';
import 'package:responsivedasboard/config/responsive.dart';
import 'package:responsivedasboard/config/size_config.dart';
import 'package:responsivedasboard/style/colors.dart';
import 'package:responsivedasboard/style/style.dart';

class Dashboard extends StatelessWidget {
  GlobalKey <ScaffoldState> drawerkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key:  drawerkey,
      drawer: SizedBox(width: 100,child: SideMenu(),),
      appBar: !Responsive.isDesktop(context)?AppBar(
        elevation: 0,backgroundColor: AppColors.white,
        leading: IconButton(onPressed: (){
          drawerkey.currentState!.openDrawer();
        },
        icon: Icon(Icons.menu, color: AppColors.black,),),
        actions: [AppBarActionItems(),],
      ): PreferredSize(child: SizedBox(), preferredSize: Size.zero),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Tab
          if(Responsive.isDesktop(context))
          Expanded(flex: 1, child: SideMenu()),

          // Second Tab
          Expanded(
              flex: 10,
              child: Container(
                width: double.infinity,
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          alignment: WrapAlignment.spaceBetween,

                          children: [
                            InfoCard(
                                amount: "\$1200",
                                icon: "assets/credit-card.svg",
                                label: "Transfer via \nCard Number"),
                            InfoCard(
                                amount: "\$150",
                                icon: "assets/transfer.svg",
                                label: "Transfer via \nOnline Bank"),
                            InfoCard(
                                amount: "\$1500",
                                icon: "assets/bank.svg",
                                label: "Transfer via \nSame Bank"),
                            InfoCard(
                                amount: "\$1500",
                                icon: "assets/invoice.svg",
                                label: "Transfer via \nOther Bank"),
                                
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                text: "Balance",
                                size: 16,
                                color: AppColors.secondary,
                              ),
                              PrimaryText(
                                  text: "\$1500",
                                  size: 30,
                                  fontWeight: FontWeight.w800),
                            ],
                          ),
                          PrimaryText(
                            text: "Past 30 Days",
                            size: 16,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 3,
                      ),
                      Container(
                        height: 180,child: BarChartCopmponent(),
                      ), SizedBox(
                        height: SizeConfig.blockSizeVertical! * 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        PrimaryText(
                                text: "History",
                                size: 16,fontWeight: FontWeight.w800
                              ),
                              PrimaryText(
                                  text: "Transaction of last 6 month",
                                  size: 16,
                                color: AppColors.secondary,
                                  ),
                      ],),SizedBox(
                        height: SizeConfig.blockSizeVertical! * 3,
                      
                      ),
                      HistoryTable(),
          if(!Responsive.isDesktop(context))
           PaymentDetailList(),
                    ],
                  ),
                ),
              )),
          // third tab
          if(Responsive.isDesktop(context))
          Expanded(
              flex: 4,
              child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  color: AppColors.secondaryBg,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [AppBarActionItems(), PaymentDetailList()],
                  ))))
        ],
      )),
    );
  }
}
