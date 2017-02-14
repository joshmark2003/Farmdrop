//
//  ProducerCell.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit
//import SDWebImage

class ProducerCell: UITableViewCell {

    //MARK: - IBOutlet

    @IBOutlet weak var lblProducerName: UILabel!
    @IBOutlet weak var lblProducerDescription: UILabel!
    @IBOutlet weak var containerView: UIView!

    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCellWithProducer(producer: Producer) {
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {

            self.containerView.layer.shadowRadius = 1.0
            self.containerView.layer.shadowOpacity = 0.2
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.containerView.layer.shadowPath = UIBezierPath(rect: self.containerView.bounds).cgPath
        })
        
        lblProducerName.text = producer.producerName
        
        lblProducerDescription.text = producer.producerShortDescription
    }
}
