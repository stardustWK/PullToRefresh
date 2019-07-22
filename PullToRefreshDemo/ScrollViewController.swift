//
//  ScrollViewController.swift
//  PullToRefreshDemo
//
//  Created by kun wang on 2019/06/28.
//  Copyright © 2019 Yalantis. All rights reserved.
//

import Foundation

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .red
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 200)
        scrollView.addPullToRefresh {
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.scrollView.endTopRefreshing()
            }
        }
    }
}
