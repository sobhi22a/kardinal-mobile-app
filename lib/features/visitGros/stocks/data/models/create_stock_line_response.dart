import 'package:equatable/equatable.dart';

class CreateStockLineResponse extends Equatable {
  final String StockLineId;
  final bool Success;

  const CreateStockLineResponse({
    required this.StockLineId,
    required this.Success,
  });

  @override
  List<Object?> get props => [StockLineId, Success];
}