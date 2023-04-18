import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/dashboard/widgets/envelope_widget.dart';
import 'package:pocket_pal/screens/envelope/widgets/money_flow_card.dart';
import 'package:pocket_pal/screens/envelope/widgets/new_transaction_dialog.dart';
import 'package:pocket_pal/screens/envelope/widgets/total_balance_card.dart';
import 'package:pocket_pal/screens/envelope/widgets/transaction_card.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/screens/graph/envelope_graph.dart';
import 'package:pocket_pal/screens/envelope%20notes/envelope_notes.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/services/database_service.dart';
import 'package:pocket_pal/utils/envelope_structure_util.dart';
import 'package:pocket_pal/utils/folder_structure_util.dart';
import 'package:pocket_pal/utils/transaction_structure_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class EnvelopeContentPage extends StatefulWidget {
  final Envelope envelope;
  final Folder folder;

  const EnvelopeContentPage({
    required this.envelope,
    required this.folder,
    super.key});

  @override
  State<EnvelopeContentPage> createState() => _EnvelopeContentPageState();
}

class _EnvelopeContentPageState extends State<EnvelopeContentPage> {

  bool isIncome = false;
  double expenseTotal = 0;
  double incomeTotal = 0;
  double totalBalance = 0;
  late double startingBalance;

  final db = PocketPalDatabase();

  final auth = PocketPalAuthentication();
  final userUid = PocketPalAuthentication().getUserUID;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('MMM dd');
  
  late final TextEditingController transactionType;
  late final TextEditingController transactionAmount;
  late final TextEditingController transactionName;

  List<dynamic> transactions = [];
  List<dynamic> expenseTransactions = [];
  List<dynamic> incomeTransactions = [];


  @override
  void initState(){
    transactionType = TextEditingController(text : "Expense");
    transactionAmount = TextEditingController(text : "");
    transactionName = TextEditingController(text : "");
    totalBalance = widget.envelope.envelopeStartingAmount;
    startingBalance = widget.envelope.envelopeStartingAmount;
    super.initState();
    return; 
  }


  @override
  void dispose(){
    super.dispose();
    transactionType.dispose();
    transactionAmount.dispose();
    transactionName.dispose();
    return; 
  } 

  void addTransaction (String envelopeId) async {
    final data = EnvelopeTransaction(
      transactionName: transactionName.text.trim(), 
      transactionUsername: auth.getUserDisplayName,
      transactionType: transactionType.text.trim(), 
      transactionAmount: double.parse(transactionAmount.text.trim()),
      ).toMap();

      PocketPalDatabase().createEnvelopeTransaction(
        widget.folder.folderId,
        widget.envelope.envelopeId,
        data
      ); 

      Navigator.of(context).pop();
      clearController();
  }


