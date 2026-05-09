// lib/services/call_service.dart
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class CallService {
  // মডিউল টিটিএস (কল আসলে কথা বলবে)
  static final FlutterTts _tts = FlutterTts();

  /// সরাসরি ডায়াল করে
  static Future<void> makeCall(String number) async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      await FlutterPhoneDirectCaller.callNumber(number);
    }
  }

  /// ইনকামিং কল মনিটর (phone_state প্যাকেজ ছাড়া OS stream)
  static StreamSubscription? _subscription;
  static void startListening(Function(String number) onIncoming) {
    // Android / iOS এ আলাদা করে নেটিভ ইভেন্ট লিসেন করতে হয়
    // এখানে আমরা Flutter’র MethodChannel দিয়ে করব, কিন্তু সরলতার জন্য placeholder
    // বাস্তবে এটি নেটিভ প্লাগিন লাগে; আপাতত আমরা ইমপ্লিমেন্ট রাখি।
  }

  /// কল লগ (ডেমো)
  static List<Map<String, dynamic>> callLog = [];

  static void logCall(String number, String type, {int duration = 0}) {
    callLog.add({
      'number': number,
      'type': type, // incoming, outgoing, missed
      'timestamp': DateTime.now().toIso8601String(),
      'duration': duration,
    });
  }

  /// ইনকামিং কল আনাউন্সমেন্ট (ভয়েস দিয়ে বলবে)
  static Future<void> announceCall(String number) async {
    await _tts.setLanguage('en-US');
    await _tts.speak('Incoming call from $number');
  }

  /// কন্টাক্ট নাম পাওয়া (ডেমো)
  static String getContactName(String number) {
    // এখানে contacts_service প্যাকেজ দিয়ে নাম ফেচ করা যায়
    return number; // আপাতত নাম্বারই দেখাবে
  }
}
