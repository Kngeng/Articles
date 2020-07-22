//
//  ProgressView.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    private lazy var indicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private weak var presentingView : UIView?
    private weak var presentingVC : UIViewController?
    private var allowModalPresentationChange: Bool = true
    private var isShowing : Bool {
        if presentingView == nil {
            return false
        } else {
            return !indicatorView.isHidden
        }
    }
    
    private var hasShownBerore = false
    private var isModalInPresentation: Bool = false {
        didSet {
            if allowModalPresentationChange, #available(iOS 13.0, *) {
                presentingVC?.isModalInPresentation = isModalInPresentation
            }
        }
    }
    
    init(with view: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        layer.cornerRadius = 8
        layer.masksToBounds = true;
        alpha = 0.5
        backgroundColor  = UIColor.gray
        presentingView = view
        addSubview(indicatorView)
        indicatorView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
    }
    
    convenience init(with vc: UIViewController, allowModalPresentationChange: Bool = true) {
        self.init(with: vc.view)
        self.presentingVC = vc
        self.allowModalPresentationChange = allowModalPresentationChange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show() {
        DispatchQueue.main.async {
            self.presentingVC?.navigationController?.view.isUserInteractionEnabled = false
            self.presentingView?.addSubview(self)
            self.presentingView?.isUserInteractionEnabled = false
            self.indicatorView.startAnimating()
            self.indicatorView.isHidden = false
            self.hasShownBerore = true
            self.isModalInPresentation = true
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.presentingVC?.navigationController?.view.isUserInteractionEnabled = true
            self.presentingView?.isUserInteractionEnabled = true
            self.removeFromSuperview()
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.isModalInPresentation = false
        }
    }
}
