import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/feature/f_call/enitity/peer.dart';
import 'package:msgmee/feature/f_call/enitity/peer_device.dart';

part 'consumer_state.dart';

class ConsumerCubit extends Cubit<ConsumerState> {
  ConsumerCubit() : super(ConsumerState());

  void addPeerConsumer(Consumer consumer) async{
    final Map<String, Peer> newPeers = Map<String, Peer>.of(state.peers ?? {});

      if (consumer.kind == 'video') {
        newPeers[consumer.peerId.toString()] = newPeers[consumer.peerId] != null ? newPeers[consumer.peerId]!.copyWith(
          renderer: RTCVideoRenderer(),
          video: consumer,
        ) : Peer(device:PeerDevice(name: "msgmee",flag: "resume" , version: "1.1"), displayName: "Media Name", id: consumer.peerId.toString()).copyWith(renderer: RTCVideoRenderer(),
          video: consumer,);

        await newPeers[consumer.peerId]!.renderer!.initialize();
        // newPeers[event.peerId]!.renderer!.audioOutput = selectedOutputId;
        newPeers[consumer.peerId]!.renderer!.srcObject =
            newPeers[consumer.peerId]!.video!.stream;
      } else {
        newPeers[consumer.peerId!] = newPeers[consumer.peerId] !=null ? newPeers[consumer.peerId]!.copyWith(
          audio: consumer,
        ) : Peer(device:PeerDevice(name: "msgmee",flag: "resume" , version: "1.1"), displayName: "Media Name", id: consumer.peerId.toString()).copyWith(
          audio: consumer,
        );
      }

      emit(ConsumerState.copy(state,peers: newPeers));
  }

  void addPeer(Peer newPeer) async{
    final Map<String, Peer> newPeers = Map<String, Peer>.of(state.peers ?? {});
     newPeers[newPeer.id] = (newPeers[newPeer.id] != null ? newPeers[newPeer.id] : newPeer)!;
     emit(ConsumerState.copy(state,peers: newPeers));
  }
void removeAllPeers() async{
    final Map<String, Peer> newPeers =  {};
     emit(ConsumerState.copy(state,peers: newPeers));
  }


}
