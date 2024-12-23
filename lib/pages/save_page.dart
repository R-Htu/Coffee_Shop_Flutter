import 'package:coffeeshop/model/payment_tile.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
        backgroundColor: Colors.blueAccent.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body
        child: SingleChildScrollView(
          // Enables scrolling for smaller screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image of the cafe
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Image.asset(
                  'lib/images/cafe.png', // Correct path to image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Heading Text
              Text(
                'Testing the payment system',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Amount and Currency Dropdown
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PaymentTile(
                        title: 'Your Amount',
                        hint: 'Any amount you can',
                        isNumber: true,
                        controller: amountController,
                        formkey: formkey),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: DropdownMenu<String>(
                      inputDecorationTheme: InputDecorationTheme(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600),
                        ),
                      ),
                      initialSelection: currencyList.first,
                      onSelected: (String? value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                      dropdownMenuEntries: currencyList
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Name Field
              PaymentTile(
                  title: 'Name',
                  hint: 'Eg. Miss',
                  isNumber: false,
                  controller: nameController,
                  formkey: formkey1),
              const SizedBox(height: 10),

              // Address Fields
              PaymentTile(
                  title: 'Address Line 1',
                  hint: 'Eg. Rose',
                  isNumber: false,
                  controller: addressController,
                  formkey: formkey2),
              const SizedBox(height: 10),
              PaymentTile(
                  title: 'Address Line 2',
                  hint: 'Eg. Park Street',
                  isNumber: false,
                  controller: addressController,
                  formkey: formkey3),
              const SizedBox(height: 10),

              // City, State, Country, and Pincode
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: PaymentTile(
                      isNumber: false,
                      formkey: formkey3,
                      title: "City",
                      hint: "Ex. New Delhi",
                      controller: cityController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: PaymentTile(
                      isNumber: false,
                      formkey: formkey4,
                      title: "State (Short code)",
                      hint: "Ex. DL for Delhi",
                      controller: stateController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: PaymentTile(
                      isNumber: false,
                      formkey: formkey5,
                      title: "Country (Short Code)",
                      hint: "Ex. IN for India",
                      controller: countryController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: PaymentTile(
                      formkey: formkey6,
                      title: "Pincode",
                      hint: "Ex. 123456",
                      controller: pincodeController,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Proceed to Pay Button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade400,
                  ),
                  child: const Text(
                    "Proceed to Pay",
                    style: TextStyle(
                        color: Color.fromARGB(255, 191, 6, 6), fontSize: 16),
                  ),
                  onPressed: () async {
                    // Add your onPressed action here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
