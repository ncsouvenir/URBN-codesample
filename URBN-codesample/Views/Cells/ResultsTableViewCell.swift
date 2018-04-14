//
//  ResultsTableViewCell.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit
import Kingfisher

class ResultsTableViewCell: UITableViewCell {
    
    lazy var venueImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var venueName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 0.537, green: 0.537, blue: 0.537, alpha: 1)
        label.font.withSize(15)
        label.numberOfLines = 0
        return label
    }()
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "VenueListCell")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        let viewObjects = [venueImage, venueName, categoryName, distanceLabel] as [UIView]
        viewObjects.forEach{addSubview($0)}
        
        venueImage.snp.makeConstraints { (image) in
            image.height.width.equalTo(90)
            image.top.leading.equalTo(5)
        }
        venueName.snp.makeConstraints { (label) in
            label.top.equalTo(5)
            label.leading.equalTo(self.venueImage.snp.trailing).offset(5)
            label.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
        }
        categoryName.snp.makeConstraints { (label) in
            label.top.equalTo(self.venueName.snp.bottom).offset(5)
            label.leading.equalTo(self.venueImage.snp.trailing).offset(5)
            label.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
        }
        distanceLabel.snp.makeConstraints { (label) in
            label.top.equalTo(self.categoryName.snp.bottom).offset(5)
            label.leading.equalTo(self.venueImage.snp.trailing).offset(5)
            label.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
        }
        
    }
    
    //MARK: configures cell to keep the view controller more abstracted
    public func configureCell(venue: Venue) {
        self.venueImage.image = nil
        self.venueName.text = venue.name
        self.categoryName.text = venue.categories.map{$0.shortName}.joined(separator: " ,")
        //unable to use the round property but would like to create a function  that takes in a venueDistance, converts it from meters to miles and then is able to round to the ones place.
        if let venueDistance = venue.location.distance{
            let distanceInMeters = Measurement(value: venueDistance, unit: UnitLength.meters)
            let metersToMiles = distanceInMeters.converted(to: UnitLength.miles)
            self.distanceLabel.text = "\(100 * metersToMiles)"
        }
        
        self.venueImage.kf.indicatorType = .activity
        ImageCache.default.retrieveImage(forKey: venue.id, options: nil){(image, cache) in
            if let image = image {
                self.venueImage.image = image
                return
            } else {
                self.venueImage.image = #imageLiteral(resourceName: "placeholder")
            }
        }
        
        PhotoAPIService.service.getVenuePhotos(venue: venue.id, completion: { (photo) in
            if let photo = photo.first {
                let urlStr = "\(photo.prefix)\(photo.width)x\(photo.height)\(photo.suffix)"
                if let photoURL = URL(string: urlStr) {
                    self.venueImage.kf.setImage(with: photoURL, placeholder: UIImage.init(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                        if let image = image {
                            ImageCache.default.store(image, forKey: venue.id)
                        }
                        self.setNeedsLayout()
                    })
                }
            }
        },errorHandler: { (_) in
            self.venueImage.image = #imageLiteral(resourceName: "placeholder")
        })
    }
}
