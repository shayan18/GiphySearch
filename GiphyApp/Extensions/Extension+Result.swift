//
//  Extension+Result.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 21/06/2019.
//  Copyright © 2019 appxone. All rights reserved.
//

import Foundation
import Moya
import Result
extension Result {
	func resolve() throws -> Value {
		switch self {
		case .success(let value):
			return value
		case .failure(let error):
			throw error
		}
	}
}
extension Result where Value == Moya.Response {
	func decoded<T: Decodable>(keypath: String = "data") throws -> T {
		let decoder = JSONDecoder()
		let response = try resolve()
		return try response.map(T.self, atKeyPath: keypath, using: decoder, failsOnEmptyData: true)
	}
}
