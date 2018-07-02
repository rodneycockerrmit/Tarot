//
//  TarotCardDetailViewController.swift
//  Tarot
//
//  Created by Rodney Cocker on 2/7/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class TarotCardDetailViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    
    var cardName:String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cardImage.image = UIImage(named: cardName!)
        // Do any additional setup after loading the view.
    }
}
