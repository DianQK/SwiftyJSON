//
//  JSONError.swift
//  SwiftyJSON
//
//  Created by DianQK on 11/11/2016.
//
//

import Foundation

public enum JSONError: Error {
    case mismatch(key: String, json: JSON)
    case mismatchType(expect: Type, result: Type, json: JSON)
//    case other(error: Error)
}

extension JSONError: Equatable {
    public static func ==(lhs: JSONError, rhs: JSONError) -> Bool {
        switch (lhs, rhs) {
        case let (.mismatch(lkey, ljson), .mismatch(rkey, rjson)):
            return lkey == rkey && ljson == rjson
        case let (.mismatchType(lexpect, lresult, ljson), .mismatchType(rexpect, rresult, rjson)):
            return lexpect == rexpect && lresult == rresult && ljson == rjson
        default:
            return false
        }
    }
}

extension JSON {
    public func json(_ path: JSONSubscriptType...) throws -> JSON {
        let json = self[path]
        if let error = json.error {
            throw error
        }
        if let _ = json.null {
            throw JSONError.mismatch(key: path.map { String(describing: $0) }.joined(separator: "."), json: self)
        }
        return json
    }
}

extension JSON {

    public func bool(_: Void = ()) throws -> Bool {
        guard let bool = self.bool else {
            throw JSONError.mismatchType(expect: Type.bool, result: self.type, json: self)
        }
        return bool
    }

    public func string(_: Void = ()) throws -> String {
        guard let string = self.string else {
            throw JSONError.mismatchType(expect: Type.string, result: self.type, json: self)
        }
        return string
    }

    public func number(_: Void = ()) throws -> NSNumber {
        guard let number = self.number else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return number
    }

    public func url(_: Void = ()) throws -> URL {
        guard let url = self.url else {
            throw JSONError.mismatchType(expect: Type.string, result: self.type, json: self)
        }
        return url
    }

    public func double(_: Void = ()) throws -> Double {
        guard let double = self.double else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return double
    }

    public func float(_: Void = ()) throws -> Float {
        guard let float = self.float else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return float
    }

    public func int(_: Void = ()) throws -> Int {
        guard let int = self.int else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return int
    }

    public func uInt(_: Void = ()) throws -> UInt {
        guard let uInt = self.uInt else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return uInt
    }

    public func int64(_: Void = ()) throws -> Int64 {
        guard let int64 = self.int64 else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return int64
    }

    public func uInt64(_: Void = ()) throws -> UInt64 {
        guard let uInt64 = self.uInt64 else {
            throw JSONError.mismatchType(expect: Type.number, result: self.type, json: self)
        }
        return uInt64
    }

}
