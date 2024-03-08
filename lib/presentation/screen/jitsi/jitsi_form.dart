// import 'package:flutter/material.dart';

// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// class JitsiForm extends StatefulWidget {
//   const JitsiForm({super.key});

//   @override
//   State<JitsiForm> createState() => _JitsiFormState();
// }

// class _JitsiFormState extends State<JitsiForm> {
//   bool audioMuted = true;
//   bool videoMuted = true;
//   bool screenShareOn = false;
//   List<String> participants = [];
//   final _jitsiMeetPlugin = JitsiMeet();
//   String generateJwt() {
//     String token;
//     /* Sign */ {
//       // Create a json web token
//       final jwt = JWT(
//         {
//           "aud": "jitsi",
//           "iss": "chat",
//           "iat": 1702967141,
//           "exp": 1702974341,
//           "nbf": 1702967136,
//           "sub": "vpaas-magic-cookie-2afc5ec762414fe3bfe39fa5be0220cc",
//           "context": {
//             "features": {
//               "livestreaming": true,
//               "outbound-call": true,
//               "sip-outbound-call": false,
//               "transcription": true,
//               "recording": true
//             },
//             "user": {
//               "hidden-from-recorder": false,
//               "moderator": true,
//               "name": "indrakurniawan902",
//               "id": "google-oauth2|116760109914383805353",
//               "avatar": "",
//               "email": "indrakurniawan902@gmail.com"
//             }
//           },
//           "room": "*"
//         },
//         header: {
//           "kid":
//               "vpaas-magic-cookie-2afc5ec762414fe3bfe39fa5be0220cc/3df116-SAMPLE_APP",
//           "typ": "JWT",
//           "alg": "RS256"
//         },
//       );
//       // Sign it
//       final key = RSAPrivateKey('''
// -----BEGIN PRIVATE KEY-----
// MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCExcfkE6ubTSlY
// wr2jLVaSYFpZIQpSAlCOMtN/4f8rXJMUPN6qiocVo/u3WHzy4MswI0X2y0J1dm6H
// NErOnUGUa449DW5G/keZY+S6xukpNPQ38R6oPYEa8bZ/yoMhaciH9oYn5EHoJVlf
// gax1v6de9zsUrSKSLubEarTS4yLNJLtAl5yfFJcDE5Xti68e0aTbRpR6G/jy87H3
// kfB6A0JgmiCTs7AhI1r5U6x68z65cuvNuI09XZLdoKn2PEfpGM0DmY3xMknlWtAC
// lSRGmg2MdrC64x3gbVJnogBMRMM8pEJOnhumk/HrDiKibqGsl/rIITfaSkAvW4pW
// GTskw+WXAgMBAAECggEBAIPFDndLFlsRH2HaE/8odezb947Rfb6aUXxu8PzQPEC6
// pbXGG27CAQL3NlBmX8tkUgO6Xitq2tBc86D3wu5/n6A/hnENLU8D+ec//rdnxeuB
// hIcopDZwo/srvOXjBHVa2QwnHEnm/Yn511M0DQbnaKKVV2tT0SWnqptxE3jgt59D
// 0QloDGWF+e2F8m/hSvwyRPQpSNqQR7qGojhHCAnN2J4bsW5mm/a+oygxDYXvHeHi
// prAyiPZP8NFONCJK4r0Bfx/QSjDj6e3zswD3vb1Jw7Cvky01aGP6iGvtnqXAYvAx
// 7zG4WvS5mEQJ71VtgPCEOPCPEOEUr/fSdKH1HYA12DECgYEAvTcV0HH3tjOe0tfH
// smcKdYZyGTm7x+0UGzPDTu5eHMO79YRGOj1wmcyNduHzHclM97fQifWJ5jNw4GOi
// WsOHoX8Ij1BlgfOzOW2nsD5R2zVSUkEkC1HNxJY2bCWBnlGoF6zg9QG3LpQmV9Xd
// h4kQS456GCPJHOkVjjCJM+TcDo0CgYEAs6K2WcjM7xeD8Glnp64xbzWqGnXADbbu
// 5Y7xXkL5Bw3yD+jxJ6dfvxftxjscT4EA8hk5MMTB2SLBbSvMh8QKvfvj1nwn9xS/
// rh2slicYJqYhhyFqCNyG9fXr+VamhP3Ll4IutRirr6VEzusnSZUPmgwBB8Ql5inW
// sO4BEe0u3bMCgYB4gP6JlCuYhGOgEACEZA9LLea4ngYzm490i5DVUgXp99Za1HUN
// Xle5+4YUsm3tCGjWUuCjHBdI3nYC0jFx8JkOhyLicudSzevUpTtoiSgEnX7iF85m
// zyBnFOtwEKruMz8EZPuXzhHlvkB1LCU7zlTsab7kZNYObXtm5Q5cWGK1eQKBgEOX
// si3OlO5SVt8billZ/lfuRXd3XzDJ6NKQGtpxMOsqoC7EZBmbrTdmdZ3lmB2CWSy/
// uPlUz+w4W7gMhwV/Ctu58F1AknkyYX3OxKYrR7cjQ/Jo7FExScc7JfPIWxgnt3fn
// EFQsWE3bTizd5waVBC3e3nRhpjEZBSPGKrjoGn5pAoGAbiBZschMLccfS1pDoR0A
// 3kSWJGoxo2HOz4R/L0H7hjmDJJ1treRbjR9c803uzSvqdxjMu0JWu+a2Fle7Mg4a
// e1DyFwuEiY3zYQhEwtWLoo69cTAD0tF1mOEimLwhkvK2wrJMF2pw6At4N9WSJTh8
// AvPXe7ZjEGQvxLJt8EAnJ+A=
// -----END PRIVATE KEY-----
// ''');
//       token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);
//       print('Signed token: $token\n');
//       return token;
//     }
//   }

