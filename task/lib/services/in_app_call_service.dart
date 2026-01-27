// import 'package:cyclo/core/app_export.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:zego_uikit/zego_uikit.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
//
// // import 'package:zego_uiki/zego_uiki.dart';
// class InAppCallService {
//   static Future<void> setNavigationKey(
//     GlobalKey<NavigatorState> navigatorKey,
//   ) async {
//     ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
//   }
//
//   static Future<void> initCallService() async {
//     await ZegoUIKit().initLog().then((value) async {
//       await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
//         ZegoUIKitSignalingPlugin(),
//       ]);
//     });
//   }
//
//   Future<void> onUserLogin() async {
//     final String appId = dotenv.env['ZEGO_APP_ID'] ?? '';
//     final String appSignIn = dotenv.env['ZEGO_APP_SIGN_IN'] ?? '';
//     await ZegoUIKitPrebuiltCallInvitationService().init(
//       appID: int.tryParse(appId) ?? 0000,
//       appSign: appSignIn,
//       userID: PrefUtils.getId(),
//       userName: '',
//       plugins: [ZegoUIKitSignalingPlugin()],
//     );
//   }
//
//   void enterAcceptedOfflineCall() {
//     // jump to call page page if app active by offline call
//     ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
//   }
//
//   void onUserLogout() {
//     ZegoUIKitPrebuiltCallInvitationService().uninit();
//   }
//
//   static Widget callButton() {
//     return ZegoSendCallInvitationButton(
//       isVideoCall: true,
//       //You need to use the resourceID that you created in the subsequent steps.
//       //Please continue reading this document.
//       resourceID: "zegouikit_call",
//       invitees: [
//         ZegoUIKitUser(id: '', name: ''),
//         // ZegoUIKitUser(id: '', name: ''),
//       ],
//     );
//   }
// }
