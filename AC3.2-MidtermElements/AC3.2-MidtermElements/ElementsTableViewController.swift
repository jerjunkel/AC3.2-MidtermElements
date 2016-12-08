//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Jermaine Kelly on 12/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    var elements: [Element] = []
    let nilValue:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.title = "Elements"
        getAllElements()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! ElementTableViewCell
        
        cell.element = elements[indexPath.row]
        return cell
    }
    
    //MARK:- Utitlies
    func getAllElements(){
        ApiRequestManager.manager.makeRequest(to: elementsEndpoint) { (data) in
            if let validData = data{
                self.elements = Element.makeElementObjs(from: validData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let elementVC = segue.destination as! DetailViewController
            if let index = self.tableView.indexPathForSelectedRow{
                elementVC.element = elements[index.row]
            }
        }
    }
    
}
