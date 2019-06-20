//
//  GifViewModel.swift
//  GiphyApp
//
//  Created by Shayan on 6/19/19.
//  Copyright © 2019 appxone. All rights reserved.
//
import Foundation
import GiphyCoreSDK
protocol  GifDelegate: class {
    
    func gifaSuccess()
    func gifsFailure(errorMessage: String)
    
}

class GifViewModel {
    
    weak var delegate: GifDelegate?
    init(delegate: GifDelegate) {
        self.delegate = delegate
    }
    func getGifs(searchText: String, offset: Int) {
       
        Providers.authProvider.request(.login(userEmail: userEmail, password: password)) { (
            moyaResponse) in
            switch moyaResponse {
                
            case let .success(moyaResponse):
                let jsonDict = JSON.init(moyaResponse.data)
                
                if  moyaResponse.statusCode == 200 {
                    let loginResponse = LoginResponse(json: jsonDict)
                    CurrentUser.shared =   loginResponse.user
                    CurrentUser.settings = loginResponse.settings
                    CurrentUser.accessToken = loginResponse.accesstoken
                    if let str = CurrentUser.shared?.completed?.replacingOccurrences(of: "%", with: "") {
                        CurrentUser.completeness = str.floatValue
                    }
                    self.delegate?.loginSuccess()
                }
                else {
                    self.delegate?.loginFailure(errorMessage: jsonDict["error"]["message"].string ?? "Error in signing in, Please try again".localized() )
                }
                
                
                
            case let .failure(error):
                self.delegate?.loginFailure(errorMessage: error.localizedDescription)
            }
        }
    }
}

