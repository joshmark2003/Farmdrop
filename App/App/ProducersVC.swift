//
//  ProducersVC.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class ProducersVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var arrProducers = [Producer]()
    
    var currentPage = 1
    var totalPages = 1

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //load alreay stored producers from coreData before any network request
        arrProducers = Constants.producerManager.getAllProducers() as! [Producer]

        getProducersWithPageNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProducersWithPageNumber() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        Constants.httpRequestManager.requestForProducers(page: currentPage) { (dictionaryResponse: NSDictionary) in
            
            self.currentPage = dictionaryResponse.value(forKeyPath: "pagination.current") as! Int
            
            self.totalPages = dictionaryResponse.value(forKeyPath: "pagination.pages") as! Int

            //Add producer in coreData for offline use
            Constants.producerManager.addProducers(arrProducers: (dictionaryResponse["response"] as! NSArray))
            
            self.arrProducers = Constants.producerManager.getAllProducers() as! [Producer]
            
            self.tableView.reloadData()
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    //MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! ProducerCell
        
        let indexPath: IndexPath = tableView.indexPath(for: cell)!
        
        let producer = arrProducers[(indexPath as NSIndexPath).row]
        
        let detailVc = segue.destination as! ProducersDetailsVC
        
        detailVc.currentProducer = producer
    }

    //MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            arrProducers = Constants.producerManager.getAllProducers() as! [Producer]

        } else {
            
            arrProducers = Constants.producerManager.getProducerWithName(name: searchText) as! [Producer]
        }
        
        tableView.reloadSections(IndexSet(integer: tableView.numberOfSections-1), with: UITableViewRowAnimation.automatic)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        
        arrProducers = Constants.producerManager.getAllProducers() as! [Producer]

        tableView.reloadSections(IndexSet(integer: tableView.numberOfSections-1), with: UITableViewRowAnimation.automatic)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    //MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if searchBar.isFirstResponder {
            
            searchBar.resignFirstResponder()
        }
    }
    
    //MARK: - UITableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrProducers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellProducer", for: indexPath) as! ProducerCell
            
            let currentProducer = arrProducers[(indexPath as NSIndexPath).row]
//
            cell.updateCellWithProducer(producer: currentProducer)
        
        //Load more tips
        if indexPath.row == arrProducers.count - 1 && totalPages != currentPage && (searchBar.text?.isEmpty)! {
            
            currentPage += 1
            
            getProducersWithPageNumber()
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            return
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 532
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
