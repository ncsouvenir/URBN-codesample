//
//  SearchVC.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit
import MapKit
import SnapKit

class SearchVC: UIViewController {
    
    let searchView = SearchView()
    var numberOfLaunches: Int = 0
    var selectedIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let _ = LocationService.manager.checkAuthorizationStatusAndLocationServices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchView)
        constrainView()
        configureNavBar()
        delegateAndDataSource()
        setUpLocationServices()
        configureTextInSearchBar()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        self.navigationItem.searchController?.searchBar.endEditing(true)
    }
    
    lazy var venueSearchBarController = UISearchController(searchResultsController: nil)
    
    //Venue Object
    var venues: [Venue] = [] {
        didSet {
            
            var annotations: [MKAnnotation] = []
            for venue in venues {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
                annotation.title = venue.name
                annotation.subtitle = venue.categories.map{$0.shortName}.joined(separator: ", ")
                annotations.append(annotation)
            }
            searchView.mapView.removeAnnotations(self.annotations)
            self.annotations = annotations
        }
    }
    
    var annotations: [MKAnnotation] = [] {
        didSet {
            searchView.mapView.addAnnotations(annotations)
            searchView.mapView.showAnnotations(annotations, animated: true)
        }
    }
}

//MARK: - Helper Functions
extension SearchVC {
    func configureNavBar() {
        navigationItem.title = "Venue Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        venueSearchBarController.searchBar.delegate = self
        navigationItem.searchController = venueSearchBarController
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.tintColor = UIColor(displayP3Red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.isActive = true
        navigationItem.searchController?.searchBar.placeholder = "Search for a venue"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "listIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(venueListButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "location"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(locationButtonPressed))
    }
    
    func configureTextInSearchBar(){
        let textFieldInsideSearchBar = searchView.locationSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        definesPresentationContext = true
    }
    
    @objc private func venueListButtonPressed() {
        let modalVC = ResultsListVC(navTitle: "Venue Results", venues: self.venues)
        let navController = UINavigationController(rootViewController: modalVC)
        modalVC.view.backgroundColor = .white
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc private func locationButtonPressed(){
        let settingsAlert = Alerts.createAlert(withTitle: "Location Authorization", andMessage: "Please enable Location Services in Settings for better search results.")
        Alerts.addAction(withTitle: "Cancel", style: .cancel, toAlertController: settingsAlert, andCompletion: nil)
        Alerts.addAction(withTitle: "Settings", style: .default, toAlertController: settingsAlert) { (_) in
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {return}
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    func delegateAndDataSource() {
        navigationItem.searchController?.searchBar.delegate = self
        searchView.locationSearchBar.delegate = self
        LocationService.manager.delegate = self
        searchView.mapView.delegate = self
        searchView.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "mapAnnotationView")
    }
    
    private func constrainView() {
        view.addSubview(searchView)
        searchView.backgroundColor = .gray
        searchView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setUpLocationServices() {
        let locationService = LocationService.manager.checkAuthorizationStatusAndLocationServices()
        
        if locationService.locationServicesEnabled {
            switch locationService.authorizationStatus {
            case .denied:
                _ = Alerts.presentSettingsAlertController(withTitle: "Location Services Not Enabled", andMessage: "Please enable Location Services in Settings for better search results.")
            case .restricted:
                let alertController = UIAlertController(title: "Warning", message: "This app is not authorized to use location services.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    func getVenues(fromSearchTerm searchTerm: String, latitude: Double, andLongitude longitude: Double) {
        FourSquareAPIService.service.getVenues(lat: latitude, lon: longitude, search: searchTerm, completion: { (venues) in
            if venues.isEmpty {
                let alert = Alerts.createAlert(withTitle: "No Results", andMessage: "Please try again with a different search term or location.")
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.venues = venues
        }, errorHandler: { (error) in
            let errorAlert = Alerts.createErrorAlert(withMessage: "An error occurred:\nRate Limit has been exceeded.\n\(error)", andCompletion: nil)
            self.present(errorAlert, animated: true, completion: nil)
        })
    }
}

