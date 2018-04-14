//
//  DetailedVenueVC.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit
import MapKit
import Kingfisher


class DetailedVenueVC: UIViewController {
    
    let detailView = DetailedVenueView()
    var venue: Venue!
    var venueImage: UIImage!
    
    var venueDetail = [String]() {
        didSet {
            self.detailView.DetailedVenueTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainView()
        detailView.DetailedVenueTableView.delegate = self
        detailView.DetailedVenueTableView.dataSource = self
        navigationItem.title = venue.name
        let backButton = UIBarButtonItem()
        backButton.title = "Results"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        detailView.DetailedVenueTableView.tableFooterView = UIView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        self.navigationItem.searchController?.searchBar.endEditing(true)
    }
    
    private func constrainView() {
        view.addSubview(detailView)
        detailView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension DetailedVenueVC {
    
    public func configureView(venue: Venue) {
        self.venue = venue
        
        PhotoAPIService.service.getVenuePhotos(venue: venue.id, completion: { (photo) in
            if let photo = photo.first {
                let photoURL = "\(photo.prefix)\(photo.width)x\(photo.height)\(photo.suffix)"
                
                var index = 0
                self.venueDetail.insert(photoURL, at: index)
                
                //Address Index
                index += 1
                if let address = venue.location.formattedAddress {
                    self.venueDetail.insert(address.joined(separator: ", "), at: index)
                    index += 1
                } else {
                    self.venueDetail.insert("No Address Available", at: index)
                    index += 1
                }
                
                //Category Index
                let category = self.venue.categories.map{$0.shortName}.joined(separator: ", ").replacingOccurrences(of: "/", with: "")
                if category.isEmpty {
                    self.venueDetail.insert("No Categories Available", at: index)
                } else {
                    self.venueDetail.insert(category, at: index)
                }
                
            } else {
                let noPhotoText = "No URL Available"
                var index = 0
                self.venueDetail.insert(noPhotoText, at: index)
                index += 1
                let category = self.venue.categories.map{$0.shortName}.joined(separator: ", ").replacingOccurrences(of: "/", with: "")
                if category.isEmpty {
                    self.venueDetail.insert("No Categories Available", at: index)
                } else {
                    self.venueDetail.insert(category, at: index)
                }
                index += 1
                if let address = venue.location.formattedAddress {
                    self.venueDetail.insert(address.joined(separator: ", "), at: index)
                    index += 1
                } else {
                    self.venueDetail.insert("No Address Available", at: index)
                    index += 1
                }
            }
        }, errorHandler: { (error) in
            AppError.other(rawError: error.localizedDescription as! Error)
        })
    } //end of configureCell
}

//MARK: Tableview Delegate Methoods
extension DetailedVenueVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.layer.bounds.height * 0.70
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //targets last index in venueDetail array and if the user has location on gives them directions to the venue
        if indexPath.row == venueDetail.count - 1 {
            getDirections()
        }
    }
}

//MARK: Tableview Datasource Methoods
extension DetailedVenueVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venueDetail[indexPath.row]
        
        //would like to refactor to add more guard statements to prevent too many indents
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailVenueCell", for: indexPath) as? DetailedVenueTableViewCell {
            
            if indexPath.row == 0 { //venue image
                if let urlImage = URL(string: venue) {
                    cell.venueImage.image = nil
                    cell.venueImage.kf.indicatorType = .activity
                    ImageCache.default.retrieveImage(forKey: self.venue.id, options: nil){(image, cache) in
                        if let image = image {
                            cell.venueImage.image = image
                            self.venueImage = image
                        } else {
                            cell.venueImage.kf.setImage(with: urlImage, placeholder: UIImage.init(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                                cell.layoutIfNeeded()
                                cell.detailDescriptionLabel.text = nil
                                if let image = image {
                                    cell.venueImage.image = image
                                    self.venueImage = image
                                    ImageCache.default.store(image, forKey: self.venue.id)
                                }
                            })
                        }
                    }
                } else {
                    cell.venueImage.image = #imageLiteral(resourceName: "placeholder")
                    self.venueImage = #imageLiteral(resourceName: "placeholder")
                }
            } else { //detail cells
                cell.detailDescriptionLabel.text = venue
                cell.backgroundColor =  UIColor(red: 0.67, green: 0.07, blue: 0.50, alpha: 0.30)
            }
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: helper function to get directions to a specific venue
extension DetailedVenueVC{
    
    func getDirections(){
        var urlString: String!
        //can use user location
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            if let latitude = UserPreferences.manager.getUserCoordinate().latitude, let longitude = UserPreferences.manager.getUserCoordinate().longitude {
                urlString = "http://maps.apple.com/maps?saddr=\(latitude),\(longitude)&daddr=\(venue.location.lat),\(venue.location.lng)"
            }
        } else { //can't use user location
            if let latitude = UserPreferences.manager.getSearchCoordinates().latitude, let longitude = UserPreferences.manager.getSearchCoordinates().longitude {
                urlString = "http://maps.apple.com/maps?saddr=\(latitude),\(longitude)&daddr=\(venue.location.lat),\(venue.location.lng)"
            }
        }
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else { //only present the location, not directions
            let singleLocation = "http://maps.apple.com/maps?saddr=\(venue.location.lat),\(venue.location.lng)"
            UIApplication.shared.open(URL(string: singleLocation)!, options: [:], completionHandler: nil)
        }
    }
}
