//
//  TableViewController.swift
//  W6D3-QuotePro
//
//  Created by Murat Ekrem Kolcalar on 12/6/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var quote: Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell") as? QuoteCell else { return QuoteCell() }
        
        cell.quoteLabel.text = self.quote.quoteText
        cell.authorLabel.text = "- " + self.quote.quoteAuthor
        
        return cell
    }

}
