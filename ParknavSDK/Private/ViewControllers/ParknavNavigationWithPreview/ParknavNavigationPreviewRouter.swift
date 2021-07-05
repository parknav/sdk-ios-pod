//
//  ParknavNavigationPreviewRouter.swift
//  ParknavSDK
//

import UIKit

@objc protocol ParknavNavigationPreviewRoutingLogic {}

protocol ParknavNavigationPreviewDataPassing {}

class ParknavNavigationPreviewRouter: ParknavNavigationRouter, ParknavNavigationPreviewRoutingLogic,
                                          ParknavNavigationPreviewDataPassing {}
