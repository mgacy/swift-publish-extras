//
//  PathUtilsTests.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 10/23/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

@testable import PublishExtras
import Publish
import XCTest

final class PathUtilsTests: XCTestCase {}

// MARK: - Prepend
extension PathUtilsTests {
    func testPrependEmptyPath() {
        let pathComponent = ""
        var path = Path("path")
        path.prependComponent(pathComponent)

        XCTAssertEqual(path, "path")
    }

    func testPrependToHTTP() {
        let pathComponent = "component"
        var path = Path("http://example.com")
        path.prependComponent(pathComponent)

        XCTAssertEqual(path, "http://example.com")
    }

    func testPrependToHTTPS() {
        let pathComponent = "component"
        var path = Path("https://example.com")
        path.prependComponent(pathComponent)

        XCTAssertEqual(path, "https://example.com")
    }

    func testPrependSlashHandling() {
        let pathComponent = "/component/"
        var path = Path("/path/")
        path.prependComponent(pathComponent)

        XCTAssertEqual(path, "component/path/")
    }

    func testPrepend() {
        let pathComponent = "component"
        var path = Path("path")
        path.prependComponent(pathComponent)

        XCTAssertEqual(path, "component/path")
    }
}

// MARK: - Prepending
extension PathUtilsTests {
    func testPrependingEmptyPath() {
        let pathComponent = ""
        let path = Path("path")
        let result = path.prependingComponent(pathComponent)

        XCTAssertEqual(result, "path")
    }

    func testPrependingToHTTP() {
        let pathComponent = "component"
        let path = Path("http://example.com")
        let result = path.prependingComponent(pathComponent)

        XCTAssertEqual(result, "http://example.com")
    }

    func testPrependingToHTTPS() {
        let pathComponent = "component"
        let path = Path("https://example.com")
        let result = path.prependingComponent(pathComponent)

        XCTAssertEqual(result, "https://example.com")
    }

    func testPrependingSlashHandling() {
        let pathComponent = "/component/"
        let path = Path("/path/")
        let result = path.prependingComponent(pathComponent)

        XCTAssertEqual(result, "component/path/")
    }

    func testPrepending() {
        let pathComponent = "component"
        let path = Path("path")
        let result = path.prependingComponent(pathComponent)

        XCTAssertEqual(result, "component/path")
    }
}
