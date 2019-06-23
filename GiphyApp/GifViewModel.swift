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
	var gifList = [GIF]()
    var offset = 0
    private var isLoadingData = false
	func getGifs(searchText: String, offset: Int, limit: Int)  {
		Providers.gifProvider.request(.getGifs(searchText: searchText, offset: offset, limit: limit)) { [weak self] (moyaResponse) in
			do {
				let gifList: [GIF] = try moyaResponse.decoded()
				//self?.gifList = gifList
                
                self?.gifList.append(contentsOf: gifList.map{$0})
				//self?.gifList?.append(contentsOf: gifList)
				self?.delegate?.gifsSuccess()

			} catch {
				self?.delegate?.gifsFailure(errorMessage: error.localizedDescription)
			}
            
            self?.isLoadingData = false


		}
	}
    // setting previousQuery propery
    var previousQuery:String? {
        
        didSet {
            offset = 0
            gifList.removeAll()
        }
    }
    
    var currentQuery : String? {
        
        didSet {
            
            if currentQuery != previousQuery {
                previousQuery = currentQuery
            }
            else {
                
                offset += 20
            }
            updateGifList()
        }
    }
    
    func updateGifList(){
        // is loadingData true showing that server request still in process
        if isLoadingData{ return }
        //if query is nil or empty searchMovies will use discoveryMovies route to get best movies
        
        if currentQuery == nil || currentQuery!.isEmpty{
            
            
            
        }
        else{
            getGifs(searchText: currentQuery!, offset: offset, limit: Constants.limit)
            
        }
        //request in a way, set isLoadingData true
        self.isLoadingData = true
    }


}

