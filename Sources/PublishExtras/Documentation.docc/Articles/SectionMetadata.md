# Section-Specific Metadata

Learn how to model section-specific metadata.

## Overview

Use Core's types to extend Publish's notion of site-specific metadata to support section-specific metadata.

### Publish's Existing Metadata Support

Publish uses the `Publish.Website` protocol to model websites and represents site-specfic metadata using that protocol's associated type, `Publish.Website.ItemMetadata`. It includes [support](https://github.com/JohnSundell/Publish/blob/master/Documentation/HowTo/custom-markdown-metadata-values.md) for using optional and nested metadata values to represent more complex values that are not applicable to all items. For example, a website possessing a notion of product information that is applicable to only some of its items could use the following metadata types:

```swift
struct ProductInfo: WebsiteItemMetadata {
    var price: Int
    var category: String
}

struct ItemMetadata: WebsiteItemMetadata {
    var product: ProductInfo?
}
```

The Markdown content file for a page to which the notion of product info is applicable would then specify the corresponding values using nested metadata fields:

```md
---
product.price: 250
product.category: Electronics
---


# A fantastic product

...
```

If this site also has a notion of recipes, it might define a `RecipesInfo` type and organize its content into "products" and "recipes" sections: 

```swift
struct MyWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case products
        case recipes
    }

    struct ProductInfo: WebsiteItemMetadata {
        var price: Int
        var category: String
    }

    struct RecipeInfo: WebsiteItemMetadata {
        var ingredients: [String]
        var preparationTime: TimeInterval
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var product: ProductInfo?
        var recipe: RecipeInfo?
    }

    ...
}
```

This strategy was two shortcomings:

- modeling site metadata using product types like `struct` with optional members only supports expressing that an item might have an instance of `ProductInfo` just as it might have one of `RecipeInfo`; it could have neither or both.
- the ergonomics of defining YAML frontmatter via nested fields is suboptimal.


### Section-Specific Metadata

Modeling site metadata as an `enum` allows the type to express the fact that an item must have _either_ recipe _or_ product metadata:

```swift
struct ProductInfo: WebsiteItemMetadata {
    var price: Int
    var category: String
}

struct RecipeInfo: WebsiteItemMetadata {
    var ingredients: [String]
    var preparationTime: TimeInterval
}

struct ItemMetadata: WebsiteItemMetadata {
    case product(ProductInfo)
    case recipe(RecipeInfo)

    init(from decoder: Decoder) throws {
        if let productMetadata = try? ProductInfo(from: decoder) {
            self = .product(productMetadata)
        } else if let recipeMetadata = try? RecipeMetadata(from: decoder) {
            self = .recipe(recipeMetadata)
        } else {
            throw DecodingError.typeMismatch(
                Mobelux.ItemMetadata.self,
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "Unable to decode section metadata",
                    underlyingError: nil))
        }
    }
}
```

This makes it possible to dispense with the `product` or `recipe` prefixes in the frontmatter of the Markdown files defining section items:

```md
---
price: 250
category: Electronics
---
...
```

or:

```md
---
ingredients: flour, eggs
preparationTime: 20
---
...
```

Finally, the ``SectionItem`` type supports representing a section item with its section-specific metadata. First, add members to `ItemMetadata` to support access to the associated types of its different cases:

```swift
struct ItemMetadata: WebsiteItemMetadata {
    ...
    var productMetadata: ProductInfo? {
        guard case .product(let metadata) = self else { return nil }
        return metadata
    }
    ...
}
```

Then use ``Publish/Section/sectionItems(transform:)`` to obtain a collection of ``SectionItem`` from its `items`:

```swift
var productsSection: Section<MyWebsite>
...
let productsItems: [SectionItem<ProductInfo>] = productsSection.sectionItems(\.productMetadata)
```
