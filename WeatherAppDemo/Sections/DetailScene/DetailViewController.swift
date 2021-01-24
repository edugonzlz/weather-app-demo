import UIKit

protocol DetailViewControllerType: class {
    func present(data: [AirComponent])
}

class DetailViewController: UIViewController {
    
    // MARK: - Outlets

    // MARK: - Public
    var presenter: DetailPresenterType!
    
    // MARK: - Private
    private var data: [AirComponent]?
    private var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.allowsSelection = false
            tableView?.register(AirComponentTableViewCell.self, forCellReuseIdentifier: AirComponentTableViewCell.cellId)
        }
    }
    
    // MARK: - Init
    deinit {
        print("deinit DetailViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.getData()
    }
}

// MARK: - DetailViewControllerType
extension DetailViewController: DetailViewControllerType {
    
    func setupTableView() {
        let tableView = UITableView(frame: self.view.frame)
        self.tableView = tableView
        self.view.addSubview(tableView)
    }
    
    func present(data: [AirComponent]) {
        self.data = data
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.data else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirComponentTableViewCell.cellId) as? AirComponentTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(component: data[indexPath.row])
        return cell
    }
}
