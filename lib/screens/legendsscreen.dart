import 'package:flutter/material.dart';

class LegendDetailsScreen extends StatelessWidget {
  final List<Map<String, String>> legends = [
    {"Symbol": "CAN / MOD", "Description": "Cancelled or Modified Passenger"},
    {"Symbol": "CNF / Confirmed", "Description": "Confirmed (Coach/Berth number will be available after chart preparation)"},
    {"Symbol": "RAC", "Description": "Reservation Against Cancellation"},
    {"Symbol": "WL #", "Description": "Waiting List Number"},
    {"Symbol": "RLWL", "Description": "Remote Location Wait List"},
    {"Symbol": "GNWL", "Description": "General Wait List"},
    {"Symbol": "PQWL", "Description": "Pooled Quota Wait List"},
    {"Symbol": "REGRET/WL", "Description": "No More Booking Permitted"},
    {"Symbol": "RELEASED", "Description": "Ticket Not Cancelled but Alternative Accommodation Provided"},
    {"Symbol": "R# #", "Description": "RAC Coach Number and Berth Number"},
    {"Symbol": "WEBCAN", "Description": "Railway Counter Ticket Passenger cancelled through internet and Refund not collected"},
    {"Symbol": "WEBCANRF", "Description": "Railway Counter Ticket Passenger cancelled through internet and Refund collected"},
    {"Symbol": "RQWL", "Description": "Roadside Quota Waitlist"},
    {"Symbol": "DPWL", "Description": "Duty Pass Waitlist"},
    {"Symbol": "TQWL", "Description": "Tatkal Quota Waitlist"},
    {"Symbol": "NT", "Description": "Passenger Not Turned Up"},
    {"Symbol": "TDR", "Description": "Passenger has filed TDR"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legend Details'),
      ),
      body: Column(
        children: [
          Text('This screen provides detailed meanings of each symbol used in PNR Status.', textAlign: TextAlign.center),
          Flexible(
            child: ListView.builder(
              itemCount: legends.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Text(legends[index]['Symbol'] ?? ''),
                    subtitle: Text(legends[index]['Description'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}