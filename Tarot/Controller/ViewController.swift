//
//  ViewController.swift
//  Tarot
//
//  Created by Rodney Cocker on 3/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var model:Model = Model()
    
    @IBOutlet weak var cardDescription: UILabel!
    
    @IBAction func respond(_ sender: Any)
    {
        cardDescription.text = model.respond()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
}

