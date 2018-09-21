//
//  ViewController.swift
//  HSBZoomView
//
//  Created by Red on 09/21/2018.
//  Copyright (c) 2018 Red. All rights reserved.
//

import UIKit
import HSBZoomView

class ViewController: UIViewController {

	let imageView: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "mario"))
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: HSBZoomViewDataSource {
	
	func hsbZoomView(view: HSBZoomView) -> UIView {
		
		let imageView = UIImageView(image: #imageLiteral(resourceName: "mario"))
		imageView.contentMode = .scaleAspectFit
		return imageView
	}
}

extension ViewController: HSBZoomViewDelegate {
	
	func hsbZoomViewWillBeginZooming(view: HSBZoomView) {
		print("hsbZoomViewWillBeginZooming")
	}
	
	func hsbZoomViewDidEndZooming(view: HSBZoomView) {
		print("hsbZoomViewDidEndZooming")
	}
}

