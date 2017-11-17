//: Playground - noun: a place where people can play

import Foundation

public class Store {
    let storesToDisk: Bool = true
}
public class BookmarkStore: Store {
    let itemCount: Int = 10
}
public struct Bookmark {
    enum Group {
        case Tech
        case News
    }
    private let store = {
        return BookmarkStore()
    }()
    let title: String?
    let url: NSURL
    let keywords: [String]
    let group: Group
}

let aBookmark = Bookmark(title: "Appventure", url: NSURL(string: "appventure.me")!, keywords: ["Swift", "iOS", "OSX"], group: .Tech)

func reflectableSubject<T>(_ subject: Any, hasPropertyWithName name: String, ofType type: T.Type) -> Bool {
    let mirror = Mirror(reflecting: subject)

    guard let propertyChild = mirror.children.first(where: { name == ($0.label ?? "") }) else {
        return false
    }

    let propertyChildValueMirror = Mirror(reflecting: propertyChild.value)

    return (propertyChildValueMirror.subjectType == type.self)
}

let hasOptionalTitle = reflectableSubject(aBookmark, hasPropertyWithName: "title", ofType: Optional<String>.self)
let hasKeywords = reflectableSubject(aBookmark, hasPropertyWithName: "keywords", ofType: [String].self)
