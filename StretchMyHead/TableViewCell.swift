//
//  TableViewCell.swift
//  StretchMyHead
//
//  Created by Tyler Boudreau on 2018-05-21.
//  Copyright © 2018 Tyler Boudreau. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    var newsItem: NewsItem?{
        didSet{
            if let item = newsItem{
                categoryLabel.text = item.category.toString()
                categoryLabel.textColor = item.category.toColor()
                headlineLabel.text = item.headline
            }else{
                categoryLabel.text = nil
                headlineLabel.text = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
