//
//  ElementTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Jermaine Kelly on 12/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    let cellIdentifier: String = "elementCell"
    var element: Element!{
        didSet{
            setupCell()
        }
    }
    @IBOutlet weak var elementDetail: UILabel!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(){

        self.elementName.text = element.name
        self.elementDetail.text = "\(element.symbol)(\(element.number!)) \(element.weight!)"
        
        ApiRequestManager.manager.makeRequest(to: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png") { (data) in
            if let data = data{
                DispatchQueue.main.async {
                    self.elementImage.image = UIImage(data: data)
                    self.elementImage.setNeedsDisplay()
                }
            }
            
        }
    }
    
    
}
