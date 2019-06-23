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
        self.collectionView.prefetchDataSource = self
	}
    
}

extension GiphyViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellDimension = ((collectionView.frame.size.width)/2)-10
        return CGSize(width: cellDimension, height: cellDimension)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == gifViewModel.gifList.count-1 {
            
            gifViewModel.currentQuery = searchBar.text!

        }
    }

}



extension GiphyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        gifViewModel.currentQuery = searchBar.text!

	}
}

extension GiphyViewController: GifDelegate {
	func gifsSuccess() {
//        guard let gifList = gifViewModel.gifList else {return}
        
        gifDataSource.gifList = gifViewModel.gifList
//        if gifViewModel.offset != 0 {
//            countsRows()
//
//        }
//        else {
//            self.collectionView.reloadData()
//        }
		self.collectionView.reloadData()
		self.view.endEditing(true)
	}
	func gifsFailure(errorMessage: String) {
		print(errorMessage)
	}
}

extension GiphyViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains {
            print($0.row)
           return $0.row >= gifViewModel.gifList.count-1  }
        
        if needsFetch {
        }
//        if needsFetch {
//            fetchNextPage()
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
