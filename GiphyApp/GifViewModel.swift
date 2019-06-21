//
//  GifViewModel.swift
//  GiphyApp
//
//  Created by Shayan on 6/19/19.
//  Copyright © 2019 appxone. All rights reserved.
//
import Foundation

protocol  GifDelegate: class {
    
    func gifsSuccess()
    func gifsFailure(errorMessage: String)
    
}

class GifViewModel {
    
    weak var delegate: GifDelegate?
    init(delegate: GifDelegate) {
        self.delegate = delegate
    }
	var gifList : [GIF]?

	func getGifs(searchText: String, offset: Int, limit: Int)  {
		Providers.gifProvider.request(.getGifs(searchText: searchText, offset: offset, limit: limit)) { [weak self] (moyaResponse) in
			do {
				let gifList: [GIF] = try moyaResponse.decoded()
				self?.gifList = gifList
				//self?.gifList?.append(contentsOf: gifList)
				self?.delegate?.gifsSuccess()

			} catch {
				self?.delegate?.gifsFailure(errorMessage: error.localizedDescription)
			}

//			switch moyaResponse {
//			case let .success(moyaResponse):
//
//				if let responseDict = moyaResponse
//				//let gifList: [GIF] = try moyaResponse.decoded()
//
//			case let .failure(error):
//				self.delegate?.gifsFailure(errorMessage: error.localizedDescription)
//			}


		}
	}


}

