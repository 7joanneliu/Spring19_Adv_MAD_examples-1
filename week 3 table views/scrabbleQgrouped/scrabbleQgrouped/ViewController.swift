//
//  ViewController.swift
//  scrabbleQgrouped
//
//  Created by Aileen Pierce
//  Copyright © 2018 Aileen Pierce. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allwords = [QnoU]()
    var letters = [String]()
    var data = DataController()
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.loadData()
        allwords=data.getQnoUWords()
        letters=data.getLetters()
        
        //search results
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.allwords = allwords
        resultsController.letters = letters
        searchController = UISearchController(searchResultsController: resultsController) //create a search controller and initialize with our SearchResultsController instance
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        //searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
    }
    
    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allwords[section].words.count
    }

    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let wordsSection = allwords[section].words
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleIdentifier", for: indexPath)
        cell.textLabel?.text = wordsSection[indexPath.row]
        return cell
    }
    
    //UITableViewDelegate method that is called when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let wordsSection = allwords[section].words
        let alert = UIAlertController(title: "Row selected", message: "You selected \(wordsSection[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }

    // configures the table header
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerview = view as! UITableViewHeaderFooterView
        headerview.textLabel?.font = UIFont(name: "Helvetica", size: 20)
        headerview.textLabel?.textAlignment = .center
    }

    //UITableViewDatasource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letters.count
    }
    
    //Sets the header value for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.headerView(forSection: section)?.textLabel?.textAlignment = NSTextAlignment.center
        return letters[section]
    }
    
    //adds a section index    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letters
    }

    //configures a custom view for the section headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UITableViewHeaderFooterView()
        var myView:UIImageView
        if section == 0 {
            myView = UIImageView(frame: CGRect(x: 10, y: 8, width: 40, height: 40))
        } else {
            myView = UIImageView(frame: CGRect(x: 10, y: -10, width: 40, height: 40))
        }
        let myImage = UIImage(named: "scrabbletile90")
        myView.image = myImage
        headerview.addSubview(myView)
        return headerview
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

