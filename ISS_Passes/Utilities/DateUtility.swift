//
//  DateUtility.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

class DateUtility {
    
    static let sharedInstance  = DateUtility()
    
    /** Converts a Unix timestamp into a date based on the users timezone.
        - parameter unixTimestamp: The Unix timestamp to be converted.
        - returns: The string value of the converted date.
     */
    func convertUnixTimeStampToDate(unixTimestamp: String) -> String? {
        var newDate: String?
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        if let timestamp = Double(unixTimestamp) {
            let convertedDate = Date(timeIntervalSince1970: timestamp)
            newDate = dateFormatter.string(from: convertedDate)
        }
        
        return newDate;
    }
    
}
