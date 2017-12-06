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
    
    var quote: Quote!
    
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
            guard let data = data, error == nil, urlResponse != nil else {
                print("wtf is wrong")
                return
            }
            print("download successful")
            do {
                let decoder = JSONDecoder()
                let quotes = try decoder.decode(Quote.self, from: data)
                self.quote = quotes
                
                DispatchQueue.main.async {
                    self.quoteLabel.text = quotes.quoteText
                    self.authorLabel.text = "- " + quotes.quoteAuthor
                }
                
            }
            catch {
                print("FUCK")
            }
        }.resume()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TableViewController
        {
            if segue.identifier == "segueToSave" {
                let vc = segue.destination as? TableViewController
                vc?.quote = self.quote
            }
        }
    }
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print("Save to gallery test")
        
//        let bounds = UIScreen.main.bounds
//        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
//        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func getQuoteButtonPressed(_ sender: Any) {
        downloadData()
    }
    
    @IBAction func getImageButtonPressed(_ sender: Any) {
        downloadImage()
    }
    
}
