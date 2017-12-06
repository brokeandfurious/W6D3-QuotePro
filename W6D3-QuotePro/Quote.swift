//
//  Quote.swift
//  W6D3-QuotePro
//
//  Created by Murat Ekrem Kolcalar on 12/6/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

import UIKit

class Quote: Codable {

    let quoteText: String
    let quoteAuthor: String
    let quoteLink: String
    
    init(quoteText: String, quoteAuthor: String, quoteLink: String) {
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
        self.quoteLink = quoteLink
    }
    
}
