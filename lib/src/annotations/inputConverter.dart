class InputConverter {
  const InputConverter(this.method);
  const InputConverter.fromString(): this('fromString');
  const InputConverter.fromJson(): this('fromJson');

  final String method;
}