//
//  LoadingView.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 26/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    public func hide() {
        self.alpha = 0
        self.isHidden = true
        self.loader.stopAnimating()
    }

    public func show() {
        self.alpha = 1
        self.isHidden = false
        self.loader.startAnimating()
    }
}
