import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/envelope/widgets/add_transaction_bottomsheet.dart';
import 'package:pocket_pal/screens/envelope/widgets/total_balance_card.dart';
import 'package:pocket_pal/screens/envelope/widgets/transaction_card.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/screens/envelope/graph/envelope_graph.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/envelope_notes.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/services/database_service.dart';
import 'package:pocket_pal/utils/envelope_util.dart';
import 'package:pocket_pal/utils/folder_util.dart';
import 'package:pocket_pal/utils/transaction_structure_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';



class EnvelopeContentPage extends StatefulWidget {
  final Envelope envelope;
  final Folder folder;
  String ? code;

  EnvelopeContentPage({
    Key ? key,
    required this.envelope,
    required this.folder,
    this.code
  }) : super(key : key);

  @override
  State<EnvelopeContentPage> createState() => _EnvelopeContentPageState();
}

class _EnvelopeContentPageState extends State<EnvelopeContentPage> {

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
  late final TextEditingController transactionCategory;
  

  List<dynamic> transactions = [];
  List<dynamic> expenseTransactions = [];
  List<dynamic> incomeTransactions = [];
  List<String> categories = [
      "Food",
      "School",
      "Transport",
      "Grocery",
      "Entertainment",
      "Pets",
      "Travel",
      "Miscellaneous",
  ];

  final Map<String, Color> categoryColorMap = {
    "Food": ColorPalette.crimsonRed,
    "School": ColorPalette.midnightBlue.shade500,
    "Transport": Colors.red.shade200,
    "Grocery": Colors.orange.shade200,
    "Entertainment": Color.fromARGB(255, 216, 195, 89),
    "Pets": Colors.green.shade200,
    "Travel": Colors.blue.shade200,
    "Miscellaneous": Colors.purple.shade200,
  };


   
  @override
  void initState(){
    print(expenseTotal);
    transactionType = TextEditingController(text : "Expense");
    transactionAmount = TextEditingController(text : "");
    transactionName = TextEditingController(text : "");
    transactionCategory = TextEditingController(text : "");
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
    transactionCategory.dispose();
    return; 
  } 

  void addTransaction (String envelopeId) async {
    final data = EnvelopeTransaction(
      transactionCategory: transactionCategory.text.trim(),
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorPalette.crimsonRed,
        foregroundColor: ColorPalette.white,
        elevation: 12,
        onPressed: (){
          showModalBottomSheet(
            context: context, 
            isScrollControlled: true,
            isDismissible: false,
            builder: (context){
              return AddNewTransaction(
                fieldName: widget.envelope.envelopeId,
                formKey: formKey,
                transactionTypeController: transactionType,
                transactionNameController: transactionName,
                transactionAmountController: transactionAmount,
                transactionCategoryController: transactionCategory,
                addTransactionFunction: addTransaction,
                categories: categories,
              );
            });
        },
        child: const Icon(FeatherIcons.plus),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
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
                  return const CircularProgressIndicator();
                }
                final transactions = snapshot.data!['transactions'];
                final expenseTotal = snapshot.data!['expenseTotal'] as double;
                final incomeTotal = snapshot.data!['incomeTotal'] as double;
                final expenseCategoryAmounts = snapshot.data!['expenseCategoryAmounts'] as Map<String,double>;
                final incomeCategoryAmounts = snapshot.data!['incomeCategoryAmounts'] as Map<String,double>;
                print(expenseCategoryAmounts);
                
                for (final transaction in transactions) {
                  final category = transaction['transactionCategory'] as String;
                  if (!categories.contains(category)) {
                    categories.add(category);
                  }
                }
                
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h),
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
                              titleText(
                                widget.envelope.envelopeName,
                                titleSize: 18.sp,
                                titleColor: ColorPalette.white,
                              )
                            ],
                          ),
                      Row(
                        children: [
                          Glassbox(
                            height: 45,
                            width: 45,
                            borderRadius: 30,
                            child: IconButton(
                              icon: Icon(
                                FeatherIcons.pieChart,
                                color: ColorPalette.white,),
                              onPressed: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder : (context) => EnvelopeSummaryPieChart(
                                pageName: widget.envelope.envelopeName,
                                incomeTotal: incomeTotal,
                                expenseTotal: expenseTotal,
                                width: screenWidth,
                                incomedataMap: incomeCategoryAmounts,
                                expensedataMap: expenseCategoryAmounts,
                                categories: categories,
                                categoryColorMap: categoryColorMap,
                                
                              )
                            )
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Glassbox(
                      height: 45,
                      width: 45,
                      borderRadius: 30,
                      child: IconButton(
                      icon: Icon(
                        FeatherIcons.fileText,
                        color: ColorPalette.white,),
                        onPressed: _dashboardNavigateToEnvelopeNotes,
                    ),
                    )
                        ],
                      ),
                    ]
                  ),
                ),
                Positioned(
                  top: 75,
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w ),
                    child: TotalBalanceCard(
                      width: screenWidth,
                      balance: 
                        (transactions == null || transactions.isEmpty) ? 
                        startingBalance.toStringAsFixed(2) : 
                        (startingBalance - expenseTotal + incomeTotal).toStringAsFixed(2),
                      income: incomeTotal.toStringAsFixed(2),
                      expense: expenseTotal.toStringAsFixed(2),

                    ),
                  ),
                ),
                SizedBox.expand(
                  child: DraggableScrollableSheet(
                    minChildSize: 0.55,
                    maxChildSize: 0.95,
                    initialChildSize: 0.55,
                    builder: (context, scrollController){
                    return Container(
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
                      top: 25.h,
                      left: 14.w,
                      right: 14.w
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: titleText(
                              "Recent Transactions",
                              titleSize: 16.sp,
                              titleWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: (transactions == null || transactions.isEmpty) ?
                              Center(
                                child: bodyText(
                                  "No Transactions Yet",
                                  bodySize: 14.sp,
                                ),
                              ) : 
                            (snapshot.hasData) ?
                            ListView.builder (
                              controller: scrollController,
                              itemCount: transactions.length,
                              itemBuilder: ((context, index) {
                                final transaction = transactions[index];
                
                                final transactionName =
                                    transaction['transactionName'] as String;
                                final transactionUsername =
                                    transaction['transactionUsername'] as String;
                                final transactionType =
                                    transaction['transactionType'] as String;
                                final transactionCategory =
                                    transaction['transactionCategory'] as String;
                                final transactionAmount = (transaction['transactionAmount'] as num).toDouble();
                                final transactionDate = transaction['transactionDate'] as Timestamp;
                                final formattedDate = formatter.format(transactionDate.toDate());
                                Color? categoryColor = categoryColorMap[transactionCategory];
                
                                return TransactionCard(
                                      width: screenWidth - 30,
                                      dateCreated: formattedDate,
                                      transactionAmount: transactionAmount.toDouble().toString(),
                                      transactionName: transactionName,
                                      transactionType: transactionType,
                                      transactionCategory: transactionCategory,
                                      categoryColor: categoryColor,
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
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              )
                            ],
                        ),
                      ),
                    );
                  },
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