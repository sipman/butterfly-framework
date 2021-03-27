import 'printDateListener.dart';

class PrintDateUseCase {
  final PrintDateListener presenter;
  const PrintDateUseCase(this.presenter);

  void execute(DateTime dateTime) {
    presenter.onPrintDate(dateTime);
  }
}