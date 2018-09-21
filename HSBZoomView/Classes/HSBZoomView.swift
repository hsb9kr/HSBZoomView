//
//  HSBZoomView.swift
//  ImageViewZoomSwift
//
//  Created by hsb9kr on 2017. 10. 31..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

import UIKit

@objc public protocol HSBZoomViewDataSource {
    @objc func hsbZoomView(view: HSBZoomView) -> UIView
}

@objc public protocol HSBZoomViewDelegate {
    @objc optional func hsbZoomViewWillBeginZooming(view: HSBZoomView)
    @objc optional func hsbZoomViewDidEndZooming(view: HSBZoomView)
}

public class HSBZoomView: UIView {
    @IBOutlet public weak var dataSource: HSBZoomViewDataSource?
    @IBOutlet public weak var delegate: HSBZoomViewDelegate?
	public let scrollView = UIScrollView()
	open fileprivate(set) var view = UIView() {
		willSet {
			view.removeFromSuperview()
		}
	}
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
	
	override public func layoutSubviews() {
        super.layoutSubviews()
        guard !scrollView.isZooming else {
            return
        }
        reload()
    }
    
    //MARK: Private
    fileprivate func initialize() {
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.bouncesZoom = true
        addSubview(scrollView)
		delegate?.hsbZoomViewWillBeginZooming?(view: self)
    }
    
    func reload() {
		
        if let aView = dataSource?.hsbZoomView(view: self), view != aView {
            view = aView
        }
        
        if view.superview == nil {
            scrollView.addSubview(view)
        }
        
        scrollView.frame = bounds
        scrollView.contentSize = bounds.size
        view.frame = bounds
    }
    
}

extension HSBZoomView {
    @IBInspectable var minimumZoomScale: CGFloat {
        get {
            return scrollView.minimumZoomScale
        }
        
        set {
            scrollView.minimumZoomScale = newValue
        }
    }
    
    @IBInspectable var maximumZoomScale: CGFloat {
        get {
            return scrollView.maximumZoomScale
        }
        
        set {
            scrollView.maximumZoomScale = newValue
        }
    }
}

extension HSBZoomView: UIScrollViewDelegate {
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return view
    }
    
	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        delegate?.hsbZoomViewWillBeginZooming?(view: self)
        scrollView.layer.masksToBounds = false
    }
    
	public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            scrollView.zoomScale = 1
        }) { (finished) in
            scrollView.layer.masksToBounds = true
            self.delegate?.hsbZoomViewDidEndZooming?(view: self)
        }
    }
}

