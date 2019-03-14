//
//  Movie.swift
//  midterm
//
//  Created by Ziyang Yang on 3/14/19.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation


class Movie {
	var name: String
	var url: String
	
	//MARK: Initialization
	
	init?(name: String, url: String) {
		
		// Initialization should fail if there is no name or there is no url
		if name.isEmpty || url.isEmpty {
			return nil
		}
		
		// Initialize stored properties.
		self.name = name
		self.url = url
		
	}
}
