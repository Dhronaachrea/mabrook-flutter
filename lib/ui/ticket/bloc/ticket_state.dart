part of 'ticket_bloc.dart';

abstract class TicketState {}

class TicketInitialState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketSessionExpiredState extends TicketState {}

class TicketSuccessState extends TicketState {
  final TicketDetailsResponse? ticketDetailsResponse;

  TicketSuccessState({this.ticketDetailsResponse});
}

class TicketErrorState extends TicketState {
  final String? errorMessage;

  TicketErrorState({this.errorMessage});
}
