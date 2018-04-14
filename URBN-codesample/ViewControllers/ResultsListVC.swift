//
//  ResultsListVC.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit

class ResultsListVC: UIViewController {
    
    var navTitle: String!
    var venues: [Venue]
    let listView = ResultsListView()
    
    //MARK: Using dependency injection to pass venue onject to VC
    init(navTitle: String, venues: [Venue]) {
        self.navTitle = navTitle
        self.venues = venues
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var resultsListTableView: UITableView = {
        let tv = UITableView()
        tv.register(ResultsTableViewCell.self, forCellReuseIdentifier: "ResultsCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainTableView()
        resultsListTableView.dataSource = self
        resultsListTableView.delegate = self
        configureNavigation()
        resultsListTableView.rowHeight = 105.00
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsListTableView.reloadData()
        //empty state if there are no venues
        let emptyView = EmptyView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        if venues.isEmpty {
            emptyView.configureView(withText: "No Search Results Available Yet")
            self.view.addSubview(emptyView)
        } else {
            self.view.willRemoveSubview(emptyView)
        }
    }
    
    private func constrainTableView() {
        view.addSubview(resultsListTableView)
        resultsListTableView.snp.makeConstraints { (view) in
            view.top.bottom.trailing.leading.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0.67, green: 0.07, blue: 0.50, alpha: 1)
        navigationItem.title = self.navTitle
    }
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: TableView Datasource Methods
extension ResultsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as? ResultsTableViewCell {
            cell.configureCell(venue: venue)
            cell.setNeedsLayout()
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: TableView Delegate Methods
extension ResultsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailedVenueVC()
        let venue: Venue!
        venue = venues[indexPath.row]
        detailVC.configureView(venue: venue)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
