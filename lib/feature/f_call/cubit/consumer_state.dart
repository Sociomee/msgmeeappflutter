part of 'consumer_cubit.dart';

class ConsumerState extends Equatable {
  final Map<String, Peer>? peers;
  ConsumerState({this.peers = const <String, Peer>{}});

  static ConsumerState copy(ConsumerState old, {
    Map<String, Peer>? peers
  }) {
    return ConsumerState(
      peers: peers ?? old.peers
    );
  }

  @override
  List<Object?> get props => [peers];
}
