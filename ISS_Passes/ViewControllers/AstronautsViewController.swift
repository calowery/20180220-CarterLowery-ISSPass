//
//  AstronautsViewController.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit

class AstronautsViewController: UITableViewController {
    
    var spaceMen: [SpaceMan] = []
    
    private let activityIndicator = ActivityIndicatorDisplay.sharedInstance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        fetchAstronautData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView(){
        // Setup for the table view
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let genericCell = UINib(nibName: "GenericTableCell", bundle: nil)
        self.tableView.register(genericCell, forCellReuseIdentifier: "GenericTableCell")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(AstronautsViewController.fetchAstronautData), for: .valueChanged)
    }
    
    @objc private func fetchAstronautData() {
        // Fetch the passes for the users location
        activityIndicator.showActivityIndicatory(uiView: self.view)
        OpenNotify.getSpaceMen(completion: { (passes) in
            self.spaceMen = passes
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.activityIndicator.hideActivityIndicatory()
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spaceMen.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableCell") as? GenericTabelCell else {
            return UITableViewCell()
        }
        if let astronaut = self.spaceMen[indexPath.row] as SpaceMan? {
            cell.setup(labelSet1: ["Name:": astronaut.name!], labelSet2: ["Craft:": astronaut.craft!])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}

