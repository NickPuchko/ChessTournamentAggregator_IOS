//
//  LocationViewController.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 14.02.2021.
//  
//

import UIKit
import  MapKit

final class LocationViewController: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate{
    
    private let output: LocationViewOutput
    weak var locationDelegate: LocationDelegate!
    var searchBar = UISearchBar()
    var searchResultsTable = UITableView()
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    init(output: LocationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        setupSearchBar()
        setupTableView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        searchBar.delegate = self
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
    
    }
    
    func setupTableView() {
        view.addSubview(searchResultsTable)
        searchResultsTable.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchResultsTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchResultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchResultsTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupSearchBar(){
        view.addSubview(searchBar)
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.sizeToFit()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        searchResults = completer.results
        searchResultsTable.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        
    }
    
}
extension LocationViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension LocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            
            guard let name = response?.mapItems[0].name else {
                return
            }
            
            self?.dismiss(animated: true, completion: {
                self?.locationDelegate.updateLocation(location: name)
            })
        }
    }
}
extension LocationViewController: LocationViewInput {
}

