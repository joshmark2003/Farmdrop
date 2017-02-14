//
//  Constants.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//


struct Constants {
    
    struct URL {
        static let BaseUrl = "https://fd-v5-api-release.herokuapp.com/2/producers"
    }
    
    static let httpRequestManager = NetworkRequest()
    
    static let producerManager = ProducerManager()
}
