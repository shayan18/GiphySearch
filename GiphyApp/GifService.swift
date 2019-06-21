//
//  GifService.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 21/06/2019.
//  Copyright © 2019 appxone. All rights reserved.

import Foundation
import Moya

enum GifService {
	case getGifs(searchText: String, offset: Int, limit: Int)
}

extension GifService: TargetType {
    
    var baseURL: URL { return URL(string: Constants.baseUrl)! }
    
    var path: String {
        switch self {
        case .getGifs:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGifs:
            return .get
        }
    }
    
    var task: Task {
        switch self {

		case .getGifs(let searchText, let offset,let limit):
			return .requestParameters(parameters: ["q":searchText,"offset":offset,"limit":limit,"api_key":Constants.apiKey], encoding: URLEncoding.default)
       
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
