
import UIKit

class HomeController: UITableViewController {
    
    static let shared = HomeController()
    
    //MARK: - Properties
    var incomingDataArray = [Root]()
    
    lazy var customRefreshControl: UIRefreshControl = {
          var refreshControl = UIRefreshControl()
          refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
          refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
          return refreshControl
      }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureNav()
        configureRefreshController()
        addViewToSubview()
        getJSONDataAndCheckForPossibleErrors()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          navigationController?.setNavigationBarHidden(false, animated: animated)
      }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: Table View Methods
    fileprivate func setupTableView() {
         tableView.backgroundColor = .white
         tableView.separatorStyle = .none
         tableView.refreshControl = customRefreshControl
         tableView.register(CustomCell.self, forCellReuseIdentifier: tableViewCellId)
     }
    
    
    fileprivate func configureNav() {
        navigationItem.title = "About Canada"
    }
    
    
    //MARK: - Refresh Controller Methods
    fileprivate func configureRefreshController() {
         let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
         customRefreshControl.attributedTitle = NSAttributedString(string: "", attributes: attributes)
               
     }
    
    @objc func refreshPulled(refreshControl: UIRefreshControl) {
           getJSONDataAndCheckForPossibleErrors()
           
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
           
           refreshControl.endRefreshing()
           
       }
    
    //MARK: - Check JSON Data For Possible Errors or reload Tableview Data
    @objc func getJSONDataAndCheckForPossibleErrors() {
        guard let urlString = URL(string: urlToApi) else { return }
        
        Networking.shared.fetchJSON(url: urlString) {(result) in
            
            switch result {
            case .success(let data):
                data.forEach({ (data) in
                    self.incomingDataArray = [data]
                    self.tableView.reloadData()
                })
                
            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    }
    
    
    //MARK: - Add View To Subview
    fileprivate func addViewToSubview() {
           [customRefreshControl].forEach{view.addSubview($0)}
       }
    
}





