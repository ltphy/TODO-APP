class StorageHelper {
  List<T> convertFromJsonListToObjectList<T>({
    required List storageItems,
    required T Function(Map<String, dynamic> data) builder,
  }) {
    List<T> items = [];
    items = storageItems.map((item) => builder(item)).toList();
    return items;
  }

  // convert from list of item to list of json object
  List convertFromObjectListToJsonList<T>({
    required List<T> items,
    required Map<String, dynamic> Function(T) builder,
  }) =>
      items.map((T item) => builder(item)).toList();
}
