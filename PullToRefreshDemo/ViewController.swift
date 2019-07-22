//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Anastasiya Gorban on 5/19/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

import PullToRefresh
import UIKit

private let PageSize = 20

class ViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    fileprivate var dataSourceCount = PageSize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPullToRefresh()
        tableView.setPullToRefreshTitle(subTitle: "进港11哥", state: .initial)
        tableView.setPullToRefreshTitle(subTitle: "进港11哥1121", state: .loading)
        tableView.setPullToRefreshTitle(subTitle: "进港11哥212", state: .releasing)
        tableView.setPullToRefreshTitle(subTitle: "进港11哥2dadadad1", state: .finished)
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    @IBAction fileprivate func startRefreshing() {
        tableView.startTopRefreshing()
    }
}

private extension ViewController {
    
    func setupPullToRefresh() {
        
        tableView.addPullToRefresh { [weak self] in
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self?.dataSourceCount = PageSize
                self?.tableView.endTopRefreshing()
            }
        }

        tableView.addInfiniteScrolling { [weak self] in
            let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self?.dataSourceCount += PageSize
                self?.tableView.reloadData()
                self?.tableView.endBottomRefreshing()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
        return cell
    }
}
