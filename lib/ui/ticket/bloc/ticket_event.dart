part of 'ticket_bloc.dart';

abstract class TicketEvent {}

class GetTicketDetailsEvent extends TicketEvent {
  int pageNumber;

  GetTicketDetailsEvent(this.pageNumber);
}
