//
//  TableViewCell.swift
//  LocationTest
//
//  Created by LiuZhenbang on 15/9/24.
//  Copyright © 2015年 LiuZhenbang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!

    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    

    
    func initData(coffeeModel:CoffeeShopModel)
    {
        
        NameLabel.text = coffeeModel.Name as? String
        DistanceLabel?.text =  "Distance:\((coffeeModel.Distance))"
        AddressLabel.text = coffeeModel.Address as? String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
