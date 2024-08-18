import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mabrook/models/response/ticket_details_response.dart';
import 'package:mabrook/repository/ticket_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/date_format.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {

  TicketBloc() : super(TicketInitialState()) {
    on<GetTicketDetailsEvent>(_onGetTicketDetails);
  }

  String fromDate = formatDate(
    date: DateTime.now().subtract(const Duration(days: 30)).toString(),
    inputFormat: Format.apiDateFormat2,
    outputFormat: Format.apiDateFormat3,
  );

  String toDate = formatDate(
    date: DateTime.now().toString(),
    inputFormat: Format.apiDateFormat2,
    outputFormat: Format.apiDateFormat3,
  );

  Future<FutureOr<void>> _onGetTicketDetails(GetTicketDetailsEvent event, Emitter<TicketState> emit) async {

    emit(TicketLoadingState());

    print("pageNumber------------->${event.pageNumber}");
    print("fromDate------------->${fromDate}");
    print("toDate------------->${toDate}");
    print("AppConstants.ticketGameCode------------->${AppConstants.ticketGameCode}");
    print("AppConstants.descOrderBy------------->${AppConstants.descOrderBy}");
    print("UserInfo.userId.toString()------------->${UserInfo.userId.toString()}");

    Map<String, dynamic> request = {
      "startDate"     : fromDate,
      "endDate"       : toDate,
      "gameCode"      : AppConstants.ticketGameCode,
      "merchantCode"  : AppConstants.ticketGameCode,
      "orderBy"       : AppConstants.descOrderBy,
      "pageIndex"     : event.pageNumber.toString(),
      "pageSize"      : "50",
      "playerId"      : UserInfo.userId.toString(),
    };

    TicketDetailsResponse? response = await TicketRepository.getTicketDetails(request);
    log("response: ${response.responseData}");
    if (response.responseCode == 0) {
      emit(TicketSuccessState(ticketDetailsResponse: response));

    } else if (response.responseCode == AppConstants.sessionExpiryCode){
      showUserConfirmationDialog("Session Expired!", "Cancel", "LogIn Again", true);
      emit(TicketSessionExpiredState());

    } else {
      emit(TicketErrorState(errorMessage: response.responseMessage?.toString()));

    }
  }
}
