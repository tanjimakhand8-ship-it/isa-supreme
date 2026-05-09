import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';

class CallService {
  Future<void> makeCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void listenForIncoming(Function(String number) onIncoming) {
    FlutterPhoneState.phoneStateStream.listen((state) {
      if (state.callState == CallState.CALL_STATE_RINGING && state.number != null && state.number!.isNotEmpty) {
        onIncoming(state.number!);
      }
    });
  }
}
