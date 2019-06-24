//
//  Extension+UIViewController.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 24/06/2019.
//  Copyright © 2019 appxone. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
	/**
	Show alert on the calling view controller

	-parameter title
	-parameter messsage
	*/
	func showAlert(title:String? = "Error",message:String){
		let alertController=UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
			alertController.dismiss(animated: true, completion: nil)
		}
		alertController.addAction(okAction)
		self.present(alertController, animated: true, completion: nil)
	}
}
