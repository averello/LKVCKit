//
//  LightKVC.swift
//  LKVCKit
//
//  Created by Georges Boumis on 15/06/2016.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//

import Foundation

public protocol LightKVC {
    func value(forKey key: String) throws -> Any
    mutating func set(value: Any?, forKey key: String) throws

    mutating func set(valuesForKeysWithDictionary dictionary: [String : Any])
    func set(value: Any?, forUndefinedKey key: String)
}

public extension LightKVC {
    public mutating func set(valuesForKeysWithDictionary dictionary: [String : Any]) {
        for (key, value) in dictionary {
            do {
                try self.set(value: value, forKey: key)
            } catch {
                self.set(value: value, forUndefinedKey: key)
            }
        }
    }

    public func set(value: Any?, forUndefinedKey key: String) {
        LKVCUndefinedKeyRespondingStrategy(key: key, value: value).handle(self)
    }

    public func value(forKey key: String) throws -> Any {
        throw LightKVCError.undefinedKey(key: key, value: nil)
    }

    public mutating func set(value: Any?, forKey key: String) throws {
        throw LightKVCError.undefinedKey(key: key, value: value)
    }
}
