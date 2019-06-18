//
//  ViewController.swift
//  GiphySearch
//
//  Created by Invision-MacBookPro-shayan on 18/06/2019.
//  Copyright © 2019 Invision-MacBookPro-F011. All rights reserved.
//

import UIKit
import GiphyCoreSDK
class GiphyViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var searchTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		let op = GiphyCore.shared.search("cats") { (response, error) in

			if let error = error as NSError? {
				// Do what you want with the error
			}

			if let response = response, let data = response.data, let pagination = response.pagination {
				print(response.meta)
				print(pagination)
				for result in data {
					print(result)
				}
			} else {
				print("No Results Found")
			}
		}

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

