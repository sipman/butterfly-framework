import 'package:butterfly/src/endpoint.dart';
import 'package:butterfly/src/response.dart';

import '../../useCases/printDate/printDateUseCase.dart';
import '../presenters/PrintDatePresenter.dart';
import '../requests/dateRequest.dart';

class DateEndpoint implements Endpoint<DateRequest>{

  @override
  String method = 'get';

  @override
  String path = '/date/{{date}}';

  @override
  void callback(DateRequest request, Response response) {
    var presenter = PrintDatePresenter(response);
    var useCase = PrintDateUseCase(presenter);

    var date = DateTime(request.theDate.year, request.theDate.month, request.theDate.day);

    useCase.execute(date);
  }

}