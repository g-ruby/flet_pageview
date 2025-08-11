from typing import Any, List, Optional

from flet.core.constrained_control import ConstrainedControl
from flet.core.control import Control, OptionalNumber
from flet.core.ref import Ref

class FletPageView(ConstrainedControl):
    """
    A Flet control that wraps Flutter's PageView widget.

    It allows you to create scrollable pages.
    """

    def __init__(
        self,
        controls: Optional[List[Control]] = None,
        ref: Optional[Ref] = None,
        # ConstrainedControl
        left: OptionalNumber = None,
        top: OptionalNumber = None,
        right: OptionalNumber = None,
        bottom: OptionalNumber = None,
        width: OptionalNumber = None,
        height: OptionalNumber = None,
        expand: Optional[bool] = None,
        opacity: OptionalNumber = None,
        tooltip: Optional[str] = None,
        visible: Optional[bool] = None,
        data: Any = None,
        # FletPageView Specific
        on_page_changed=None,
    ):
        ConstrainedControl.__init__(
            self,
            ref=ref,
            left=left,
            top=top,
            right=right,
            bottom=bottom,
            width=width,
            height=height,
            expand=expand,
            opacity=opacity,
            tooltip=tooltip,
            visible=visible,
            data=data,
        )

        self.__controls: List[Control] = [] if controls is None else controls
        self.on_page_changed = on_page_changed

    def _get_control_name(self):
        # Це ім'я, яке пов'язує Python-клас з Flutter-віджетом
        return "flet_pageview"

    def _get_children(self):
        # Цей метод повертає дочірні контроли, які будуть нашими сторінками
        return self.__controls

    # controls
    @property
    def controls(self) -> List[Control]:
        return self.__controls

    @controls.setter
    def controls(self, value: Optional[List[Control]]):
        self.__controls = value if value is not None else []

    # on_page_changed
    @property
    def on_page_changed(self):
        return self._get_event_handler("page_changed")

    @on_page_changed.setter
    def on_page_changed(self, handler):
        # "page_changed" - це ім'я події, яке ми будемо надсилати з Dart
        self._add_event_handler("page_changed", handler)