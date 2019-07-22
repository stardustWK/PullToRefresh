//
//  UIScrollView+FGPullToRefresh.swift
//  PullToRefreshDemo
//
//  Created by kun wang on 2018/5/25.
//  Copyright © 2018年 Yalantis. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
    public class func pulltoRefreshResourceBundle() -> Bundle {
        if let url = resourceBundle() {
            return Bundle.init(url: url) ?? Bundle.main
        } else {
            return Bundle.main
        }
    }

    private class func resourceBundle() -> URL? {
        let bundle = Bundle(for: FYTopViewAnimator.self)
        return bundle.url(forResource: "FYPullToRefreshResource", withExtension: "bundle")
    }
}

extension String {
    var pullToRefreshlocalized: String {
        let string = NSLocalizedString(self, tableName: "PullToRefreshLocalized", bundle: Bundle.pulltoRefreshResourceBundle(), value: "", comment: "")
        return string
    }
}

public extension State {
    enum KEY: String {
        case initial
        case finished
        case loading
        case releasing
        
        var defaultTitle: String {
            switch self {
            case .initial:
                return "kInitialStateTitle".pullToRefreshlocalized
            case .releasing:
                return "kReleasingStateTitle".pullToRefreshlocalized
            case .loading:
                return "kLoadingStateTitle".pullToRefreshlocalized
            case .finished:
                return "kFinishedStateTitle".pullToRefreshlocalized
            }
        }
        
        
    }
    var key : KEY {
        switch self {
        case .initial: return KEY.initial
        case .finished: return KEY.finished
        case .loading: return KEY.loading
        case .releasing(_): return KEY.releasing
        }
    }
}
