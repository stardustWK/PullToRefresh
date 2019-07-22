//
//  FYTopRefreshView.swift
//  PullToRefreshDemo
//
//  Created by kun wang on 2018/5/25.
//  Copyright © 2018年 Yalantis. All rights reserved.
//

import Foundation
import UIKit

protocol FYRefreshViewProtocol {
    func setTitle(title: String, state: State.KEY)
    func setSubTitle(subTitle: String, state: State.KEY)
    func changeTitle(_ state: State)
}

extension FYRefreshViewProtocol {
    func setSubTitle(subTitle: String, state: State.KEY) { }
}

class FYTopRefreshView: UIView, FYRefreshViewProtocol {
    
    fileprivate(set) var titles = [State.KEY.initial:   State.KEY.initial.defaultTitle,
                                   State.KEY.releasing: State.KEY.releasing.defaultTitle,
                                   State.KEY.loading:   State.KEY.loading.defaultTitle,
                                   State.KEY.finished:  State.KEY.finished.defaultTitle]
    fileprivate(set) var subTitles = [State.KEY : String]()
    
    fileprivate(set) var lastActionDate: Date?
    
    func getDefaultSubTitle() -> String {
        if let date = lastActionDate {
            let df = DateFormatter()
            df.locale = Locale.current
            df.dateStyle = .short
            df.timeStyle = .short
            return "kDefaultSubTitle".pullToRefreshlocalized + df.string(from: date)
        } else {
            return "kDefaultSubTitleNever".pullToRefreshlocalized
        }
    }

    func setTitle(title: String, state: State.KEY) {
        titles[state] = title
    }
    
    func setSubTitle(subTitle: String, state: State.KEY) {
        subTitles[state] = subTitle
    }
    
    func changeTitle(_ state: State) {

        if subTitles.isEmpty {
            subTitleLabel.text = getDefaultSubTitle()
            titleLabel.text = titles[state.key]
        } else {
            subTitleLabel.text = subTitles[state.key]
            titleLabel.text = (titles[state.key] ?? "") + "(" + getDefaultSubTitle() + ")"
        }
        
        if state == .finished {
            lastActionDate = Date()
        }
        
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
    }
    
    override var tintColor: UIColor! {
        didSet {
            activityIndicator.color = tintColor
            titleLabel.textColor = tintColor
            subTitleLabel.textColor = tintColor
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
    
    fileprivate(set) lazy var subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.184, green: 0.239, blue: 0.325, alpha: 1.00)
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

fileprivate extension FYTopRefreshView {
    
    func setupFrame(in newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: superview.frame.width, height: frame.height)
    }
    
    func centerView() {
        let point = convert(center, from: superview)
        titleLabel.center = CGPoint(x: point.x, y: point.y - titleLabel.frame.size.height/2 - 3)
        activityIndicator.center = CGPoint(x: titleLabel.center.x - titleLabel.frame.size.width/2 - 20, y: titleLabel.center.y)
        subTitleLabel.center = CGPoint(x: point.x, y: point.y + subTitleLabel.frame.size.height/2 + 3)
    }
}
