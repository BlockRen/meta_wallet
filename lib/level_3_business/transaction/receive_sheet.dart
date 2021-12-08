import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_wallet/level_2_data/model/account_model.dart';

class ReceiveSheet extends StatefulWidget {

  const ReceiveSheet() : super();

  @override
  _ReceiveSheetStateState createState() => _ReceiveSheetStateState();
}

class _ReceiveSheetStateState extends State<ReceiveSheet> {

  // Address copied items
  // Current state references
  late bool _addressCopied;
  // Timer reference so we can cancel repeated events
  late Timer _addressCopiedTimer;

  @override
  void initState() {
    super.initState();
    // Set initial state of copy button
    _addressCopied = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          // A row for the address text and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Empty SizedBox
              const SizedBox(
                width: 60,
                height: 60,
              ),
              //Container for the address text and sheet handle
              Column(
                children: <Widget>[
                  // Sheet handle
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Text(AccountModel().address()!)
                  ),
                ],
              ),
              //Empty SizedBox
              const SizedBox(
                width: 60,
                height: 60,
              ),
            ],
          ),
          // QR which takes all the available space left from the buttons & address text
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 20, bottom: 28, start: 20, end: 20),
              child: LayoutBuilder(builder: (context, constraints) {
                double availableWidth = constraints.maxWidth;
                double availableHeight = constraints.maxHeight;
                double widthDivideFactor = 1.3;
                double computedMaxSize = math.min(
                    availableWidth / widthDivideFactor, availableHeight);
                return Center(
                  child: Stack(
                    children: <Widget>[
                      // Background/border part the QR
                      Center(
                        child: SizedBox(
                          width: computedMaxSize / 1.07,
                          height: computedMaxSize / 1.07,
                          child: SvgPicture.asset('assets/QR.svg'),
                        ),
                      ),
                      // Actual QR part of the QR
                      Center(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(computedMaxSize / 51),
                          height: computedMaxSize / 1.53,
                          width: computedMaxSize / 1.53,
                          child: const Text("Here may be a QR code."), //widget.qrWidget,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      )
    );
  }
}
