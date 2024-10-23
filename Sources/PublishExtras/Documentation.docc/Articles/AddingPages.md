# Adding Free-Form Pages

Learn how to add free-form pages to a generated website.

## Overview

Use ``Route`` and ``PageFactory`` to add free-form pages to a generated website.

### 1. Define a Type Conforming to `Route`

Define a type -- `enum`s are well-suited to this role -- conforming to ``Route`` in order to specify the paths and other basic information for any free-form pages that will be added to a site:

```swift
public enum RecipesRoute: String, CaseIterable, Route {
    case links = "/links"

    public var title: String {
        switch self {
        case .links: return "External links"
        }
    }

    public var description: String {
        switch self {
        case .links: return "Sites we like"
        }
    }
}
```

### 2. Implement a `PageFactory`

Create a type conforming to ``PageFactory`` that will be responsible for creating a `Page` for every instance of the `Route` type defined above.

```swift
public struct RecipesPageFactory: PageFactory {
    public func makePage(for route: RecipesRoute) -> Page {
        switch route {
        case .links:
            return makeLinksPage(route)
        }
    }
}

private extension RecipesPageFactory {
    func makeLinksPage(_ route: RecipesRoute) -> Page {
        .init(route: route) {
            Div {
                // ...
            }
        }
    }
}
```

### 3. Add The Pages to the Publishing Pipeline

Finally, add the pages to the publishing pipeline; note that this step must be added before the HTML pages are generated using `PublishingStep.generateHTML(withThme:indentation:fileMode)`:

```swift
try site.publish(
    using: [
        ...
        .addPages(for: RecipesRoute.self, using: RecipesPageFactory()),
        .generateHTML(withTheme: .foundation),
        ...
    ])
```
