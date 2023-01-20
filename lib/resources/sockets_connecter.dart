import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';

class SocketsConnector {
  static Future<void> connectToServer() async {
    Socket sock = await Socket.connect('10.0.2.2', 8080);
    print('Connected to: ${sock.remoteAddress.address}:${sock.remotePort}');
  }

  static Future<void> startServer() async {
    //final String myIP = await Ipify.ipv4();
    // Future<ServerSocket> serverFuture =  ServerSocket.bind('192.168.4.2', 2400);
    // serverFuture.then(
    //   (ServerSocket server) {
    //     server.listen((Socket socket) {
    //       socket.listen((data) {
    //         String result = String.fromCharCodes(data);
    //         print('Server data: $data');
    //         print(result.substring(0, result.length - 1));
    //       });
    //     });
    //   },
    // );
    /////////
    // InternetAddress adress = InternetAddress('127.0.0.1');
    // final server = await ServerSocket.bind('176.214.127.28', 2400);
    //
    // print(InternetAddress.anyIPv4);
    //
    // // listen for clent connections to the server
    // server.listen((client) {
    //   //handleConnection(client);
    // });
    /////
    // print("Starting server on Port : 8088");
    // print("Attempting bind");
    //
    // final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
    // print("Server running on IP : ${server.address} On Port : ${server.port}");
    //
    // await for (final request in server) {
    //   print(request.requestedUri);
    //
    //   request.response
    //     ..headers.contentType = ContentType("text", "plain", charset: "utf-8")
    //     ..write("hello world");
    //   await request.response.flush();
    //   await request.response.close();
    //
    //   print("Response served\n");
    // }
    ///
    try{
        var server = await   HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    print("Server running on IP : "+server.address.toString()+" On Port : "+server.port.toString());
    }catch(e){
        print("Something went wrong while creating a server...");
    }
  }
}
