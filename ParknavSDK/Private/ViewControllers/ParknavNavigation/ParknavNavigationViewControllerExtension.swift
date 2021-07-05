//
//  ParknavNavigationViewControllerExtension.swift
//  ParknavSDK
//

import Foundation
import Mapbox
import MapboxNavigation

protocol ParknavNavigationDisplayLogic: ParknavDisplayLogic {
    func displayCurrentLocation(viewModel: ParknavNavigation.CurrentLocation.ViewModel)
    func displayStartDetectingLocation()
    func displayAppSettingsAlert()
}

// MARK: - ParknavNavigationDisplayLogic

extension ParknavNavigationViewController: ParknavNavigationDisplayLogic {
    func displayError(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.showError(error) {}
        }
    }

    func displayCurrentLocation(viewModel: ParknavNavigation.CurrentLocation.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView?.setCenter(viewModel.location, zoomLevel: 8, animated: true)
            self?.mapView?.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
            self?.mapView?.showsUserLocation = true
        }
    }

    func displayStopNavigation() {
        navigationViewController?.navigationService.stop()
    }

    func displayStartDetectingLocation() {
        configureMapView()
        interactor?.startDetectLocation()
    }

    func displayAppSettingsAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: ParknavConstans.Titles.warningAlertTitle,
                                          message: ParknavConstans.Titles.locationDisabled, preferredStyle: .alert)
            let actionOK = UIAlertAction(title: ParknavConstans.Titles.alertOK, style: .default) {_ in
                self?.router?.showAppSettings()
            }
            alert.addAction(actionOK)
            let actionCancel = UIAlertAction(title: ParknavConstans.Titles.alertCancel, style: .cancel, handler: nil)
            alert.addAction(actionCancel)
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Internal

extension ParknavNavigationViewController {
    @objc func configureViews() {
        navigationItem.setHidesBackButton(true, animated: false)
        if let colorScheme = (interactor?.parknavRouteOptions ?? ParknavRouteOptions.instance).dayStyle?.colorsScheme {
            navigationController?.navigationBar.applyColorScheme(colorScheme)
            navigationItem.rightBarButtonItem?.applyColorScheme(colorScheme)
        }
    }
}

// MARK: - Private functions

private extension ParknavNavigationViewController {
    func configureMapView() {
        guard let mapView = mapView else {return}
        view.insertSubview(mapView, at: 0)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        mapView.delegate = interactor as? MGLMapViewDelegate
        mapView.navigationMapViewDelegate = interactor as? NavigationMapViewDelegate
        mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
        mapView.showsUserLocation = true
        print("Parknav: userLocation: \(String(describing: mapView.userLocation))")
    }
}
