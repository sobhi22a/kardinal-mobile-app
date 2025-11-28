double calculateTotalProperties<T>(List<T> items, double Function(T) selector) {
  return items.fold(0, (sum, item) => sum + selector(item));
}