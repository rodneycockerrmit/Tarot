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
    var card:MajorArcanaCard?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cardImage.image = UIImage(named: (card?.imageName)!)
        // Do any additional setup after loading the view.
    }
}

extension TarotCardDetailViewController: Refresh
{
    func refresh(card: MajorArcanaCard)
    {
        self.loadView()
        self.card = card
        cardImage.image = UIImage(named: (card.imageName))
    }
}
