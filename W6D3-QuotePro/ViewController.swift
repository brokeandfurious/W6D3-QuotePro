//
//  ViewController.swift
//  W6D3-QuotePro
//
//  Created by Murat Ekrem Kolcalar on 12/6/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    final let url = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
    final let imgUrl = URL(string: "http://lorempixel.com/400/600/")

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        downloadImage()
    }
    
    func downloadImage() {
        guard let downloadURL = imgUrl else { return }
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            guard let data = data, error == nil, urlResponse != nil else {
                print("can't get image")
                return
            }
            print("omg got the image")
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }

        }.resume()
    }
    
    func downloadData() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            print("test")
            guard let data = data, error == nil, urlResponse != nil else {
                print("wtf is wrong")
                return
            }
            print("download successful")
            do {
                let decoder = JSONDecoder()
                let quotes = try decoder.decode(Quote.self, from: data)
                
                DispatchQueue.main.async {
                    self.quoteLabel.text = quotes.quoteText
                    self.authorLabel.text = quotes.quoteAuthor
                }
                
//                print(quotes.quoteText)
            }
            catch {
                print("FUCK")
            }
        }.resume()
        
    }

}
