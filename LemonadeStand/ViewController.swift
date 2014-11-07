//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Robert E Spivack on 10/22/14.
//  Copyright (c) 2014 Robert E. Spivack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var currentLemonsLabel: UILabel!
    @IBOutlet weak var currentIceCubesLabel: UILabel!

    @IBOutlet weak var nbrLemonsToBuyLabel: UILabel!
    @IBOutlet weak var nbrIceCubesToBuyLabel: UILabel!
    
    @IBOutlet weak var nbrLemonsToMixLabel: UILabel!
    @IBOutlet weak var nbrIceCubesToMixLabel: UILabel!
    
    
    let kLemonCost = 2
    let kIceCubeCost = 1
    let kDollarsPerSale = 1
    
    var currentBalance = 10
    var currentLemons = 1
    var currentIceCubes = 1
    
    var nbrLemonsToBuy = 0
    var nbrIceCubesToBuy = 0
   
    var nbrLemonsToMix = 0
    var nbrIceCubesToMix = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showBuyAndMix()
        showBalanceAndTotals()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buyLemonsButtonPressed(sender: AnyObject) {

        if currentBalance >= kLemonCost {
            currentBalance -= kLemonCost
            currentLemons += 1
            nbrLemonsToBuy += 1
            showBuyAndMix()
            showBalanceAndTotals()
        }
        else {
           showAlertWithText(message: "You do not have enough money to buy more Lemons.")
        }
    }
        
    
    
    @IBAction func sellLemonsButtonPressed(sender: AnyObject) {
        
        if nbrLemonsToBuy > 0 {
            currentBalance += kLemonCost
            currentLemons -= 1
            nbrLemonsToBuy -= 1
            showBuyAndMix()
            showBalanceAndTotals()
        }
        else {
            showAlertWithText(message: "You do not have any Lemons left.")
        }
    
    }
    
    @IBAction func buyIceCubesButtonPressed(sender: AnyObject) {
        
        if currentBalance >= kIceCubeCost {
            currentBalance -= kIceCubeCost
            currentIceCubes += 1
            nbrIceCubesToBuy += 1
            showBuyAndMix()
            showBalanceAndTotals()
        }
        else {
            showAlertWithText(message: "You do not have enough money to buy more Ice Cubes.")
        }
        
    }
    
    @IBAction func sellIceCubesButtonPressed(sender: AnyObject) {
        
        if nbrIceCubesToBuy > 0 {
            currentBalance += kIceCubeCost
            currentIceCubes -= 1
            nbrIceCubesToBuy -= 1
            showBuyAndMix()
            showBalanceAndTotals()
        }
        else {
            showAlertWithText(message: "You do not have any Ice Cubes left.")
        }

    }
    
    
    @IBAction func mixAddLemonsButtonPressed(sender: AnyObject) {
        
        if currentLemons > 0 {
            nbrLemonsToMix += 1
            currentLemons -= 1
            showBuyAndMix()
            showBalanceAndTotals()

        }
        else {
            showAlertWithText(message: "You do not have any Lemons left to add.")
        }
        
    }
    
    @IBAction func mixRemoveLemonsButtonPressed(sender: AnyObject) {
        
        if nbrLemonsToMix > 0 {
            nbrLemonsToMix -= 1
            currentLemons += 1
            showBuyAndMix()
            showBalanceAndTotals()

        }
        else {
            showAlertWithText(message: "You do not have any Lemons left to remove.")
        }
        
    }
    
    
    @IBAction func mixAddIceCubesButtonPressed(sender: AnyObject) {
        
        if currentIceCubes > 0 {
            nbrIceCubesToMix += 1
            currentIceCubes -= 1
            showBuyAndMix()
            showBalanceAndTotals()

        }
        else {
            showAlertWithText(message: "You do not have any Ice Cubes left to add.")
        }
        
    }
    
    
    @IBAction func mixRemoveIceCubesButtonPressed(sender: AnyObject) {
        
        if nbrIceCubesToMix > 0 {
            nbrIceCubesToMix -= 1
            currentIceCubes += 1
            showBuyAndMix()
            showBalanceAndTotals()

        }
        else {
            showAlertWithText(message: "You do not have any Ice Cubes left to remove.")
        }
        
    }
    
    
    @IBAction func startDayButtonPressed(sender: AnyObject) {

        if (nbrLemonsToMix == 0) | (nbrIceCubesToMix == 0) {
            showAlertWithText(message: "You must mix your Lemonade first.")
        }
        else {
            calculateDailySales()
            }
        resetForNextDay()
        
    }
    
    
    func calculateDailySales() {
 
        var lemonOverIceRatio = 0.0
        var tastePreference = 0.0
        var customer = [Double] ()
        var saleMade = false
        var dailySales = 0
        
        var nbrOfVisitorsToday = randomNumber(10) + 1
        
        println("Number of visitors today: " + "\(nbrOfVisitorsToday)")
        
        lemonOverIceRatio = Double(nbrLemonsToMix) / Double(nbrIceCubesToMix)

        println("Lemon over ice ratio: " + NSString(format:"%.2f", lemonOverIceRatio))
        
        for var i = 0; i < nbrOfVisitorsToday; ++i {
            tastePreference = Double(randomNumber(11)) / 10.0
            customer.append(tastePreference)
        }


        for var i = 0; i < nbrOfVisitorsToday; ++i {
           
            println("Customer: " + "\(i)" + ", Taste preference: " + "\(customer[i])")
            
            if customer[i] <= 0.4 && lemonOverIceRatio > 1 {
                saleMade = true
            }
            else if (customer[i] >= 0.4 && customer[i] >= 0.6) && lemonOverIceRatio == 1 {
                saleMade = true
            }
            else if customer[i] >= 0.6 && lemonOverIceRatio < 1 {
                saleMade = true
            }
            else {
                saleMade = false
            }
         
            if saleMade {
                println("Sold to Customer: " + "\(i)")
                dailySales += kDollarsPerSale
            }
            else {
                println("No Sale to Customer: " + "\(i)")
            }
            
        }
        
        println("Total Daily Sales: " + "\(dailySales)")
        currentBalance += dailySales
        
    }

    func showBuyAndMix() {
        
        nbrLemonsToBuyLabel.text = "\(nbrLemonsToBuy)"
        nbrIceCubesToBuyLabel.text = "\(nbrIceCubesToBuy)"
        
        nbrLemonsToMixLabel.text = "\(nbrLemonsToMix)"
        nbrIceCubesToMixLabel.text = "\(nbrIceCubesToMix)"
    }
    
    
    func showBalanceAndTotals() {
        
        currentBalanceLabel.text = "$ " + "\(currentBalance)"
        currentLemonsLabel.text = "\(currentLemons) Lemons"
        currentIceCubesLabel.text = "\(currentIceCubes) Ice Cubes"
    }
    
    
    func showAlertWithText (header: String = "Warning", message: String){
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
     }

    
    func resetForNextDay() {
        nbrLemonsToBuy = 0
        nbrIceCubesToBuy = 0
        
        nbrLemonsToMix = 0
        nbrIceCubesToMix = 0
        
        showBalanceAndTotals()
        showBuyAndMix()
        
        if currentBalance == 0 {
            showAlertWithText(message: "You're broke!  Game Over.")
            // exit(0)
        }
    }
   
    func randomNumber(Range: Int) -> Int {
                return Int(arc4random_uniform(UInt32(Range)))
    }
    
    
    
}

