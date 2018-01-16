//
//  RestApiManager.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import SwiftyJSON
import Alamofire

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    func getResponse(completionHandler: @escaping (JSON?, Error?) -> Void) {
        Alamofire.request(
            URL(string: "https://f5r4oe8zwb.execute-api.us-east-2.amazonaws.com/dev")!,
            method: HTTPMethod.get,
            encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) -> Void in
                if response.result.isFailure {
                    completionHandler([:], response.result.error)
                } else {
                    let json = JSON(response.result.value!)
                    completionHandler(json, response.result.error)
                }
        }
    }
}
