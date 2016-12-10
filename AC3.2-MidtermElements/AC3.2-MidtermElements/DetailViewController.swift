//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Jermaine Kelly on 12/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var element: Element!
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var yearFoudLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    @IBAction func addToFavroties(_ sender: UIButton) {
        let myFav: [String:String] = ["my_name": "Jermaine Kelly",
                                      "favorite_element": element.symbol]
        
        let httpBody = ApiRequestManager.manager.makeHTTPBody(dict: myFav)
        ApiRequestManager.manager.makeRequest(to: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", method: .post, body: httpBody) { (_) in
            
        }
    }
    
    func setUpView(){
        
        if let number = element.number{
            self.elementNumber.text = String(number)
        }else{
            self.elementNumber.text = "--"
        }
        
        if let boilingpoint = element.boilingPoint{
            self.boilingPointLabel.text = String(boilingpoint)
        }else{
            self.boilingPointLabel.text = "null"
        }
        
        if let meltingPoint = element.meltingPoint{
            self.meltingPointLabel.text = String(meltingPoint)
        }else{
            self.meltingPointLabel.text = "null"
        }
        
        if let weight = element.weight{
            self.weightLabel.text = String(weight)
        }else{
            self.weightLabel.text = "null"
        }
        self.title = element.name
        self.yearFoudLabel.text = String(element.discoveryYear )
        self.symbolLabel.text = element.symbol
        
        ApiRequestManager.manager.makeRequest(to: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol).png") { (data) in
            if let data = data{
                DispatchQueue.main.async {
                    self.elementImage.image = UIImage(data: data)
                    self.elementImage.setNeedsDisplay()
                }
            }
        }
    }

}
