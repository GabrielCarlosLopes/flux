import 'package:flutter_test/flutter_test.dart';
import 'package:flux/shared/widgets/timer/focus_timer_controller.dart';

void main() {
  group('FocusTimerController Tests', () {
    test('Inicializa corretamente com os minutos definidos', () {
      final controller = FocusTimerController(initialMinutes: 2);
      expect(controller.remainingSeconds.value, 120);
      expect(controller.formattedTime, '02:00');
      expect(controller.state.value, TimerState.stopped);
    });

    test('Pausa o relógio altera o estado e preserva o tempo', () async {
      final controller = FocusTimerController(initialMinutes: 5);
      controller.start();

      await Future.delayed(const Duration(seconds: 1)); // Simula 1 segundo real

      controller.pause();
      expect(controller.state.value, TimerState.paused);
      final tempoPausado = controller.remainingSeconds.value;

      await Future.delayed(const Duration(seconds: 1)); // Mais 1 segundo
      // Tempo não deve ter mudado
      expect(controller.remainingSeconds.value, tempoPausado);
    });
  });
}
