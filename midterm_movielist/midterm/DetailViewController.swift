//
//  DetailViewController.swift
//  midterm
//
//  Created by Ziyang Yang on 3/14/19.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var detailDescriptionLabel: UILabel!
	@IBOutlet weak var webView: WKWebView!
	@IBOutlet weak var webSpinner: UIActivityIndicatorView!
	

	func configureView() {
		// Update the user interface for the detail item.
		if let detail = detailItem {
		    if let label = detailDescriptionLabel {
		        label.text = detail.description
				loadWebPage(detail.description)
		    }
		}
	}
	
	func loadWebPage(_ urlString: String){
		//the urlString should be a propery formed url
		//creates a URL object
		let myurl = URL(string: urlString)
		//create a URLRequest object
		let request = URLRequest(url: myurl!)
		//load the URLRequest object in our web view
		webView.load(request)
	}
	
	//WKNavigationDelegate method that is called when a web page begins to load
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		webSpinner.startAnimating()
	}
	
	//WKNavigationDelegate method that is called when a web page loads successfully
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		webSpinner.stopAnimating()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		webView.navigationDelegate = self
		// Do any additional setup after loading the view, typically from a nib.
		configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	var detailItem: AnyObject? {
		didSet {
		    // Update the view.
		    configureView()
		}
	}


}

