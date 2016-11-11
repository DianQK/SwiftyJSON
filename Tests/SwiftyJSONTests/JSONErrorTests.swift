//
//  JSONErrorTests.swift
//  SwiftyJSON
//
//  Created by DianQK on 11/11/2016.
//
//

import XCTest
import SwiftyJSON

class JSONErrorTests: XCTestCase {

    // TODO: -

    func testMatchKey() {

        let json: JSON = [
            "key1": "value1",
            "key2": 1,
        ]

        do {
            let key1 = try json.json("key1")
            XCTAssert(true)
            let value1 = try key1.string()
            XCTAssertEqual(value1, "value1")
        } catch {
            XCTAssert(false)
        }

        do {
            let key2 = try json.json("key2")
            XCTAssert(true)
            let _ = try key2.string()
            XCTAssert(false)
        } catch let error as JSONError {
            XCTAssertEqual(error, JSONError.mismatchType(expect: Type.string, result: Type.number, json: 1))
        } catch {
            XCTAssert(false)
        }


    }
}
