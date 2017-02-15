//
//  NetworkRequest.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class NetworkRequest: NSObject {

    func requestForProducers(page: Int, completion: @escaping (_ dictionaryResponse: NSDictionary, _ error: NSError?) -> Void) {
                
        let request = NSMutableURLRequest(url: URL(string: Constants.URL.BaseUrl.appending("?page=\(page)&per_page_limit=10"))!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20.0
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            if let _ = response, let data = data {
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    if let dictionary = object as? NSDictionary {
                        
                        DispatchQueue.main.async {
                            
                            completion(dictionary, error as? NSError)
                        }
                    }
                    
                } catch {
                    
                    DispatchQueue.main.async {
                        
                        completion([:], error as NSError)

                        print(error.localizedDescription)
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    
                    completion([:], error as? NSError)

                    print(error?.localizedDescription as Any)
                }
            }
        }
        
        task.resume()
    }
    
    func requestForProducerWithId(producerId: Int, completion: @escaping (_ dictionaryResponse: NSDictionary) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: Constants.URL.BaseUrl.appending("/\(producerId)"))!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20.0
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let _ = response, let data = data {
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    if let dictionary = object as? NSDictionary {
                        
                        DispatchQueue.main.async {
                            
                            completion(dictionary)
                        }
                    }
                    
                } catch {
                    
                    DispatchQueue.main.async {
                        
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    
                }
            }
        }
        
        task.resume()
    }
}
