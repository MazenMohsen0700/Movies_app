import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/api_resuit/api_resuit.dart';
import 'package:movie_app/features/layout/domain/entity/move_entity.dart';
import 'package:movie_app/features/layout/domain/use_case/move_use_case.dart';
import 'package:movie_app/features/layout/presentation/manager/move_state.dart';

import '../../../../core/states/base_state.dart';

@injectable
class MoveCubit extends Cubit<MoveState> {
  MoveUseCase? moveUseCase;

  MoveCubit(this.moveUseCase) : super(MoveState());

  Future<void> getMove(String genre) async {
    emit(MoveState(moveState: LodingState()));

    try {
      final result = await moveUseCase!.call(genre);

      print('MOVIE RESULT: $result');

      switch (result) {
        case SuccessState<List<MoveEntity>>():
          emit(
            MoveState(
              moveState: Success(data: result.data),
            ),
          );

        case ErrorState<List<MoveEntity>>():
          print('MOVIE ERROR: ${result.errorMessage}');

          emit(
            MoveState(
              moveState: Errorr(
                error: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      print('MOVIE EXCEPTION: $e');

      emit(
        MoveState(
          moveState: Errorr(
            error: e.toString(),
          ),
        ),
      );
    }
  }
}
