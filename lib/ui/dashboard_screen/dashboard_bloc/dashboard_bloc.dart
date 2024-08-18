import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_bloc_event.dart';
part 'dashboard_bloc_state.dart';

class DashBoardBloc
    extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc() : super(DashBoardInitial());
}
