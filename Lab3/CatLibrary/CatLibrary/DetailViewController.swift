//
//  DetailViewController.swift
//  CatLibrary
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBAction func share(_ sender: UIBarButtonItem) {
		var imageArray = [UIImage]()
		imageArray.append(imageView.image!)
		let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
		shareScreen.modalPresentationStyle = .popover
		//shareScreen.popoverPresentationController?.barButtonItem
		present(shareScreen, animated: true, completion: nil)
	}
	
	
	var imageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if let name = imageName {
			imageView.image = UIImage(named: name)
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
