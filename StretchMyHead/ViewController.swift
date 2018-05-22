//
//  ViewController.swift
//  StretchMyHead
//
//  Created by Tyler Boudreau on 2018-05-21.
//  Copyright © 2018 Tyler Boudreau. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 80.0
var headerMaskLayer: CAShapeLayer!

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    override var prefersStatusBarHidden: Bool{
        return true
    }
    var headerView: UIView!
    
    let items = [NewsItem(category: .World, headline: "Climate change protests, divestments meet fossil fuels realities"),
                 NewsItem(category: .Europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
                 NewsItem(category: .MiddleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
                 NewsItem(category: .Africa, headline: "Nigeria says 70 dead in building collapse questions S. Africa victim claim"),
                 NewsItem(category: .AsiaPacific, headline: "Despite UN ruling, Japan seeks backing for whale hunting"),
                 NewsItem(category: .Americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
                 NewsItem(category: .World, headline: "South Africa in $40 billion deal for Russian nuclear reactors"),
                 NewsItem(category: .Europe, headline: "One million babies' created by EU student exchanges"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 140
        
        headerView = myTableView.tableHeaderView
        myTableView.tableHeaderView = nil
        myTableView.addSubview(headerView)
        
        myTableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        myTableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        myTableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0 )
        myTableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        let today = Date(timeInterval: 0, since: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
        dateLabel.text = "\(dateFormatter.string(from: today))"
        
        updateHeaderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.newsItem = item
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: UIScrollView Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    //MARK: Custom Methods
    
    func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: myTableView.bounds.width, height: kTableHeaderHeight)
        if myTableView.contentOffset.y < -kTableHeaderHeight{
            headerRect.origin.y = myTableView.contentOffset.y
            headerRect.size.height = -myTableView.contentOffset.y
        }
        headerView.frame = headerRect
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        headerRect = CGRect(x: 0, y: -effectiveHeight, width: myTableView.bounds.width, height: kTableHeaderHeight)
        if myTableView.contentOffset.y < -effectiveHeight{
            headerRect.origin.y = myTableView.contentOffset.y
            headerRect.size.height = -myTableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
    }


}

