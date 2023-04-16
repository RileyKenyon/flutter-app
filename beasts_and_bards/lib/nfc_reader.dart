/**
 * NFC Reader class for reading tokens
 */
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

// For logging
import 'dart:developer';

class NfcReader extends ChangeNotifier {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  NfcReader() {
    init();
  }

  Future<void> init() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {},
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      // Do something with an NfcTag instance.
      int data = tag.hashCode;
      log('NFC payload: $data');
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void exit() {
    // Stop Session
    NfcManager.instance.stopSession();
  }
}
