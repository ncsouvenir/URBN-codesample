//
//  EmptyView.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit

class EmptyView: UIView {
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = UIColor(displayP3Red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setUpEmptyLabel()
    }
    
    private func setUpEmptyLabel() {
        addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { (label) in
            label.edges.equalTo(self).inset(10)
        }
    }
    
    public func configureView(withText text: String) {
        emptyLabel.text = text
    }
}
