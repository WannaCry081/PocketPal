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
  int expenseTotal = 0;
  int incomeTotal = 0;
  int totalBalance = 0;

  final auth = PocketPalAuthentication();
  final userUid = PocketPalAuthentication().getUserUID;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('MMM dd');
  
  late final TextEditingController transactionType;
  late final TextEditingController transactionAmount;
  late final TextEditingController transactionName;

  List<dynamic> transactions = [];
  List<dynamic> expenseTransactions = [];


  @override
  void initState(){
    super.initState();
    print(auth.getUserDisplayName);
    //fetchTransactions();
    fetchData(
      widget.folder.folderId,
      widget.envelope.envelopeId
    );
    //getEnvelopeData();
    transactionType = TextEditingController(text : "Expense");
    transactionAmount = TextEditingController(text : "");
    transactionName = TextEditingController(text : "");
    return; 
  }

  Future<void> fetchTransactions(
    String docName,
    String envelopeName
  ) async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.
        collection(userUid)
        .doc(docName)
        .collection('$docName+Envelope')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final List<dynamic> allData = [];

      for (final QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        //String id = docSnapshot.id;
        //print('Document ID: $id');
        //allData.add(id);
        final Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic>? envelopeData = data['envelopTransaction'] as List<dynamic>?;
        if (envelopeData != null){
          for (final Map<String, dynamic> transactionData in envelopeData) {
          //allData.add(transactionData);
          allData.add(transactionData);
          for (final transaction in envelopeData){
            if (transaction['transactionType'] == 'Expense') {
               final int expense = transactionData['transactionAmount'];
                expenseTotal += expense;
            }   
            if (transaction['transactionType'] == 'Income') {
               final int income = transactionData['transactionAmount'];
                incomeTotal += income;
            } 
            totalBalance = incomeTotal - expenseTotal;  
          }
        }
      }
      }
      transactions = allData;
      print(transactions);
      setState(() {});
  }
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
      transactionAmount: int.parse(transactionAmount.text.trim()),
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

  Future<void> fetchData(String docName, String envelopeName) async {
  final userUid = PocketPalAuthentication().getUserUID;
  FirebaseFirestore.instance
      .collection(userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {

    if (querySnapshot.docs.isNotEmpty) {
      List<int> expenseList = [];
      List<dynamic> envelopTransactionList = [];
      querySnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('envelopTransaction')) {
          List<dynamic> getTransactions = data['envelopTransaction'];
          envelopTransactionList.addAll(data['envelopTransaction']);
          transactions = envelopTransactionList;
          //print(transactions);

          for (var transaction in getTransactions){
            final transactionType = transaction['transactionType'] as String?;
             final transactionAmount = transaction['transactionAmount'] as int?;
             if (transactionType == 'expense' && transactionAmount != null) {
              expenseList.add(transactionAmount);
              print(expenseList);
            }
          }

        }
      });
     //print('envelopTransaction list: $envelopTransactionList');
    } else {
      print('Collection does not exist or is empty');
    }
  });
}


  




Future<Map<String, dynamic>> getEnvelopeData(
    String docName, 
    String envelopeName
    ) async {
  final envelopeRef = FirebaseFirestore.instance
      .collection(userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName);

  final List<dynamic> allData = [];
  final List<double> expenseNumbers = [];
  final List<double> incomeNumbers = [];

  final envelopeDoc = await envelopeRef.get();
  final envelopeData = (await envelopeRef.get()).data() as Map<String, dynamic>?;

  if (envelopeDoc.exists && envelopeData != null) {
    
    allData.add(envelopeData);
    transactions = allData;
    print(transactions);
    // final envelopeTransactions = envelopeData['Envelope Name'] as List<dynamic>;
    // for (final transaction in envelopeTransactions) {
    //   if (transaction['transactionType'] == 'Expense') {
    //     expenseNumbers.add(transaction['transactionAmount']);
    //   }
    //   if (transaction['transactionType'] == 'Income'){
    //     incomeNumbers.add(transaction['transactionAmount']);
    //   }
    // }
    // expenseTotal = expenseNumbers.fold(0, (sum, amount) => sum + amount);
    // incomeTotal = incomeNumbers.fold(0, (sum, amount) => sum + amount);
    // expenseData = expenseNumbers;
    //print(expenseData);

    return envelopeData;
  } else {
    throw Exception('Envelope document does not exist');
  }
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
        decoration: BoxDecoration(
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
                          "Envelope Name",
                          style: GoogleFonts.poppins(
                            fontSize : 18.sp,
                            color: ColorPalette.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w ),
                  child: TotalBalanceCard(
                    width: screenWidth, 
                    balance: totalBalance.toStringAsFixed(2),),
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
                              child: CircularProgressIndicator(),
                            )
                            :ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (context, index){
                                final transaction = transactions[index];
                                final transactionName =
                                    transaction['transactionName'] as String;
                                final transactionUsername =
                                    transaction['transactionUserName'] as String?;
                                final transactionType =
                                    transaction['transactionType'] as String;
                                final transactionAmount =
                                    transaction['transactionAmount'] as int;
                                final transactionDate =
                                    transaction['transactionDate'] as Timestamp;
                                final formattedDate = formatter.format(transactionDate.toDate());
                    
                                return  
                                    TransactionCard(
                                      width: screenWidth - 30,
                                      dateCreated: formattedDate,
                                      transactionAmount: transactionAmount.toDouble().toString(),
                                      transactionName: transactionName,
                                      transactionType: transactionType,
                                      transactionUsername: transactionUsername.toString()
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