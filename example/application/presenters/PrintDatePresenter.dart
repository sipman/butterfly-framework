import 'package:butterfly/src/response.dart';

import '../../useCases/printDate/printDateListener.dart';

class PrintDatePresenter implements PrintDateListener {
  final Response _response;

  PrintDatePresenter(this._response);

  @override
  void onPrintDate(DateTime date) {
    _response.onSuccess(date.toIso8601String());
  }

}