//
//  ParknavMapStyles.swift
//  ParknavSDK
//

import Foundation
import MapboxNavigation

class ParknavDayStyle: DayStyle {
    private var parknavRouteOptions = ParknavRouteOptions.instance

    init(_ parknavRouteOptions: ParknavRouteOptions) {
        self.parknavRouteOptions = parknavRouteOptions
        super.init()
        if let dayStyle = parknavRouteOptions.dayStyle?.URL {
            mapStyleURL = URL(string: dayStyle) ?? mapStyleURL
        }
        styleType = .day
        guard let colorsScheme = parknavRouteOptions.dayStyle?.colorsScheme else {return}
        statusBarStyle = colorsScheme.statusBarStyle

        UIApplication.shared.statusBarStyle = colorsScheme.statusBarStyle
    }

    required init() {
        super.init()
    }

    // swiftlint:disable function_body_length
    override func apply() {
        super.apply()
        NavigationMapView.appearance().routeCasingColor = .clear
        guard let colorsScheme = parknavRouteOptions.dayStyle?.colorsScheme else {return}
        BannerContainerView.appearance().backgroundColor = colorsScheme.bottomBannerColor
        BottomBannerView.appearance().backgroundColor = colorsScheme.bottomBannerColor
        InstructionsBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        TopBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor

        NavigationMapView.appearance().tintColor = colorsScheme.routeColor

        NavigationMapView.appearance().trafficSevereColor = colorsScheme.routeColor
        NavigationMapView.appearance().trafficHeavyColor = colorsScheme.routeColor

        LineView.appearance().lineColor = colorsScheme.routeColor
        TimeRemainingLabel.appearance().trafficUnknownColor = colorsScheme.instructionsBannerColor
        UserPuckCourseView.appearance().fillColor = colorsScheme.bottomBannerColor
        WayNameLabel.appearance().backgroundColor = colorsScheme.wayNameColor
        WayNameView.appearance().backgroundColor = colorsScheme.wayNameColor
        UserPuckCourseView.appearance().fillColor = colorsScheme.userLocationFillColor
        UserPuckCourseView.appearance().puckColor = colorsScheme.userLocationPuckColor

        PrimaryLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor
            = colorsScheme.primaryLabelColor
        PrimaryLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor
            = colorsScheme.primaryLabelColor
        NextInstructionLabel.appearance().normalTextColor = colorsScheme.primaryLabelColor
        NextBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor

        ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).primaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).secondaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).primaryColor = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).secondaryColor = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).primaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).secondaryColor
            = colorsScheme.primaryLabelColor

        DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).unitTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).valueTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).unitTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).valueTextColor
            = colorsScheme.primaryLabelColor
        StepInstructionsView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        StepsBackgroundView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        StepTableViewCell.appearance().backgroundColor = colorsScheme.instructionsBannerColor

        FloatingButton.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    // swiftlint:enable function_body_length
}

class ParknavNightStyle: NightStyle {
    private var parknavRouteOptions = ParknavRouteOptions.instance

    init(_ parknavRouteOptions: ParknavRouteOptions) {
        self.parknavRouteOptions = parknavRouteOptions
        super.init()
        if let nightStyle = parknavRouteOptions.nightStyle?.URL {
            mapStyleURL = URL(string: nightStyle) ?? mapStyleURL
        }
        styleType = .night
        guard let colorsScheme = parknavRouteOptions.nightStyle?.colorsScheme else {return}
        statusBarStyle = colorsScheme.statusBarStyle
    }

    required init() {
        super.init()
    }

    // swiftlint:disable function_body_length
    override func apply() {
        super.apply()
        NavigationMapView.appearance().routeCasingColor = .clear
        guard let colorsScheme = parknavRouteOptions.nightStyle?.colorsScheme else {return}
        BannerContainerView.appearance().backgroundColor = colorsScheme.bottomBannerColor
        BottomBannerView.appearance().backgroundColor = colorsScheme.bottomBannerColor
        InstructionsBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        TopBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        NavigationMapView.appearance().tintColor = colorsScheme.routeColor

        NavigationMapView.appearance().trafficSevereColor = colorsScheme.routeColor
        NavigationMapView.appearance().trafficHeavyColor = colorsScheme.routeColor

        LineView.appearance().lineColor = colorsScheme.routeColor

        WayNameLabel.appearance().backgroundColor = colorsScheme.wayNameColor
        WayNameView.appearance().backgroundColor = colorsScheme.wayNameColor
        MarkerView.appearance().innerColor = colorsScheme.bottomBannerColor
        TimeRemainingLabel.appearance().trafficUnknownColor = colorsScheme.instructionsBannerColor
        UserPuckCourseView.appearance().fillColor = colorsScheme.userLocationFillColor
        UserPuckCourseView.appearance().puckColor = colorsScheme.userLocationPuckColor

        PrimaryLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor
            = colorsScheme.primaryLabelColor
        PrimaryLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor
            = colorsScheme.primaryLabelColor
        NextInstructionLabel.appearance().normalTextColor = colorsScheme.primaryLabelColor
        NextBannerView.appearance().backgroundColor = colorsScheme.instructionsBannerColor

        ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).primaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).secondaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).primaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).secondaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).primaryColor
            = colorsScheme.primaryLabelColor
        ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).secondaryColor
            = colorsScheme.primaryLabelColor

        DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).unitTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).valueTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).unitTextColor
            = colorsScheme.primaryLabelColor
        DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).valueTextColor
            = colorsScheme.primaryLabelColor
        StepInstructionsView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        StepsBackgroundView.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        StepTableViewCell.appearance().backgroundColor = colorsScheme.instructionsBannerColor
        CancelButton.appearance().tintColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
    }
    // swiftlint:enable function_body_length
}
