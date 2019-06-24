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
class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private  var gifImageView: FLAnimatedImageView!

	func populateView(with url: String) {

		guard let gifUrl = URL (string: url) else {return}

		self.gifImageView.setImage(with: gifUrl)
//    gifImageView.sd_setShowActivityIndicatorView(true)
//      gifImageView.sd_setIndicatorStyle(.gray)
//       DispatchQueue.main.async {
//        self.gifImageView.sd_setImage(with: gifUrl, placeholderImage: UIImage(named: ""))
//        }
	}
	override func prepareForReuse() {
		gifImageView.image = nil
	}

}
