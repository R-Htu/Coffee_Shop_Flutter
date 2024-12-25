import 'dart:convert'; // Import for json encoding/decoding
import 'dart:js_interop';
import 'package:coffeeshop/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http; // Import for HTTP requests
import 'package:coffeeshop/model/payment_tile.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text,
          currency: selectedCurrency,
          amount: amountController.text);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Testing',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          // Extra options
          /*applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),*/
          style: ThemeMode.dark,
        ),
      );
      //setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                    if (formkey.currentState!.validate() &&
                        formkey1.currentState!.validate() &&
                        formkey2.currentState!.validate() &&
                        formkey3.currentState!.validate() &&
                        formkey4.currentState!.validate() &&
                        formkey5.currentState!.validate() &&
                        formkey6.currentState!.validate()) {}
                    /*  if (formkey.currentState?.validate() ?? false) {
                      String email = nameController.text.trim(); // Get the email
                      String amount =
                          amountController.text.trim(); // Get the amount entered
      
                      // Send HTTP request to the Firebase Emulator URL
                      try {
                        final response = await http.post(
                          Uri.parse(
                              'http://127.0.0.1:5001/coffeeshop-e6f92/us-central1/stripePaymentIntentRequest'), // Local emulator URL
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: json.encode({
                            'email': email,
                            'amount': amount,
                          }),
                        );
      
                        if (response.statusCode == 200) {
                          final data = json.decode(response.body);
      
                          if (data['success']) {
                            // Proceed with the next step (e.g., handle the payment intent)
                            String clientSecret = data['paymentIntent'];
                            String ephemeralKey = data['ephemeralKey'];
                            String customerId = data['customer'];
      
                            // Now, you can pass these values to the Stripe SDK or any payment gateway SDK for further steps
                            print('Client Secret: $clientSecret');
                            print('Ephemeral Key: $ephemeralKey');
                            print('Customer ID: $customerId');
      
                            // Redirect to payment page or handle payment process
                          } else {
                            print('Error: ${data['error']}');
                          }
                        } else {
                          print(
                              'Request failed with status: ${response.statusCode}');
                        }
                      } catch (e) {
                        print('Error: $e');
                      }
                    }
                */
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
