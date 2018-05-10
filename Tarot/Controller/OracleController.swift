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
    
    @IBOutlet weak var faded: UILabel!
    
    @IBOutlet weak var placeHolder: UIView!
    
    @IBOutlet weak var detailedDescription: UILabel!
    
    @IBOutlet weak var imgCard: UIImageView!
    
    @IBOutlet weak var btnOracle: UIButton!
    
    // Properties to support showing/hiding elements
    // when the card is flipped.
    var showingBack = false
    var front:UIImageView!
    var back:UIImageView!
    var cardView: UIView!
    var direction: UIViewAnimationOptions = UIViewAnimationOptions.transitionFlipFromLeft
    var attributedString:NSMutableAttributedString?
    
    
    // Used to only flip once the first card has been revealed
    var gesturesRegistered: Bool = false
    
    
    @IBAction func respond(_ sender: Any)
    {
        cardDescription.text = model.respond()

        imgCard.image = UIImage(named: model.currentCard.imageName)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        faded.isHidden = true
        detailedDescription.isHidden = true
        imgCard.image = UIImage(named: "MajorArcana.jpg")
        registerGestures()
    }
    
    // Register gestures for swiping the card left and right
    fileprivate func registerGestures()
    {
        // Only register the gestures after the user has clicked on the 'Ask Oracle' button
        // Only register the gestures once
        if(!gesturesRegistered)
        {
            gesturesRegistered = true
            
            /* Set up flipping behaviour. For the flipping behaviour to work a subview must be added to the item to be flipped.
             Here I used an additional image view so I can show the currently selected card on the back but it will be faded.
             I hide both of these, so it doesn't matter what you set it to.*/
            front = UIImageView(image: UIImage(named: "Fool.jpg"))
            back = UIImageView(image: UIImage(named: "Fool.jpg"))
            placeHolder.addSubview(back)
            back.isHidden = true
            front.isHidden = true
            
            // Create the gesture and set the handler
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(OracleController.handleSwipes(_:)))
            
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(OracleController.handleSwipes(_:)))
            
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            
            // Add the gestures to the placeholder
            placeHolder.addGestureRecognizer(swipeLeft)
            placeHolder.addGestureRecognizer(swipeRight)
        }
    }
    
    // Determine direction of swipe
    @objc func handleSwipes (_ sender:UISwipeGestureRecognizer)
    {
        if (sender.direction == .left)
        {
            direction = UIViewAnimationOptions.transitionFlipFromRight
        }
        if (sender.direction == .right)
        {
            direction = UIViewAnimationOptions.transitionFlipFromLeft
        }
        showCard(direction)
    }
    
    // Setup card for display
    fileprivate func showCard(_ direction: UIViewAnimationOptions)
    {
        if (!showingBack)
        {
            UIView.transition(from: front, to: back, duration: 1, options: direction, completion: nil)
            showingBack = true
            // Change the image in the UIImageView to the currently selected card
            imgCard.image = UIImage(named:model.currentCard.imageName)
            detailedDescription.isHidden = false
            detailedDescription.text = model.currentCard.getCardDescription()
            
            cardDescription.isHidden = true
            faded.isHidden = false
            btnOracle.isHidden = true
            
            formatText()
        }
        else
        {
            UIView.transition(from: back, to: front, duration: 1, options: direction, completion: nil)
            
            showingBack = false
            
            cardDescription.isHidden = false
            faded.isHidden = true
            detailedDescription.isHidden = true
            btnOracle.isHidden = false
        }
    }
    
    fileprivate func formatText()
    {
        applyFormattingToText()
        applyHighlightsToText()
        
        detailedDescription.attributedText = attributedString
    }
    
    
    func applyFormattingToText()
    {
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        
        let attributes = [NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font : font]
        
        attributedString = NSMutableAttributedString(string: model.currentCard.getCardDescription(), attributes: attributes)
    }
    
    func applyHighlightsToText()
    {
        guard attributedString == nil else
        {
            // 1. Create a range that equals the length of the string that contains the text to be highlighted
            let range = NSMakeRange(0, (self.attributedString?.length)!)
            
            // 2. Match items surrounded by single quotation marks
            let regexStr = "(\\'\\w+(.\\s\\w+)*\\')"
            let regex = try! NSRegularExpression(pattern: regexStr, options: [])
            
            // 3. Create attributes to apply to the text
            let colourAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1)]
            
            // 4. iterate over each match, making the text red
            regex.enumerateMatches(in: (attributedString?.string)!, options: [], range: range)
            {
                match, flags, stop in let matchRange = match!.range(at: 1)
                self.attributedString?.addAttributes(colourAttributes, range: matchRange)
            }
            return
        }
    }
    
    
}

