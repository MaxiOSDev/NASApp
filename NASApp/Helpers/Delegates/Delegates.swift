//
//  Delegates.swift
//  NASApp
//
//  Created by Max Ramirez on 4/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol PageNumberDelegate: class {
    func getPageNumber(_ number: Int?)
}

protocol BackButtonDelegate {
    func backButtonTapped()
}

protocol AssignedControllerDelegate {
    func assginedController(_ controller: RoverPageController)
}

































