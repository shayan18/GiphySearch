//
//  GiphyDataSource.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 21/06/2019.
//  Copyright © 2019 appxone. All rights reserved.
//

import UIKit

class GiphyDataSource: NSObject, UICollectionViewDataSource {

	var gifList = [GIF]()

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return gifList.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.giphyCell, for: indexPath) as? GiphyCollectionViewCell else {return UICollectionViewCell()}
            cell.populateView(with: gifList[indexPath.row].images?.downsized?.url ?? "")
            
            return cell
		
	}
	
}
