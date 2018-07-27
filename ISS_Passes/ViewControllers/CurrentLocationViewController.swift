//
//  CurrentLocationViewController.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit


class CurrentLocationViewController: UIViewController {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var currentPosition: ISSPosition? {
        didSet {
            DispatchQueue.main.async {
                self.setLabelText()
            }
        }
    }
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Start timer
        self.runTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchISSPosition()
    }
    
    private func setLabelText() {
        guard let position = self.currentPosition else {
            self.latitudeLabel.text = "";
            self.longitudeLabel.text = "";
            return
        }
        self.latitudeLabel.text = position.latitude;
        self.longitudeLabel.text = position.longitude;
    }
    
    private func runTimer() {
        //As per documentation the ISS-Now service a single client should try and keep polling to about once every 5 seconds.
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self,   selector: #selector(CurrentLocationViewController.fetchISSPosition), userInfo: nil, repeats: true)
    }
    
    @objc func fetchISSPosition() {
        //Fetch the ISS position form the service
        OpenNotify.getISSPosition { (position) in
            self.currentPosition = position
//            DispatchQueue.main.async {
//                self.setLabelText()
//            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Invalidate the timer
        timer.invalidate()
    }
}
