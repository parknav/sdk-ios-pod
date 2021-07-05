//
//  ParkingChancePresenter.swift
//  ParknavSDK
//

import UIKit
import CoreLocation

protocol ParkingChancePresentationLogic: AnyObject {
    func presentReceneteredMap(_ coordinates: CLLocationCoordinate2D)
}

class ParkingChancePresenter: ParkingChancePresentationLogic {
  weak var viewController: ParkingChanceDisplayLogic?

  // MARK: - ParkingChancePresentationLogic

    func presentReceneteredMap(_ coordinates: CLLocationCoordinate2D) {
        viewController?.displayRecenteredMap(coordinates)
    }
}
