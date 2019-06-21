//
//  ViewController.swift
//  GiphySearch
//
//  Created by Invision-MacBookPro-shayan on 18/06/2019.
//  Copyright © 2019 Invision-MacBookPro-F011. All rights reserved.
//

import UIKit
class GiphyViewController: UIViewController {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var collectionView: UICollectionView!

	private lazy var gifViewModel = GifViewModel(delegate: self)
	private let gifDataSource = GiphyDataSource()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.collectionView.dataSource = gifDataSource
	}

	private func fetchGifs(searchText: String) {
		gifViewModel.getGifs(searchText: searchText, offset: Constants.offset, limit: Constants.limit)

	}
	

}

extension GiphyViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let singleItemWidth = ((collectionView.frame.size.width)/2)-10
		return CGSize(width: singleItemWidth, height: singleItemWidth)

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

	}

}



extension GiphyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		fetchGifs(searchText: searchBar.text!)
	}
}

extension GiphyViewController: GifDelegate {
	func gifsSuccess() {
		guard let gifList = gifViewModel.gifList else {return}

		gifDataSource.gifList = gifList
		collectionView.reloadData()
		self.view.endEditing(true)
	}
	func gifsFailure(errorMessage: String) {
		print(errorMessage)
	}
}
