import 'package:flutter/material.dart';

class SendSheet extends StatefulWidget {
  // final AvailableCurrency localCurrency;
  // final Contact contact;
  final String address;
  final String quickSendAmount;

  // SendSheet(
  //     {@required this.localCurrency,
  //       this.contact,
  //       this.address,
  //       this.quickSendAmount})
  //     : super();
  SendSheet(this.address, this.quickSendAmount);

  @override
  _SendSheetState createState() => _SendSheetState();
}

// enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _SendSheetState extends State<SendSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
      EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          // A row for the header of the sheet, balance text and close button
          // 小横条，发送自
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Empty SizedBox
              const SizedBox(
                width: 60,
                height: 60,
              ),

              // Container for the header, address and balance text
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
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140),
                    child: Column(
                      children: const <Widget>[
                        // Header
                        Text("发送自"),
                        // AutoSizeText(
                        //   CaseChange.toUpperCase(
                        //       AppLocalization.of(context).sendFrom, context),
                        //   style: AppStyles.textStyleHeader(context),
                        //   textAlign: TextAlign.center,
                        //   maxLines: 1,
                        //   stepGranularity: 0.1,
                        // ),
                      ],
                    ),
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

          // Main Account
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 30, right: 30),
            child: Container(
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: "Main Account", //StateContainer.of(context).selectedAccount.name,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NunitoSans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Address Text
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: const Text("salfjlskajdflksjglkafjsdloiasijflskjdflkjlk"),
            // OneOrThreeLineAddressText(
            //     address: StateContainer.of(context).wallet.address,
            //     type: AddressTextType.PRIMARY60),
          ),

          // 剩余金额、输入金额、输入地址
          // Expanded(
          //   child: Container(
          //     margin: const EdgeInsets.only(top: 5, bottom: 5),
          //     child: Stack(
          //       children: <Widget>[
          //         GestureDetector(
          //           onTap: () {
          //             // Clear focus of our fields when tapped in this empty space
          //             _sendAddressFocusNode.unfocus();
          //             _sendAmountFocusNode.unfocus();
          //           },
          //           child: Container(
          //             color: Colors.transparent,
          //             child: SizedBox.expand(),
          //             constraints: BoxConstraints.expand(),
          //           ),
          //         ),
          //         // A column for Enter Amount, Enter Address, Error containers and the pop up list
          //         Column(
          //           children: <Widget>[
          //             Stack(
          //               children: <Widget>[
          //                 // Column for Balance Text, Enter Amount container + Enter Amount Error container
          //                 Column(
          //                   children: <Widget>[
          //                     // 剩余金额
          //                     FutureBuilder(
          //                       future: sl
          //                           .get<SharedPrefsUtil>()
          //                           .getPriceConversion(),
          //                       builder: (BuildContext context,
          //                           AsyncSnapshot snapshot) {
          //                         if (snapshot.hasData &&
          //                             snapshot.data != null &&
          //                             snapshot.data !=
          //                                 PriceConversion.HIDDEN) {
          //                           return Container(
          //                             child: RichText(
          //                               textAlign: TextAlign.start,
          //                               text: TextSpan(
          //                                 text: '',
          //                                 children: [
          //                                   TextSpan(
          //                                     text: "(",
          //                                     style: TextStyle(
          //                                       color:
          //                                       StateContainer.of(context)
          //                                           .curTheme
          //                                           .primary60,
          //                                       fontSize: 14.0,
          //                                       fontWeight: FontWeight.w100,
          //                                       fontFamily: 'NunitoSans',
          //                                     ),
          //                                   ),
          //                                   TextSpan(
          //                                     text: _localCurrencyMode
          //                                         ? StateContainer.of(context)
          //                                         .wallet
          //                                         .getLocalCurrencyPrice(
          //                                         StateContainer.of(
          //                                             context)
          //                                             .curCurrency,
          //                                         locale: StateContainer
          //                                             .of(context)
          //                                             .currencyLocale)
          //                                         : StateContainer.of(context)
          //                                         .wallet
          //                                         .getAccountBalanceDisplay(),
          //                                     style: TextStyle(
          //                                       color:
          //                                       StateContainer.of(context)
          //                                           .curTheme
          //                                           .primary60,
          //                                       fontSize: 14.0,
          //                                       fontWeight: FontWeight.w700,
          //                                       fontFamily: 'NunitoSans',
          //                                     ),
          //                                   ),
          //                                   TextSpan(
          //                                     text: _localCurrencyMode
          //                                         ? ")"
          //                                         : " NANO)",
          //                                     style: TextStyle(
          //                                       color:
          //                                       StateContainer.of(context)
          //                                           .curTheme
          //                                           .primary60,
          //                                       fontSize: 14.0,
          //                                       fontWeight: FontWeight.w100,
          //                                       fontFamily: 'NunitoSans',
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           );
          //                         }
          //                         return Container(
          //                           child: Text(
          //                             "*******",
          //                             style: TextStyle(
          //                               color: Colors.transparent,
          //                               fontSize: 14.0,
          //                               fontWeight: FontWeight.w100,
          //                               fontFamily: 'NunitoSans',
          //                             ),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                     // ******* Enter Amount Container ******* //
          //                     getEnterAmountContainer(),
          //                     // ******* Enter Amount Container End ******* //
          //
          //                     // ******* Enter Amount Error Container ******* //
          //                     Container(
          //                       alignment: const AlignmentDirectional(0, 0),
          //                       margin: const EdgeInsets.only(top: 3),
          //                       child: Text(_amountValidationText,
          //                           style: TextStyle(
          //                             fontSize: 14.0,
          //                             color: Theme.of(context).textTheme.bodyText1!.color,
          //                             fontFamily: 'NunitoSans',
          //                             fontWeight: FontWeight.w600,
          //                           )),
          //                     ),
          //                     // ******* Enter Amount Error Container End ******* //
          //                   ],
          //                 ),
          //
          //                 // Column for Enter Address container + Enter Address Error container
          //                 // Column(
          //                 //   children: <Widget>[
          //                 //     Container(
          //                 //       alignment: Alignment.topCenter,
          //                 //       child: Stack(
          //                 //         alignment: Alignment.topCenter,
          //                 //         children: <Widget>[
          //                 //           Container(
          //                 //             margin: EdgeInsets.only(
          //                 //                 left: MediaQuery.of(context)
          //                 //                     .size
          //                 //                     .width *
          //                 //                     0.105,
          //                 //                 right: MediaQuery.of(context)
          //                 //                     .size
          //                 //                     .width *
          //                 //                     0.105),
          //                 //             alignment: Alignment.bottomCenter,
          //                 //             constraints: const BoxConstraints(
          //                 //                 maxHeight: 174, minHeight: 0),
          //                 //             // ********************************************* //
          //                 //             // ********* The pop-up Contacts List ********* //
          //                 //             child: ClipRRect(
          //                 //               borderRadius:
          //                 //               BorderRadius.circular(25),
          //                 //               child: Container(
          //                 //                 decoration: BoxDecoration(
          //                 //                   borderRadius:
          //                 //                   BorderRadius.circular(25),
          //                 //                   color: StateContainer.of(context)
          //                 //                       .curTheme
          //                 //                       .backgroundDarkest,
          //                 //                 ),
          //                 //                 child: Container(
          //                 //                   decoration: BoxDecoration(
          //                 //                     borderRadius:
          //                 //                     BorderRadius.circular(25),
          //                 //                   ),
          //                 //                   margin: const EdgeInsets.only(bottom: 50),
          //                 //                   child: ListView.builder(
          //                 //                     shrinkWrap: true,
          //                 //                     padding: const EdgeInsets.only(
          //                 //                         bottom: 0, top: 0),
          //                 //                     itemCount: _contacts.length,
          //                 //                     itemBuilder: (context, index) {
          //                 //                       return _buildContactItem(
          //                 //                           _contacts[index]);
          //                 //                     },
          //                 //                   ), // ********* The pop-up Contacts List End ********* //
          //                 //                   // ************************************************** //
          //                 //                 ),
          //                 //               ),
          //                 //             ),
          //                 //           ),
          //                 //
          //                 //           // ******* Enter Address Container ******* //
          //                 //           getEnterAddressContainer(),
          //                 //           // ******* Enter Address Container End ******* //
          //                 //         ],
          //                 //       ),
          //                 //     ),
          //                 //
          //                 //     // ******* Enter Address Error Container ******* //
          //                 //     // Container(
          //                 //     //   alignment: AlignmentDirectional(0, 0),
          //                 //     //   margin: EdgeInsets.only(top: 3),
          //                 //     //   child: Text(_addressValidationText,
          //                 //     //       style: TextStyle(
          //                 //     //         fontSize: 14.0,
          //                 //     //         color: StateContainer.of(context)
          //                 //     //             .curTheme
          //                 //     //             .primary,
          //                 //     //         fontFamily: 'NunitoSans',
          //                 //     //         fontWeight: FontWeight.w600,
          //                 //     //       )),
          //                 //     // ),
          //                 //     // ******* Enter Address Error Container End ******* //
          //                 //   ],
          //                 // ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          //A column with "Scan QR Code" and "Send" buttons
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         children: <Widget>[
          //           // Send Button
          //           AppButton.buildAppButton(
          //               context,
          //               AppButtonType.PRIMARY,
          //               AppLocalization.of(context).send,
          //               Dimens.BUTTON_TOP_DIMENS, onPressed: () {
          //             // bool validRequest = _validateRequest();
          //             // if (_sendAddressController.text.startsWith("@") &&
          //             //     validRequest) {
          //             //   // Need to make sure its a valid contact
          //             //   sl
          //             //       .get<DBHelper>()
          //             //       .getContactWithName(_sendAddressController.text)
          //             //       .then((contact) {
          //             //     if (contact == null) {
          //             //       setState(() {
          //             //         _addressValidationText =
          //             //             AppLocalization.of(context).contactInvalid;
          //             //       });
          //             //     } else {
          //             //       Sheets.showAppHeightNineSheet(
          //             //           context: context,
          //             //           widget: SendConfirmSheet(
          //             //               amountRaw: _localCurrencyMode
          //             //                   ? NumberUtil.getAmountAsRaw(
          //             //                       _convertLocalCurrencyToCrypto())
          //             //                   : _rawAmount == null
          //             //                       ? NumberUtil.getAmountAsRaw(
          //             //                           _sendAmountController.text)
          //             //                       : _rawAmount,
          //             //               destination: contact.address,
          //             //               contactName: contact.name,
          //             //               maxSend: _isMaxSend(),
          //             //               localCurrency: _localCurrencyMode
          //             //                   ? _sendAmountController.text
          //             //                   : null));
          //             //     }
          //             //   });
          //             // } else if (validRequest) {
          //             //   Sheets.showAppHeightNineSheet(
          //             //       context: context,
          //             //       widget: SendConfirmSheet(
          //             //           amountRaw: _localCurrencyMode
          //             //               ? NumberUtil.getAmountAsRaw(
          //             //                   _convertLocalCurrencyToCrypto())
          //             //               : _rawAmount == null
          //             //                   ? NumberUtil.getAmountAsRaw(
          //             //                       _sendAmountController.text)
          //             //                   : _rawAmount,
          //             //           destination: _sendAddressController.text,
          //             //           maxSend: _isMaxSend(),
          //             //           localCurrency: _localCurrencyMode
          //             //               ? _sendAmountController.text
          //             //               : null));
          //             // }
          //           }),
          //         ],
          //       ),
          //       // Row(
          //       //   children: <Widget>[
          //       //     // Scan QR Code Button
          //       //     AppButton.buildAppButton(
          //       //         context,
          //       //         AppButtonType.PRIMARY_OUTLINE,
          //       //         AppLocalization.of(context).scanQrCode,
          //       //         Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
          //       //       UIUtil.cancelLockEvent();
          //       //       String scanResult = await UserDataUtil.getQRData(
          //       //           DataType.MANTA_ADDRESS, context);
          //       //       if (scanResult == null) {
          //       //         UIUtil.showSnackbar(
          //       //             AppLocalization.of(context).qrInvalidAddress,
          //       //             context);
          //       //       } else if (QRScanErrs.ERROR_LIST.contains(scanResult)) {
          //       //         return;
          //       //       } else if (MantaWallet.parseUrl(scanResult) != null) {
          //       //         try {
          //       //           _showMantaAnimation();
          //       //           // Get manta payment request
          //       //           MantaWallet manta = MantaWallet(scanResult);
          //       //           PaymentRequestMessage paymentRequest =
          //       //               await MantaUtil.getPaymentDetails(manta);
          //       //           if (animationOpen) {
          //       //             Navigator.of(context).pop();
          //       //           }
          //       //           MantaUtil.processPaymentRequest(
          //       //               context, manta, paymentRequest);
          //       //         } catch (e) {
          //       //           if (animationOpen) {
          //       //             Navigator.of(context).pop();
          //       //           }
          //       //           log.e(
          //       //               'Failed to make manta request ${e.toString()}',
          //       //               e);
          //       //           UIUtil.showSnackbar(
          //       //               AppLocalization.of(context).mantaError,
          //       //               context);
          //       //         }
          //       //       } else {
          //       //         // Is a URI
          //       //         Address address = Address(scanResult);
          //       //         // See if this address belongs to a contact
          //       //         Contact contact = await sl
          //       //             .get<DBHelper>()
          //       //             .getContactWithAddress(address.address);
          //       //         if (contact == null) {
          //       //           // Not a contact
          //       //           if (mounted) {
          //       //             setState(() {
          //       //               _isContact = false;
          //       //               _addressValidationText = "";
          //       //               _sendAddressStyle = AddressStyle.TEXT90;
          //       //               _pasteButtonVisible = false;
          //       //               _showContactButton = false;
          //       //             });
          //       //             _sendAddressController.text = address.address;
          //       //             _sendAddressFocusNode.unfocus();
          //       //             setState(() {
          //       //               _addressValidAndUnfocused = true;
          //       //             });
          //       //           }
          //       //         } else {
          //       //           // Is a contact
          //       //           if (mounted) {
          //       //             setState(() {
          //       //               _isContact = true;
          //       //               _addressValidationText = "";
          //       //               _sendAddressStyle = AddressStyle.PRIMARY;
          //       //               _pasteButtonVisible = false;
          //       //               _showContactButton = false;
          //       //             });
          //       //             _sendAddressController.text = contact.name;
          //       //           }
          //       //         }
          //       //         // If amount is present, fill it and go to SendConfirm
          //       //         if (address.amount != null) {
          //       //           bool hasError = false;
          //       //           BigInt amountBigInt =
          //       //               BigInt.tryParse(address.amount);
          //       //           if (amountBigInt != null &&
          //       //               amountBigInt < BigInt.from(10).pow(24)) {
          //       //             hasError = true;
          //       //             UIUtil.showSnackbar(
          //       //                 AppLocalization.of(context)
          //       //                     .minimumSend
          //       //                     .replaceAll("%1", "0.000001"),
          //       //                 context);
          //       //           } else if (_localCurrencyMode && mounted) {
          //       //             toggleLocalCurrency();
          //       //             _sendAmountController.text =
          //       //                 NumberUtil.getRawAsUsableString(
          //       //                     address.amount);
          //       //           } else if (mounted) {
          //       //             setState(() {
          //       //               _rawAmount = address.amount;
          //       //               // If raw amount has more precision than we support show a special indicator
          //       //               if (NumberUtil.getRawAsUsableString(_rawAmount)
          //       //                       .replaceAll(",", "") ==
          //       //                   NumberUtil.getRawAsUsableDecimal(_rawAmount)
          //       //                       .toString()) {
          //       //                 _sendAmountController.text =
          //       //                     NumberUtil.getRawAsUsableString(
          //       //                             _rawAmount)
          //       //                         .replaceAll(",", "");
          //       //               } else {
          //       //                 _sendAmountController
          //       //                     .text = NumberUtil.truncateDecimal(
          //       //                             NumberUtil.getRawAsUsableDecimal(
          //       //                                 address.amount),
          //       //                             digits: 6)
          //       //                         .toStringAsFixed(6) +
          //       //                     "~";
          //       //               }
          //       //             });
          //       //             _sendAddressFocusNode.unfocus();
          //       //           }
          //       //           // If balance is sufficient go to SendConfirm
          //       //           if (!hasError &&
          //       //               StateContainer.of(context)
          //       //                       .wallet
          //       //                       .accountBalance >
          //       //                   amountBigInt) {
          //       //             // Go to confirm sheet
          //       //             Sheets.showAppHeightNineSheet(
          //       //                 context: context,
          //       //                 widget: SendConfirmSheet(
          //       //                     amountRaw: _localCurrencyMode
          //       //                         ? NumberUtil.getAmountAsRaw(
          //       //                             _convertLocalCurrencyToCrypto())
          //       //                         : _rawAmount == null
          //       //                             ? NumberUtil.getAmountAsRaw(
          //       //                                 _sendAmountController.text)
          //       //                             : _rawAmount,
          //       //                     destination: contact != null
          //       //                         ? contact.address
          //       //                         : address.address,
          //       //                     contactName:
          //       //                         contact != null ? contact.name : null,
          //       //                     maxSend: _isMaxSend(),
          //       //                     localCurrency: _localCurrencyMode
          //       //                         ? _sendAmountController.text
          //       //                         : null));
          //       //           }
          //       //         }
          //       //       }
          //       //     })
          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ));
  }
}