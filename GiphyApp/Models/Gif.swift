//
//  Gif.swift
//  GiphyApp
//
//  Created by Invision-MacBookPro-shayan on 21/06/2019.
//  Copyright © 2019 appxone. All rights reserved.


import Foundation

// MARK: - GIF
struct GIF: Codable {
	let images: Images?
}

// MARK: - Images
struct Images: Codable {
	let downsized: Downsized?
}

// MARK: - Downsized
struct Downsized: Codable {
	let url: String?
	let width, height, size: String?
}
