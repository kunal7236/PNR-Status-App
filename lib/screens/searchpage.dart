import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pnr_status/screens/pnrstatusscreen.dart' ;
import 'package:pnr_status/secret/api.dart';
import 'package:pnr_status/widget/ui_helper.dart';
import 'package:pnr_status/secret/api.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController pnrController = TextEditingController();
  bool isLoading = false; // Tracks loading state

  Future<Map<String, dynamic>?> fetchPnrStatus(String pnr) async {
    String url = "https://irctc-indian-railway-pnr-status.p.rapidapi.com/getPNRStatus/$pnr";

    Map<String, String> headers = {
      "x-rapidapi-key": api_key,
      "x-rapidapi-host": api_key_host,
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['data'];
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("An error occurred: $e");
      return null;
    }
  }

  void onCheckPnrStatus(BuildContext context) async {
    String pnr = pnrController.text.trim();
    if (pnr.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid 10-digit PNR number."),
      ));
      return;
    }

    setState(() {
      isLoading = true; // Start loading indicator
    });

    var pnrStatus = await fetchPnrStatus(pnr);

    setState(() {
      isLoading = false; // Stop loading indicator
    });

    if (pnrStatus != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PnrStatusScreen(pnrStatus: pnrStatus),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Failed to fetch PNR status. Please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 20,
        shadowColor: Colors.grey,
        title: Center(child: Text('PNR STATUS')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              width: 400,
              child: UiHelper.CustomImage(img: 'train.jpg'), // Replace with your image
            ),
            SizedBox(height: 30),
            Container(
              width: 400,
              child: TextField(
                controller: pnrController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter 10 digit PNR Number',
                  prefixIcon: Icon(Icons.train_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            isLoading
                ? CircularProgressIndicator() // Show loading indicator
                : ElevatedButton(
              onPressed: () => onCheckPnrStatus(context),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(20),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStateProperty.all(Colors.lightGreenAccent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                shadowColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: Text(
                'Check PNR Status',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              elevation: 30,
              shadowColor: Colors.grey,
              child: Container(
                height: 30,
                width: 300,
                child: Center(
                  child: Text(
                    'Only 40 Searches Per day are Free!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

