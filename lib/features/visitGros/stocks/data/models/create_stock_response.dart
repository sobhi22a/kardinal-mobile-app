import 'package:equatable/equatable.dart';

class CreateStockResponse extends Equatable {
  final String StockId;
  final bool Success;

  const CreateStockResponse({
    required this.StockId,
    required this.Success,
  });

  @override
  List<Object?> get props => [StockId, Success];
}