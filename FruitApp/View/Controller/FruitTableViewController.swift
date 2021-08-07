//
//  FruitTableViewController.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import UIKit

class FruitTableViewController: UITableViewController, FruitTableViewControllerDelegate {
    // MARK: - Types
    
    struct SegueIdentifiers {
        static let showFruitDetails = "showFruitDetailsSegue"
    }
    
    // MARK: - vars
    var datasource: FruitDatasource?
    var delegate: FruitTableViewDelegate?
    
    lazy var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //MARK:- UI Components
        initializeUIComponents()
        
        
       
        //MARK:- Refresh the data
        refresh()
    }
    
    
    fileprivate func initializeUIComponents() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        refreshControl?.addTarget(self, action: #selector(reloadTableView(sender:)), for: .valueChanged)
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        
        datasource = FruitDatasource(tableView: self.tableView, fruit: [Fruit]())
        delegate = FruitTableViewDelegate(tableView: self.tableView, data: [Fruit]())
        delegate?.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let property = EventProperty(name: "display", value: "Fruits")
        FruitAnalytics.trackEvent(event: .display, metaData: [property])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case SegueIdentifiers.showFruitDetails:
            if let destination = segue.intendedDestinationViewController as? FruitDetailsViewController {
                if let fruit = sender as? Fruit {
                    destination.fruit = fruit
                }
            }
        default:
            return
        }
    }
    
    // MARK: - show/hide activity indicators
    /// Hides activity indicator.
    func hideActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        navigationItem.rightBarButtonItem = nil
    }
    
    /// Temporarily shows an activity indicator.
    func showActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // MARK: - pull to refresh
    @objc func reloadTableView(sender: UIRefreshControl) {
        self.refresh()
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    // MARK: - load headlines
    private func refresh() {
        loadHeadlines()
    }
    
    private func loadHeadlines() {
        self.showActivityIndicator()
        
        let message = NSLocalizedString("Checking for news headlines", comment: "Checking for news headlines")
        self.setBackgroundMessage(message)
        self.tableView.reloadData()
        
        FruitVM.loadFruits { (fruits, error) in
            // because it's the UI thread the GODS insist to do unto the main thread, meh
            DispatchQueue.main.async {
                if error != nil {
                    let message = NSLocalizedString("BBC News has no news today", comment: "BBC News has no news today")
                    self.setBackgroundMessage(message)
                }
                else  {
                    self.datasource?.update(data: (fruits?.fruit)!)
                    self.delegate?.update(data: (fruits?.fruit)!)
                    self.tableView.reloadData()
                }
                self.hideActivityIndicator()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - FruitTableViewControllerDelegate
    func didSelectFruit(_ fruit: Fruit, atIndex index: IndexPath) {
        self.performSegue(withIdentifier: SegueIdentifiers.showFruitDetails, sender: fruit)
    }
}
