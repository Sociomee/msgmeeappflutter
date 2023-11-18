import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Events
abstract class SocketEvent {}

class InitSocketEvent extends SocketEvent {}

// States
abstract class SocketState {}

class SocketInitialState extends SocketState {}

class SocketConnectedState extends SocketState {}

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late IO.Socket socket;

  SocketBloc() : super(SocketInitialState());

  @override
  Stream<SocketState> mapEventToState(SocketEvent event) async* {
    if (event is InitSocketEvent) {
      yield* _mapInitSocketEventToState();
    }
  }

  Stream<SocketState> _mapInitSocketEventToState() async* {
    socket = IO.io('your_socket_server_url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    yield SocketConnectedState();
  }
}
