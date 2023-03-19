/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/05/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
/// An annotated simple subscribe/publish usage example for mqtt_browser_client. Please read in with reference
/// to the MQTT specification. The example is runnable.

/// First create a client, the client is constructed with a broker name, client identifier
/// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
/// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
/// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
/// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
/// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
/// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
/// of 1883 is used. Only web sockets are supported in the browser client.

/// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
/// for details.
final client = MqttBrowserClient('ws://smarthome.test.makipos.net:8083/mqtt', 'BMS_admin');

Future<int> main() async {
  /// Set logging on if needed, defaults to off
  client.logging(on: false);
  /// Set the correct MQTT protocol for mosquito
  client.setProtocolV311();

  /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
  client.keepAlivePeriod = 20;

  /// The connection timeout period can be set if needed, the default is 5 seconds.
  client.connectTimeoutPeriod = 2000; // milliseconds

  /// The ws port for Mosquitto is 8080, for wss it is 8081
  client.port = 8083;
  /// Add the unsolicited disconnection callback
  client.onDisconnected = onDisconnected;

  /// Add the successful connection callback
  client.onConnected = onConnected;



  /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  /// You can add these before connection or change them dynamically after connection if
  /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  /// can fail either because you have tried to subscribe to an invalid topic or the broker
  /// rejects the subscribe request.
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;

  /// Set a ping received callback if needed, called whenever a ping response(pong) is received
  /// from the broker.
  client.pongCallback = pong;

  /// Set the appropriate websocket headers for your connection/broker.
  /// Mosquito uses the single default header, other brokers may be fine with the
  /// default headers.
  client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;

  /// Create a connection message to use or use the default one. The default one sets the
  /// client identifier, any supplied username/password and clean session,
  /// an example of a specific one below.
  // final connMess = MqttConnectMessage()
  //     .withClientIdentifier('BMS_admin')
  //     .withWillTopic('d/bms_device_test_1/s/bms_device_test_1/CP/1/charging_mos_switch') // If you set this you must set a will message
  //     .withWillMessage('${{"d" : 1}}')
  //     .authenticateAs("BMS_admin", '01012023')
  //     .startClean() // Non persistent session for testing
  //     .withWillQos(MqttQos.atLeastOnce);
  // print('EXAMPLE::Mosquitto client connecting....');
  // client.connectionMessage = connMess;
  /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  /// never send malformed messages.
  try {
    await client.connect('BMS_admin','01012023');
    client.subscribe('d/bms_device_test_2/p/UP/#', MqttQos.atLeastOnce);
  } on Exception catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
    return -1;
  }
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
    final payload =
    MqttPublishPayload.bytesToStringAsString(message.payload.message);
    var data = jsonDecode(payload);

    print('Received message:$payload from topic: ${c[0].topic}>');
    print("Data: ${data[0]['d']}");
  });
  /// Check we are connected
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    return -1;
  }
  // const pubtopic = "d/bms_device_test_2/s/BMS_admin/CP/1/charging_mos_switch";
  // final builder = MqttClientPayloadBuilder();
  // builder.addString(jsonEncode(
  //     {
  //       "d" : 1
  //     }
  // ));
  // client.publishMessage(pubtopic, MqttQos.atLeastOnce, builder.payload!);
  // print("Complete");
  /// Ok, lets try a subscription
  // print('EXAMPLE::Subscribing to the topic = d/bms_user_test_1/s/#');
  // const topic = 'd/bms_user_test_1/s/#'; // Not a wildcard topic
  // client.subscribe(topic, MqttQos.atMostOnce);
  // // print('Sub: ${client.subscribe(topic, MqttQos.atMostOnce)}');
  // /// The client has a change notifier object(see the Observable class) which we then listen to to get
  // /// notifications of published updates to each subscribed topic.
  // client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //   final recMess = c![0].payload as MqttPublishMessage;
  //   final pt =
  //       MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //
  //   /// The above may seem a little convoluted for users only interested in the
  //   /// payload, some users however may be interested in the received publish message,
  //   /// lets not constrain ourselves yet until the package has been in the wild
  //   /// for a while.
  //   /// The payload is a byte buffer, this will be specific to the topic
  //   print(
  //       'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
  //   print('');
  // });
  //
  // /// If needed you can listen for published messages that have completed the publishing
  // /// handshake which is Qos dependant. Any message received on this stream has completed its
  // /// publishing handshake with the broker.
  // client.published!.listen((MqttPublishMessage message) {
  //   print(
  //       'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  // });
  //
  // /// Lets publish to our topic
  // /// Use the payload builder rather than a raw buffer
  // /// Our known topic to publish to
  // const pubTopic = 'd/bms_device_test_2/s/BMS_admin/CP/1/charging_mos_switch';

  //
  // /// Subscribe to it
  // print('EXAMPLE::Subscribing to the d/bms_device_test_2/s/BMS_admin/CP/1/charging_mos_switch');
  // client.subscribe(pubTopic, MqttQos.exactlyOnce);
  //
  // /// Publish it
  // print('EXAMPLE::Publishing our topic');
  // client.publishMessage('d/bms_device_test_1/s/bms_device_test_1/CP/1/charging_mos_switch', MqttQos.exactlyOnce, builder.payload!);

  // / Ok, we will now sleep a while, in this gap you will see ping request/response
  // / messages being exchanged by the keep alive mechanism.
  // print('EXAMPLE::Sleeping....');
  // await MqttUtilities.asyncSleep(60);
  //
  // /// Finally, unsubscribe and exit gracefully
  // print('EXAMPLE::Unsubscribing');
  // client.unsubscribe(topic);
  //
  // /// Wait for the unsubscribe message from the broker if you wish.
  // await MqttUtilities.asyncSleep(2);
  // print('EXAMPLE::Disconnecting');
  // client.disconnect();
  return 0;
}

// connection succeeded
void onConnected() {
  print('Connected');
}

// unconnected
void onDisconnected() {
  print('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping response client callback invoked');
}