import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class DonationDetailsPage extends StatefulWidget {
  final Map<String, dynamic> donation;

  const DonationDetailsPage({Key? key, required this.donation}) : super(key: key);


  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('DONATION DETAILS'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              child: Image.network(widget.donation['imgUrl']),
            ),
          ),
          SizedBox(height: 28),
          Text("Dog Name: ${widget.donation['dogName']}", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 25),
          Text("Health State: ${widget.donation['healthState']}", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 35),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("${widget.donation['dogDescription']}", textAlign: TextAlign.justify, style: TextStyle(
              fontSize: 20,

            ),),
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckout(
                  sandboxMode: true,
                  clientId: "AYKDthWwV7TJ1bvKFHLhyqLWKVhyjMvmZvB2OKzKfGAPfO9-r747e0KMgEtxR2vwc_rlckt6Odz-iR-O",
                  secretKey: "EBp9A20Hspo5tdK1GBwaw22atS9MwbyNdbewuDCouVjraGhjGEIZElZKAnz-K6_dySAQrQOmDMvds5S7",
                  returnURL: "success.snippetcoder.com",
                  cancelURL: "cancel.snippetcoder.com",
                  transactions: const [
                    {
                      "amount": {
                        "total": '70',
                        "currency": "USD",
                        "details": {
                          "subtotal": '70',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": '5',
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 5,
                            "price": '10',
                            "currency": "USD"
                          }
                        ],

                        // shipping address is not required though
                        //   "shipping_address": {
                        //     "recipient_name": "Raman Singh",
                        //     "line1": "Delhi",
                        //     "line2": "",
                        //     "city": "Delhi",
                        //     "country_code": "IN",
                        //     "postal_code": "11001",
                        //     "phone": "+00000000",
                        //     "state": "Texas"
                        //  },
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                  },
                  onError: (error) {
                    print("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                  },
                ),
              ));

            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(1),
                ),
              ),
            ),
            child: Text('Pay with PayPal'),
          ),

        ],
      ),
    );
  }
}
