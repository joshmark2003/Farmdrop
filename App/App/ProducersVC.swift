//
//  ProducersVC.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class ProducersVC: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var imgConstraint: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Constants.httpRequestManager.requestForProducers(page: 3) { (dictionaryResponse) in
        
            Constants.producerManager.addProducers(arrProducers: (dictionaryResponse["response"] as! NSArray))

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UITableViewDelegate Methods
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellHeader", for: indexPath) 
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellProducer", for: indexPath) as! ProducerCell
            
//            let currentRecipe = arrRecipes[(indexPath as NSIndexPath).row]
//            
//            cell.updateCellWithRecipe(currentRecipe)
            
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
//        
//        let cell = cell as! ProductTableViewCell
//        
//        if (indexPath as NSIndexPath).section != 0 {
//            
//            setCellImageOffset(cell, indexPath: indexPath)
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            return
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return 532
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
