import 'package:devtoys/domain/models/described_enum.dart';

enum EncodeConversionMode implements DescribedEnum {
  Encode("encode"),
  Decode("decode");

  final String description;

  const EncodeConversionMode(this.description);
}