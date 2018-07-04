//
//  TarotTableViewController.swift
//  Tarot
//
//  Created by Rodney Cocker on 10/5/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

protocol Refresh
{
    func refresh(card:MajorArcanaCard)
}

class TarotTableViewController: UITableViewController, UISearchResultsUpdating {

    var  tarotList:[MajorArcanaCard] = Model.sharedInstance.getSortedCardArray()
    
    var filteredTarotCards = [MajorArcanaCard]()
    
    let searchController = UISearchController(searchResultsController:nil)
    
    var currentCard:MajorArcanaCard?
    
    var delegate:Refresh?
    
    func updateSearchResults(for: UISearchController) {
       filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope:String = "All")
    {
        filteredTarotCards = tarotList.filter
        {
             tarot in return tarot.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text! != ""
        {
            return filteredTarotCards.count
        }
        return tarotList.count
    }

    func changeDataSource(indexPath: NSIndexPath) -> MajorArcanaCard
    {
        var card:MajorArcanaCard
        if searchController.isActive && searchController.searchBar.text! != ""
        {
            card = filteredTarotCards[indexPath.row]
        }
        else{
            card = tarotList[indexPath.row]
        }
        
        return card
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tarotCell", for: indexPath)
        
        let card:MajorArcanaCard = changeDataSource(indexPath: indexPath as NSIndexPath)

        cell.textLabel!.text = card.name
        cell.detailTextLabel!.text = String(card.hebrewLetter)

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        let card:MajorArcanaCard = changeDataSource(indexPath: indexPath as NSIndexPath)
        
        let detailVC = segue.destination as! TarotCardDetailViewController
        
        detailVC.cardName = card.imageName
        
    }
    
    override func tableView(_ tableView: UITableView , didSelectRowAt indexPath: IndexPath)
    {
        
        if searchController.isActive && searchController.searchBar.text! != ""
        {
            currentCard = filteredTarotCards[indexPath.row]
        }
        else{
            currentCard = tarotList[indexPath.row]
        }
        
        // This points to our detail View controller so we are setting the property on the detail view when we select a card in our master view.
        self.delegate?.refresh(card: currentCard!)
        
        if let detailViewController = self.delegate as? TarotCardDetailViewController
        {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }
    

}
