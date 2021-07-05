//
//  ParknavDisplayLogic.swift
//  ParknavSDK
//

import Foundation

protocol ParknavDisplayLogic: AnyObject {
    func displayNavigation(viewModel: ParknavNavigation.State.ViewModel)
    func displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel)
    func displayStopNavigation()
    func displayError(_ error: NSError)
}
