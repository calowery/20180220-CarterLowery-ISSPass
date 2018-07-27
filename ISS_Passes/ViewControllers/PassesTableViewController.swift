//
//  PassesTableViewController.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit
import CoreLocation

class PassesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    // Used to start getting the users location
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var issPasses: [PassTime] = []

    private let activityIndicator = ActivityIndicatorDisplay.sharedInstance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        setupLocationManager()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.locationManager.stopUpdatingLocation()
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
        self.refreshControl?.addTarget(self, action: #selector(PassesTableViewController.fetchISSPassData), for: .valueChanged)
    }
    
    private func setupLocationManager() {
        // If location services is enabled get the users location
        let authorizationStatus = CLLocationManager.authorizationStatus()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() && (authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways) {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @objc private func fetchISSPassData() {
        // Fetch the passes for the users location
        activityIndicator.showActivityIndicatory(uiView: self.view)
        OpenNotify.getPassTimes(lat: Float(self.currentLocation.coordinate.latitude), lon: Float(self.currentLocation.coordinate.longitude), alt: Float(self.currentLocation.altitude)) { (passes) in
            self.issPasses = passes
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.activityIndicator.hideActivityIndicatory()
                self.tableView.reloadData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            // stop location updating after location update has been retrieved
            self.locationManager.stopUpdatingLocation()
            fetchISSPassData()
            // restart location updating after a 30 sec time interval
            let _ = Timer(timeInterval: 30, repeats: false, block: { (_) in
                self.locationManager.startUpdatingLocation()
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.requestLocation()
            break
        default:
            //location services not enabled
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issPasses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "GenericTableCell") as? GenericTabelCell else {
            return UITableViewCell()
        }
        if let pass = self.issPasses[indexPath.row] as PassTime? {
            cell.setup(labelSet1: ["Timestamp:": DateUtility.sharedInstance.convertUnixTimeStampToDate(unixTimestamp: pass.risetime!)!], labelSet2: ["Duration:": pass.duration!])
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
