//
//  FYBottomRefreshView.swift
//  PullToRefreshDemo
//
//  Created by kun wang on 2018/5/25.
//  Copyright © 2018年 Yalantis. All rights reserved.
//

import Foundation
import UIKit

class FYBottomRefreshView: UIView, FYRefreshViewProtocol {
    
    fileprivate(set) var titles = [State.KEY.initial: State.KEY.initial.defaultTitle,
                                   State.KEY.releasing: State.KEY.releasing.defaultTitle,
                                   State.KEY.loading: State.KEY.loading.defaultTitle]
 
    func setTitle(title: String, state: State.KEY) {
        titles[state] = title
    }
 
    func changeTitle(_ state: State) {
        titleLabel.text = titles[state.key]
 
        titleLabel.sizeToFit()
    }
    
    override var tintColor: UIColor! {
        didSet {
            activityIndicator.color = tintColor
            titleLabel.textColor = tintColor
        }
    }
    
    fileprivate(set) lazy var activityIndicator: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        self.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    fileprivate(set) lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.backgroundColor = .clear
        label.textColor = UIColor(red: 0.471, green: 0.510, blue: 0.569, alpha: 1.00)
        self.addSubview(label)
        return label
    }()
 
    override func layoutSubviews() {
        centerView()
        setupFrame(in: superview)
        super.layoutSubviews()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        centerView()
        setupFrame(in: superview)
    }
}

fileprivate extension FYBottomRefreshView {
    
    func setupFrame(in newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: superview.frame.width, height: frame.height)
    }
    
    func centerView() {
        titleLabel.center = convert(center, from: superview)
        activityIndicator.center = CGPoint(x: titleLabel.center.x - titleLabel.frame.size.width/2 - 20, y: titleLabel.center.y)
    }
}

