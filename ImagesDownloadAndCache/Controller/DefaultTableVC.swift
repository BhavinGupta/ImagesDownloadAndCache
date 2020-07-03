//
//  ViewController.swift
//  ImagesDownloadAndCache
//
//  Created by Bhavin Gupta on 02/07/20.
//  Copyright © 2020 Bhavin Gupta. All rights reserved.
//

import UIKit

class DefaultTableVC: UITableViewController {
  
  var refreshCtrl: UIRefreshControl!
  var restManager = RestManager()
  let cellId = "DefaultCell"
  var rows: [Rows] = []
  
  //MARK:- View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Registering Cell
    self.tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: cellId)
    
    // Setting row height and estimated row height for dynamic height
    tableView.estimatedRowHeight = 100.0
    tableView.rowHeight = UITableView.automaticDimension
    
    // Setup Referesh Control
    self.refreshCtrl = UIRefreshControl()
    self.refreshCtrl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
    self.refreshControl = self.refreshCtrl
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // First Service Call
    restManager.getJson(completionHandler: { (response) in
      self.settingUpDataForTableview(response: response)
    })
  }
  
  //MARK:- Refresh TableView
  @objc func refreshTableView(){
    // Attemp to Refresh
    restManager.getJson(completionHandler: { (response) in
      self.settingUpDataForTableview(response: response)
    })
  }
  
  //MARK:- Setting Up Data for Table View
  func settingUpDataForTableview(response: Response){
    DispatchQueue.main.async(execute: { () -> Void in
      self.rows = response.rows
      self.title = response.title
      self.tableView.reloadData()
      self.refreshControl?.endRefreshing()
    })
  }
  
  //MARK:- View Will Transition Orientation Change Method
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    DispatchQueue.main.async(execute: { () -> Void in
      self.tableView.reloadData()
      self.refreshControl?.endRefreshing()
      self.tableView.layoutIfNeeded()
    })
  }
}

//MARK:- Data Source Methods
extension DefaultTableVC {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return self.rows.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                             for: indexPath) as! DefaultTableViewCell
    
    let rowModel = self.rows[indexPath.row]
    cell.rows = rowModel
    return cell
  }
}