//   join() async {
//     String token = generateJwt();
//     var options = JitsiMeetConferenceOptions(
//       token: token,
//       room: "testgabigabi",
//       configOverrides: {
//         "startWithAudioMuted": false,
//         "startWithVideoMuted": false,
//         "subject": "Lipitori"
//       },
//       featureFlags: {
//         "unsaferoomwarning.enabled": false,
//         "ios.screensharing.enabled": true
//       },
//       userInfo: JitsiMeetUserInfo(
//           displayName: "Gabi",
//           email: "gabi.borlea.1@gmail.com",
//           avatar:
//               "https://avatars.githubusercontent.com/u/57035818?s=400&u=02572f10fe61bca6fc20426548f3920d53f79693&v=4"),
//     );

//     var listener = JitsiMeetEventListener(
//       conferenceJoined: (url) {
//         debugPrint("conferenceJoined: url: $url");
//       },
//       conferenceTerminated: (url, error) {
//         debugPrint("conferenceTerminated: url: $url, error: $error");
//       },
//       conferenceWillJoin: (url) {
//         debugPrint("conferenceWillJoin: url: $url");
//       },
//       participantJoined: (email, name, role, participantId) {
//         debugPrint(
//           "participantJoined: email: $email, name: $name, role: $role, "
//           "participantId: $participantId",
//         );
//         participants.add(participantId!);
//       },
//       participantLeft: (participantId) {
//         debugPrint("participantLeft: participantId: $participantId");
//       },
//       audioMutedChanged: (muted) {
//         debugPrint("audioMutedChanged: isMuted: $muted");
//       },
//       videoMutedChanged: (muted) {
//         debugPrint("videoMutedChanged: isMuted: $muted");
//       },
//       endpointTextMessageReceived: (senderId, message) {
//         debugPrint(
//             "endpointTextMessageReceived: senderId: $senderId, message: $message");
//       },
//       screenShareToggled: (participantId, sharing) {
//         debugPrint(
//           "screenShareToggled: participantId: $participantId, "
//           "isSharing: $sharing",
//         );
//       },
//       chatMessageReceived: (senderId, message, isPrivate, timestamp) {
//         debugPrint(
//           "chatMessageReceived: senderId: $senderId, message: $message, "
//           "isPrivate: $isPrivate, timestamp: $timestamp",
//         );
//       },
//       chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
//       participantsInfoRetrieved: (participantsInfo) {
//         debugPrint(
//             "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
//       },
//       readyToClose: () {
//         debugPrint("readyToClose");
//       },
//     );
//     await _jitsiMeetPlugin.join(options, listener);
//   }

//   hangUp() async {
//     await _jitsiMeetPlugin.hangUp();
//   }

//   setAudioMuted(bool? muted) async {
//     var a = await _jitsiMeetPlugin.setAudioMuted(muted!);
//     debugPrint("$a");
//     setState(() {
//       audioMuted = muted;
//     });
//   }

//   setVideoMuted(bool? muted) async {
//     var a = await _jitsiMeetPlugin.setVideoMuted(muted!);
//     debugPrint("$a");
//     setState(() {
//       videoMuted = muted;
//     });
//   }

//   sendEndpointTextMessage() async {
//     var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
//     debugPrint("$a");

//     for (var p in participants) {
//       var b =
//           await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
//       debugPrint("$b");
//     }
//   }

//   toggleScreenShare(bool? enabled) async {
//     await _jitsiMeetPlugin.toggleScreenShare(enabled!);

//     setState(() {
//       screenShareOn = enabled;
//     });
//   }

//   openChat() async {
//     await _jitsiMeetPlugin.openChat();
//   }

//   sendChatMessage() async {
//     var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
//     debugPrint("$a");

//     for (var p in participants) {
//       a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
//       debugPrint("$a");
//     }
//   }

//   closeChat() async {
//     await _jitsiMeetPlugin.closeChat();
//   }

//   retrieveParticipantsInfo() async {
//     var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
//     debugPrint("$a");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: Center(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   TextButton(
//                     onPressed: join,
//                     child: const Text("Join"),
//                   ),
//                   TextButton(
//                       onPressed: generateJwt, child: const Text("Hang Up")),
//                   Row(children: [
//                     const Text("Set Audio Muted"),
//                     Checkbox(
//                       value: audioMuted,
//                       onChanged: setAudioMuted,
//                     ),
//                   ]),
//                   Row(children: [
//                     const Text("Set Video Muted"),
//                     Checkbox(
//                       value: videoMuted,
//                       onChanged: setVideoMuted,
//                     ),
//                   ]),
//                   TextButton(
//                       onPressed: sendEndpointTextMessage,
//                       child: const Text("Send Hey Endpoint Message To All")),
//                   Row(children: [
//                     const Text("Toggle Screen Share"),
//                     Checkbox(
//                       value: screenShareOn,
//                       onChanged: toggleScreenShare,
//                     ),
//                   ]),
//                   TextButton(
//                       onPressed: openChat, child: const Text("Open Chat")),
//                   TextButton(
//                       onPressed: sendChatMessage,
//                       child: const Text("Send Chat Message to All")),
//                   TextButton(
//                       onPressed: closeChat, child: const Text("Close Chat")),
//                   TextButton(
//                       onPressed: retrieveParticipantsInfo,
//                       child: const Text("Retrieve Participants Info")),
//                 ]),
//           )),
//     );
//   }
// }
