import 'package:movie_app/core/states/base_state.dart';
import 'package:movie_app/features/layout/domain/entity/move_entity.dart';

class MoveState {
  BaseState<List<MoveEntity>>? moveState;
  MoveState({this.moveState});
  MoveState copyWiwh({BaseState<List<MoveEntity>>? moveState}) {
    return MoveState(moveState: moveState ?? this.moveState);
  }
}
