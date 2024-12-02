//
//  CollegesListViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit

class CollegesListViewController: UITableViewController {
    
    let collegesModel = NJCollegesModel.sharedInstance
    var colleges: [College] = []
    var selectedCollegeId: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colleges = collegesModel.njColleges
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }////////
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "College Cell", for: indexPath) as! CollegesListTableViewCell
        
        cell.collegeName.text = colleges[indexPath.row].name
        cell.collegeCity.text = collegesModel.formatAddress(input: colleges[indexPath.row].city) + ", NJ"

        let assetName = collegesModel.getImage(collegeName: colleges[indexPath.row].name)
        cell.collegeImage.image = UIImage(named:assetName)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollegeId = colleges[indexPath.row].id
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailSegue") {
            let destinationViewController = segue.destination as! CollegeDetailViewController
            destinationViewController.showCollegeId = selectedCollegeId
        }
        
    }
    
}
