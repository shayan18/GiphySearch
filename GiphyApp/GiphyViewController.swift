//
//  ViewController.swift
//  GiphySearch
//
//  Created by Invision-MacBookPro-shayan on 18/06/2019.
//  Copyright © 2019 Invision-MacBookPro-F011. All rights reserved.
//

import UIKit
class GiphyViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
        
//    "http://api.giphy.com/v1/gifs/search?q=ryan+gosling&api_key=YOUR_API_KEY&limit=5"

	}
}

extension GiphyViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.giphyCell, for: indexPath) as? GiphyCollectionViewCell else {return UICollectionViewCell()}

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

	}
}


extension GiphyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
