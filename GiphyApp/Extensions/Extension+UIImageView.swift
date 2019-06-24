//
//  Extension+UIImageView.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 24/06/2019.
//  Copyright © 2019 appxone. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView {

	func setImage(with url: URL) {
		self.sd_setShowActivityIndicatorView(true)
		self.sd_setIndicatorStyle(.gray)
		DispatchQueue.main.async {
			self.sd_setImage(with: url)
		}

	}
}
