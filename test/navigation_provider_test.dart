import 'package:flutter_test/flutter_test.dart';
import 'package:health_app_new/domain/providers/navigation_provider.dart';

void main() {
  test('стартовый экран — Главная (index 0)', () {
    final nav = NavigationProvider();
    expect(nav.selectedIndex, 0);
  });

  test('переключение на Полезное и обратно', () {
    final nav = NavigationProvider();
    var notifies = 0;
    nav.addListener(() => notifies++);

    nav.navigationBar(1);
    expect(nav.selectedIndex, 1);
    expect(notifies, 1);

    nav.navigationBar(0);
    expect(nav.selectedIndex, 0);
    expect(notifies, 2);
  });

  test('повторный тап по той же вкладке не шлёт notifyListeners', () {
    final nav = NavigationProvider();
    var notifies = 0;
    nav.addListener(() => notifies++);

    nav.navigationBar(0);
    expect(notifies, 0);
  });
}
