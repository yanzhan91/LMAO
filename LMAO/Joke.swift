//
//  Joke.swift
//  appyQuote
//
//  Created by Zhiyi Yang on 12/28/17.
//  Copyright © 2017 Nicola Canali. All rights reserved.
//

import Foundation

class Joke {
    let rating: String
    let joke: String
    
    init(fromRating rating: String, fromJoke joke: String) {
        self.rating = rating
        self.joke = joke
    }
}