  void newTransaction(){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context){
        return MyNewTransactionDialogWidget(
          fieldName: widget.envelope.envelopeId,
          formKey: formKey,
          transactionTypeController: transactionType,
          transactionNameController: transactionName,
          transactionAmountController: transactionAmount,
          addTransactionFunction: addTransaction,
          isIncome: false,
        );
      });
  }

  void clearController(){
    transactionType.clear();
    transactionAmount.clear();
    transactionName.clear();
    return;
  }

  void _dashboardNavigateToEnvelopeNotes(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => EnvelopeNotesPage(
          folder: widget.folder,
          envelope: widget.envelope,
        )
      )
    );
    return;
  }
  
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      backgroundColor: ColorPalette.rustic,
      foregroundColor: ColorPalette.white,
      elevation: 12,
      onPressed: newTransaction,
      child: const Icon(FeatherIcons.plus),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/envelope_bg.png",
            ),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child: Center(
            child: StreamBuilder<Map<String, dynamic>>(
              stream: db.getEnvelopeTransactions(
                    widget.folder.folderId, 
                    widget.envelope.envelopeId),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                final transactions = snapshot.data!['transactions'];
                final expenseTotal = snapshot.data!['expenseTotal'] as double;
                final incomeTotal = snapshot.data!['incomeTotal'] as double;

                print(incomeTotal);
                print(expenseTotal);
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(FeatherIcons.arrowLeft,
                                  size: 28,
                                  color: ColorPalette.white,),
                              ),
                              SizedBox( width: 10.h,),
                              Text(
                                widget.envelope.envelopeName,
                                style: GoogleFonts.poppins(
                                  fontSize : 18.sp,
                                  color: ColorPalette.white,
                                ),
                              )
                            ],
                          ),

                          GestureDetector(
                            onTap: _dashboardNavigateToEnvelopeNotes,
                            child: Text(
                              "Add Note",
                              style: GoogleFonts.poppins(
                                fontSize : 16.sp,
                                color: ColorPalette.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                          ]
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                         horizontal: 14.w ),
                      child: TotalBalanceCard(
                            width: screenWidth,
                            //balance: totalBalance.toStringAsFixed(2),
                            balance: 
                               (transactions == null || transactions.isEmpty) ? 
                               startingBalance.toStringAsFixed(2) : 
                                (startingBalance - expenseTotal + incomeTotal).toStringAsFixed(2),
                      ),
                    ),
                    SizedBox( height: 12.h,),
                    Padding(
                      padding: EdgeInsets.only( right: 14.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder : (context) => EnvelopeSummaryPieChart(
                                pageName: widget.envelope.envelopeName,
                                incomeTotal: incomeTotal,
                                expenseTotal: expenseTotal,
                                width: screenWidth,
                                
                              )
                            )
                          );
                          },
                          child: Text(
                            "View Summary",
                            style: GoogleFonts.poppins(
                              shadows: [
                                const Shadow(
                                  offset: Offset(0, -5), 
                                  color: Colors.white
                                  )],
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 2,
                              fontSize: 14.sp,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                      ),
                    ),
                SizedBox( height: 15.h,),
                Expanded(
                  child: Container(
                    width: screenWidth,
                     decoration: const BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                       )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        left: 14,
                        right: 14
                        ),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text(
                                  "Recent Transactions",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w600
                                  )
                                ),
                                Text(
                                  "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.grey
                                  )
                                ),
                              ]
                            ),
                            SizedBox( height: screenHeight * 0.02,),

                            Expanded(
                              child: (transactions == null || transactions.isEmpty) ?
                                Center(
                                  child: Text(
                                    "No Transactions Yet",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp
                                    ),
                                  ),
                                )
                              : 
                              (snapshot.hasData) ?
                              ListView.builder (
                                itemCount: transactions.length,
                                itemBuilder: ((context, index) {
                                  final transaction = transactions[index];

                                  final transactionName =
                                      transaction['transactionName'] as String;
                                  final transactionUsername =
                                      transaction['transactionUsername'] as String;
                                  final transactionType =
                                      transaction['transactionType'] as String;
                                  final transactionAmount = (transaction['transactionAmount'] as num).toDouble();
                                  final transactionDate = transaction['transactionDate'] as Timestamp;
                                  final formattedDate = formatter.format(transactionDate.toDate());

                                  return TransactionCard(
                                        width: screenWidth - 30,
                                        dateCreated: formattedDate,
                                        transactionAmount: transactionAmount.toDouble().toString(),
                                        transactionName: transactionName,
                                        transactionType: transactionType,
                                        transactionUsername: transactionUsername,
                                        onPressedDelete: (BuildContext context) async{
                                          db.deleteEnvelopeTransaction(
                                            widget.folder.folderId, 
                                            widget.envelope.envelopeId,
                                            index);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Successfully Deleted!"),
                                                  duration: Duration(seconds: 1),));
                                        },
                                        );
                                    }),
                                  )
                                  :
                                  const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                )
                              ],
                            ),
                          ),
                        )
                      )
                  ],
                );
              }
            )
              
          ),
        ),
        
      )
    );
  }

}