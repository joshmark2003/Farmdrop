//
//  ProducersDetailsVC.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class ProducersDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var currentProducer: Producer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = currentProducer.producerName
        
        updateView()

        //Update current producer

        Constants.httpRequestManager.requestForProducerWithId(producerId: currentProducer.producerId) { (dictionaryResponse) in
            
            Constants.producerManager.addProducers(arrProducers: ([dictionaryResponse["response"] as! NSDictionary]))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        
        lblLocation.text = currentProducer.producerLocation
        
        lblDescription.text = currentProducer.producerDescription
        
        collectionView.reloadData()
    }
    
    //MARK: - UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return currentProducer.producerImages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imgProducer = cell.viewWithTag(1) as! UIImageView
        
        // Download and set the image.
        if let dictImage = (currentProducer.producerImages?[indexPath.row] as! NSDictionary)["path"] {
            
            let url = NSURL(string: dictImage as! String)
            
            imgProducer.sd_setImage(with: url as URL!, placeholderImage: UIImage(named: "LemonCrustedSalmon"), options: SDWebImageOptions.retryFailed, completed: { (image, error, cacheType, url) in
                
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 198)
    }
}
