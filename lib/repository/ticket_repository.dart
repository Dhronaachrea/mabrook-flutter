import 'package:mabrook/models/response/ticket_details_response.dart';
import 'package:mabrook/network/api_call.dart';

class TicketRepository {
  static Future<TicketDetailsResponse> getTicketDetails(
      Map<String, dynamic> request) async {
    return await ApiCall.getTicketDetails(request);
  }
}
