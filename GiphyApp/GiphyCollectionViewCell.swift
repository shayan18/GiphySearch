//
//  GiphyCollectionViewCell.swift
//  GiphySearch
//
//  Created by Invision-MacBookPro-shayan on 18/06/2019.
//  Copyright © 2019 Invision-MacBookPro-F011. All rights reserved.
//

import UIKit
import WebKit
import SDWebImage
import SwiftyGif
class GiphyCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak private var gifImageView: UIImageView!

	@IBOutlet weak var webView: WKWebView!
	func populateView(with url: String) {

		guard let gifUrl = URL (string: url) else {return}
		let requestObj = URLRequest(url: gifUrl)
		webView.load(requestObj)
		DispatchQueue.main.async {
		self.gifImageView.sd_setImage(with: gifUrl, placeholderImage: UIImage(named: ""))
		}


		//self.gifImageView.setGifFromURL(gifUrl)

	//	gifImageView.loadGif(url: "www.exampleurl.com/test.gif")


		//gifImageView.image

		DispatchQueue.main.async {
			let imageURL = UIImage.gifImageWithURL(url)
			self.gifImageView.image = imageURL
		}

	}
	override func prepareForReuse() {
		gifImageView.image = nil
	}

}
