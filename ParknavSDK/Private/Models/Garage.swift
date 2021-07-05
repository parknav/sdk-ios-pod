//
//  Garage.swift
//  ParknavSDK

import Foundation
import CoreLocation

struct Garage {
    var name = ""
    var geometry: CLLocationCoordinate2D?
    var address = ""
    var distance: Double = 0
    var garageId = ""
    var city = ""
    var spots: Int = 0
    var dynamic: Bool = true
    var price: Double = 0

    // swiftlint:disable identifier_name
    var type: ParknavRouteOptions.GarageType = .garage
    var postalCode = ""
    var hours = ""
//    var typesSpotsPrices = [TypeSpotPrice]()
    var maxWidth: Int = 0
    var maxHeight: Int = 0
    var paymentMethods = [ParknavRouteOptions.PaymentMethod]()
    var currency = ""
    var women: Int = 0
    var handicapped: Int = 0
    var ev: Int = 0
    var friendly: Int = 0
    var control = [ParknavRouteOptions.PaymentControl]()
    var maxTime: Int = 0
    var url = ""
    // swiftlint:enable identifier_name
}
