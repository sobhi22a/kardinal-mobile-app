class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  const ApiResponse({
    this.data,
    this.error,
    this.isLoading = false,
  });

  const ApiResponse.loading() : this(isLoading: true);
  const ApiResponse.success(T data) : this(data: data);
  const ApiResponse.error(String error) : this(error: error);
}
