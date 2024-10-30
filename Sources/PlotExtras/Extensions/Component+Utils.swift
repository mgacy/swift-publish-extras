//
//  Component+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 5/1/23.
//  Copyright © 2023 Mobelux. All rights reserved.
//

import Plot

public extension Component {
    /// Assign an accessibility attribute to an element, to establish a parent -> child
    /// relationship.
    ///
    /// - Parameter child: The child to assign to the parent.
    func ariaControls(_ child: String) -> Component {
        attribute(named: "aria-controls", value: child)
    }

    /// Assign an accessibility attribute to an element, which describes whether the element is
    /// expanded or not.
    ///
    /// - Parameter isExpanded: Whether the element is expanded or not.
    func ariaExpaned(_ isExpanded: Bool) -> Component {
        attribute(named: "aria-expanded", value: isExpanded ? "true" : "false")
    }

    /// Assign an accessibility attribute to an element, which removes an element from the
    /// accessibility tree.
    ///
    /// The provided name will replace any existing one.
    ///
    /// - Parameter isHidden: Whether the element is hidden or not.
    func ariaHidden(_ isHidden: Bool) -> Component {
        attribute(named: "aria-hidden", value: isHidden ? "true" : "false")
    }

    /// Assign an accessibility label to the element, which is used by assistive technologies to get
    /// a text representation of it.
    ///
    /// - Parameter label: The label to assign.
    func ariaLabel(_ label: String) -> Component {
        attribute(named: "aria-label", value: label)
    }

    /// Assign an accessibility attribute to an element, which describes whether the element is modal
    /// or not.
    ///
    /// - Parameter isModal: Whether the element is modal or not.
    func ariaModal(_ isModal: Bool) -> Component {
        attribute(named: "aria-modal", value: isModal ? "true" : "false")
    }

    /// Assign an `autocomplete` attribute to an element.
    ///
    /// - Parameter autocomplete: The value of the autocomplete attribute.
    func autocomplete(_ autocomplete: Autocomplete) -> Component {
        attribute(named: "autocomplete", value: autocomplete.value)
    }

    /// Assign a class name to this component's element. May also be a list
    /// of space-separated class names.
    ///
    /// - Parameters:
    ///   - className: The class or list of classes to assign.
    ///   - replaceExisting: Whether the new class name should replace
    ///   any existing one. Defaults to `false`, which will instead cause the
    ///   new class name to be appended to any existing one, separated by a space.
    func `class`<C: RawRepresentable>(_ className: C, replaceExisting: Bool = false) -> Component where C.RawValue == String {
        attribute(
            named: "class",
            value: className.rawValue,
            replaceExisting: replaceExisting)
    }

    /// Assign a `height` attribute to this component's element.
    ///
    /// - Parameter size: The height to assign.
    func height(_ size: Int) -> Component {
        attribute(named: "height", value: "\(size)")
    }

    /// Assign a `name` attribute to this component's element.
    ///
    /// The provided name will replace any existing one.
    ///
    /// - Parameter name: The value of the name to assign.
    func name(_ name: String) -> Component {
        attribute(named: "name", value: name, replaceExisting: true)
    }

    /// Assign an `onchange` attribute to this component's element.
    ///
    /// - Parameter javascript: The javascript to execute when the element changes.
    func onchange(_ javascript: String) -> Component {
        attribute(named: "onchange", value: javascript)
    }

    /// Assign an `onclick` attribute to this component's element.
    ///
    /// - Parameter javascript: The javascript to execute when clicked.
    func onclick(_ javascript: String) -> Component {
        attribute(named: "onclick", value: javascript)
    }

    /// Assign an `onsubmit` attribute to this component's element.
    ///
    /// - Parameter javascript: The javascript to execure when the element is submitted.
    func onsubmit(_ javascript: String) -> Component {
        attribute(named: "onsubmit", value: javascript)
    }

    /// Assign a `pattern` attribute to this component's element.
    ///
    /// - Parameter inputPattern: The pattern to assign.
    func pattern(_ inputPattern: InputPattern) -> Component {
        attribute(named: "pattern", value: inputPattern.value)
    }

    /// Assign a `role` attribute to this component's element.
    ///
    /// - Parameter value: The value to assign.
    func role(_ value: String) -> Component {
        attribute(named: "role", value: value)
    }

    /// Assign a `width` attribute to this component's element.
    ///
    /// - Parameter size: The width to assign.
    func width(_ size: Int) -> Component {
        attribute(named: "width", value: "\(size)")
    }
}
