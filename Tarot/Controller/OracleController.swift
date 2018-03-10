//
//  ViewController.swift
//  Tarot
//
//  Created by Rodney Cocker on 3/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class OracleController: UIViewController
{
    var model:Model = Model()
    
    @IBOutlet weak var cardDescription: UILabel!
    
    
    @IBOutlet weak var imgCard: UIImageView!
    
    
    @IBAction func respond(_ sender: Any)
    {
        cardDescription.text = model.respond()

        imgCard.image = UIImage(named: model.currentCard.imageName)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
}

