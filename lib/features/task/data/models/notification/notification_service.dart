class NotificationService {
  static final List<String> notifications = [];

  static void add(String msg) {
    notifications.insert(0, msg);
  }

  static void clear() {
    notifications.clear();
  }
}