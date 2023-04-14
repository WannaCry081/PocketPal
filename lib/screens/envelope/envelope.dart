import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/widgets/money_flow_card.dart';
import 'package:pocket_pal/screens/envelope/widgets/new_transaction_dialog.dart';
import 'package:pocket_pal/screens/envelope/widgets/total_balance_card.dart';
import 'package:pocket_pal/screens/envelope/widgets/transaction_card.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/screens/notes/envelope_notes.dart';
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

  final _balanceController = StreamController<double>.broadcast();


  @override
  void initState(){
    fetchData(
      widget.folder.folderId,
      widget.envelope.envelopeId
    );
    //getEnvelopeData();
    transactionType = TextEditingController(text : "Expense");
    transactionAmount = TextEditingController(text : "");
    transactionName = TextEditingController(text : "");
    totalBalance = widget.envelope.envelopeStartingAmount;
    startingBalance = widget.envelope.envelopeStartingAmount;
    _balanceController.add(totalBalance);
    super.initState();
    return; 
  }


  @override
  void dispose(){
    super.dispose();
    transactionType.dispose();
    transactionAmount.dispose();
    transactionName.dispose();
    fetchData( widget.folder.folderId,
      widget.envelope.envelopeId);
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

void deleteValueFromEnvelopeTransaction(
  String docName, 
  String envelopeName, 
  int indexToRemove, 
  List<dynamic> envelopeTransactionList, 
  Function setStateCallback) async {

  final documentReference = FirebaseFirestore.instance
    .collection(userUid)
    .doc(docName)
    .collection("$docName+Envelope")
    .doc(envelopeName);
  final documentSnapshot = await documentReference.get();
  final data = documentSnapshot.data() as Map<String, dynamic>?;
  if (data != null && data.containsKey('envelopeTransaction')) {
    List<dynamic> envelopeTransaction = data['envelopeTransaction'];
    if (envelopeTransaction.length > indexToRemove) {
      envelopeTransaction.removeAt(indexToRemove);
      await documentReference.update({
        'envelopeTransaction': FieldValue.delete(),
      });
      await documentReference.update({
        'envelopeTransaction': FieldValue.arrayUnion(envelopeTransaction),
      });
      envelopeTransactionList.removeAt(indexToRemove); // remove from UI list
      setStateCallback(); // call setState to update the UI
    }
  }
}




Future<void> fetchData(String docName, String envelopeName) async {
  final userUid = PocketPalAuthentication().getUserUID;
  double expenseTotal = 0;
  double incomeTotal = 0;

  FirebaseFirestore.instance
      .collection(userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName)
      .snapshots()
      .listen((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data() as Map<String, dynamic>;
          List<double> expenseList = [];
          List<double> incomeList = [];
          List<dynamic> allData = [];

          double _expenses = 0;
          double _income = 0;

          if (data.containsKey('envelopeTransaction')) {
            final List<dynamic>? envelopeData = data['envelopeTransaction'] as List<dynamic>?;
            if (envelopeData != null) {
              for (final Map<String, dynamic> transactionData in envelopeData){
                allData.add(transactionData);
                if (transactionData['transactionType'] == "Expense") {
                  final double expense = transactionData['transactionAmount'];
                  expenseList.add(expense);
                  _expenses += expense;
                  expenseTotal = _expenses;
                }
                if (transactionData['transactionType'] == "Income") {
                  final double income = transactionData['transactionAmount'];
                  _income += income;
                  incomeTotal = _income;
                }
              }
              totalBalance = startingBalance - expenseTotal + incomeTotal;
            }
          }
          transactions = allData;
          expenseTransactions =  expenseList;
          incomeTransactions = incomeList;

          // print("Expense List Total: $expenseTotal");
          // print("Income List Total: $incomeTotal");
          // print(transactions);
          setState(() {});
        } else {
          print('Document does not exist');
        }
      });
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
      child: Icon(FeatherIcons.plus),
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
            child: Column(
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
                      
                        
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w ),
                  child: StreamBuilder<double>(
                    stream: _balanceController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                          totalBalance = snapshot.data!;
                        } 
                        return TotalBalanceCard(
                          width: screenWidth,
                          balance: totalBalance.toStringAsFixed(2),
                        );
                    }
                  ),
                ),
                SizedBox( height: 12.h,),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 14.w),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       MoneyFlowCard(
                //         name: "Income",
                //         width: (screenWidth / 2) - 20,
                //         amount: incomeTotal.toStringAsFixed(2), 
                //         iconColor: Colors.green.shade700,
                //         icon: FeatherIcons.arrowDown,
                //        ),
                //       MoneyFlowCard(
                //         name: "Expense",
                //         width: (screenWidth / 2) - 20,
                //         amount: expenseTotal.toStringAsFixed(2), 
                //         iconColor: Colors.red.shade700,
                //         icon: FeatherIcons.arrowUp,
                //         ),
                //     ],
                //   ),
                // ),
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
                            child: transactions.isEmpty
                            ? Center(
                              child: Text(
                                "No Transactions Yet",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp
                                ),
                                ),
                            )
                            : ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (context, index){
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
                    
                                return  
                                    TransactionCard(
                                      width: screenWidth - 30,
                                      dateCreated: formattedDate,
                                      transactionAmount: transactionAmount.toDouble().toString(),
                                      transactionName: transactionName,
                                      transactionType: transactionType,
                                      transactionUsername: transactionUsername ,
                                      onPressed: (BuildContext context) async{
                                        deleteValueFromEnvelopeTransaction(
                                          widget.folder.folderId, 
                                          widget.envelope.envelopeId, 
                                          index, 
                                          transactions, 
                                          (){
                                            setState(() { });
                                          }
                                      );

                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(
                                        //     content: Text("Successfully Deleted!"),
                                        //     duration: Duration(seconds: 1),));
                                        // startingBalance = 0;
                                      },
                                      );
                                  
                              }),
                          ),
                          
                        ],
                      ),
            
                    )
                     
                  )
                  ),
              ],
            ),
              
          ),
        ),
        
      )
    );
  }
}