import 'package:flutter/material.dart';
import 'package:pnr_status/widget/ui_helper.dart';
import 'package:pnr_status/screens/legendsscreen.dart';
class PnrStatusScreen extends StatelessWidget {
  final Map<String, dynamic> pnrStatus;

  PnrStatusScreen({required this.pnrStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PNR Status Result")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    height: 50,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amberAccent,
                    ),
                    child: Text("PNR Number: ${pnrStatus['pnrNumber']}",
                        style: TextStyle(fontSize: 18))),
              ),
              SizedBox(
                height: 20,
              ),
              UiHelper.CustomText(
                  txt:
                      "Train: ${pnrStatus['trainName']} (${pnrStatus['trainNumber']})"),
              UiHelper.CustomText(
                  txt: "Journey Date: ${pnrStatus['dateOfJourney']}"),
              UiHelper.CustomText(txt: "Source: ${pnrStatus['sourceStation']}"),
              UiHelper.CustomText(
                  txt: "Destination: ${pnrStatus['destinationStation']}"),
              UiHelper.CustomText(txt: "Class: ${pnrStatus['journeyClass']}"),
              UiHelper.CustomText(
                  txt: "Chart Status: ${pnrStatus['chartStatus']}"),
              UiHelper.CustomText(
                  txt: "Ticket Base Price: \u20B9${pnrStatus['ticketFare']}"),
              SizedBox(height: 10),
              if (pnrStatus['chartStatus'] == "Chart Not Prepared")
                Text(
                  "Please Note that in case the Final Charts have not been prepared, the Current Status might upgrade/downgrade at a later stage.",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                )
              else
                SizedBox(), // Return an empty widget if the condition is false
              SizedBox(height: 10),
              Text("Passengers:", style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              ...List.generate(
                (pnrStatus['passengerList'] as List).length,
                (index) {
                  var passenger = pnrStatus['passengerList'][index];
                  return Card(
                    child: ListTile(
                      title: Text(
                          "Passenger ${passenger['passengerSerialNumber']}"),
                      subtitle: Text(
                          "Booking: ${passenger['bookingStatusDetails']}\nCurrent: ${passenger['currentStatusDetails']}"),
                    ),
                  );
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white, // Text color
                ),
                onPressed: () {
                  // Navigate to a screen with more details or a FAQ
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LegendDetailsScreen()));
                },
                child: Text('Tap here to know the meanings', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
