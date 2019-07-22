//
//  FYViewAnimator.swift
//  PullToRefreshDemo
//
//  Created by kun wang on 2018/5/25.
//  Copyright © 2018年 Yalantis. All rights reserved.
//

import Foundation
import CoreGraphics
 
class FYTopViewAnimator: RefreshViewAnimator {
    fileprivate let refreshView: FYTopRefreshView
    
    init(refreshView: FYTopRefreshView) {
        self.refreshView = refreshView
    }
    
    func animate(_ state: State) {
        switch state {
        case .initial:
            refreshView.activityIndicator.stopAnimating()
        case .releasing(let progress):
            refreshView.activityIndicator.isHidden = false
            var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: progress, y: progress)
            transform = transform.rotated(by: CGFloat(Double.pi) * progress * 2)
            refreshView.activityIndicator.transform = transform
        case .loading:
            refreshView.activityIndicator.startAnimating()
        default: break
        }
        refreshView.changeTitle(state)
    }
}

class FYBottomViewAnimator: RefreshViewAnimator {
    
    fileprivate let refreshView: FYBottomRefreshView
    
    init(refreshView: FYBottomRefreshView) {
        self.refreshView = refreshView
    }
    
    func animate(_ state: State) {
        switch state {
        case .initial:
            refreshView.activityIndicator.stopAnimating()
            
        case .releasing(let progress):
            refreshView.activityIndicator.isHidden = false
            
            var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: progress, y: progress)
            transform = transform.rotated(by: CGFloat(Double.pi) * progress * 2)
            refreshView.activityIndicator.transform = transform
            
        case .loading:
            refreshView.activityIndicator.startAnimating()
            
        default: break
        }
        refreshView.changeTitle(state)
    }
}
