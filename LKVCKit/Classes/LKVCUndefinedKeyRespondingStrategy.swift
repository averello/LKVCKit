//
//  LKVCUndefinedKeyRespondingStrategy.swift
//  LKVCKit
//
//  Created by Georges Boumis on 2/10/2016.
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
import Ents

internal struct LKVCUndefinedKeyRespondingStrategy {
	private let key: String
	private let value: Any?

	init(key: String, value: Any?) {
		self.key = key
		self.value = value
	}

	internal func handle(_ object: Any) {
		let message = "\"\(type(of: (object) as Any))\"'s key: \"\(key)\" is undefined! We are in DEBUG mode so we CRASH!"
		DebugReleaseBlock(debug: {
            Foundation.Thread.callStackSymbols.forEach { symbol in
                print("\t\(symbol.1)")
            }
			fatalError(message)
			}, release: {
                print(message)
                Foundation.Thread.callStackSymbols.forEach { symbol in
                    print("\t\(symbol.1)")
                }
		})
	}
}
