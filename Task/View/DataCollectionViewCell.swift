//
//  DataCollectionViewCell.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var symbolLable: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI(_ object:DataStruct){
        symbolLable.text = object.symbol
        priceLabel.text = "\(String(format: "%.2f", object.priceChange))%"
        
        switch object.category.lowercased() {
        case "l":
            backView.backgroundColor = UIColor.init(hex: hexColorConstants.Long)
            break
            
        case "lu":
            backView.backgroundColor = UIColor.init(hex: hexColorConstants.LongU)
            break
            
        case "s":
            backView.backgroundColor = UIColor.init(hex: hexColorConstants.Short)
            break
            
        case "sc":
            backView.backgroundColor = UIColor.init(hex: hexColorConstants.ShortC)
            break
            
        default:
            break
        }
        
    }
    
}
