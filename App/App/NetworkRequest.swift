//
//  NetworkRequest.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class NetworkRequest: NSObject {

    func requestForProducers(page: Int, completion: @escaping (_ dictionaryResponse: NSDictionary) -> Void) {
        
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
                            
                            completion(dictionary)
                        }
                    }
                    
                } catch {
                    
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                }
            } else {
                
                DispatchQueue.main.async {
                    
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}
