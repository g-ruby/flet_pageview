import 'package:flet/flet.dart';
import 'flet_pageview.dart'; // Імпортуємо наш новий віджет

CreateControlFactory createControl = (CreateControlArgs args) {
  switch (args.control.type) {
    // Якщо ім'я контролу з Python - "flet_pageview", створюємо наш віджет
    case "flet_pageview":
      return FletPageViewControl(
        parent: args.parent,
        control: args.control,
        children: args.children, // Передаємо дочірні елементи
        backend: args.backend,
      );
    default:
      // Якщо ім'я не збігається, Flet продовжить пошук в інших розширеннях
      return null;
  }
};

void ensureInitialized() {
  // Наразі тут нічого не потрібно
}