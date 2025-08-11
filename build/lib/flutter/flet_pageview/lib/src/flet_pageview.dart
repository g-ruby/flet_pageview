import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

// Наш віджет буде Stateful, оскільки нам потрібен PageController
class FletPageViewControl extends StatefulWidget {
  final Control? parent;
  final Control control;
  final List<Control> children;
  final FletControlBackend backend;

  const FletPageViewControl({
    super.key,
    required this.parent,
    required this.control,
    required this.children,
    required this.backend,
  });

  @override
  State<FletPageViewControl> createState() => _FletPageViewControlState();
}

class _FletPageViewControlState extends State<FletPageViewControl> {
  // Контролер для керування станом PageView
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Важливо звільнити ресурси контролера
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building FletPageViewControl with ${widget.children.length} children");

    // Фільтруємо видимі дочірні контроли
    final pageControls = widget.children.where((c) => c.isVisible).toList();

    // Створюємо віджет PageView
    Widget pageView = PageView(
      controller: _pageController,
      // Коли сторінка змінюється, викликаємо цю функцію
      onPageChanged: (int page) {
        debugPrint("Page changed to $page");
        // Надсилаємо подію "page_changed" у Python разом з індексом нової сторінки
        widget.backend.triggerControlEvent(
            widget.control.id, "page_changed", page.toString());
      },
      // Створюємо сторінки з дочірніх контролів, переданих з Flet
      children: pageControls
          .map((c) => createControl(widget.control, c.id, widget.control.isDisabled))
          .toList(),
    );

    // Використовуємо constrainedControl, щоб застосувати властивості
    // ширини, висоти, позиції тощо.
    return constrainedControl(context, pageView, widget.parent, widget.control);
  }
}