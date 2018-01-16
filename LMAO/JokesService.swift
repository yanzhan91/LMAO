//
//  MyCardsService.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class JokesService {
    
    let user_id = UIDevice.current.identifierForVendor!.uuidString
    
    func getJokes(completionHandler: @escaping (Array<Joke>, Error?) -> Void) {
        RestApiManager.sharedInstance.getResponse() { (json, error) in
            
            var jokes = [Joke]()
            json?.array?.forEach() { jsonJoke in
                let joke = Joke(
                    fromRating: jsonJoke["rating"].rawString()!,
                    fromJoke: jsonJoke["joke"].rawString()!
                )
                jokes.append(joke)
            }
            
            completionHandler(jokes, error)
        }
    }
}
