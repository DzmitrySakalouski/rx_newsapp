
import UIKit
import RxSwift
import RxCocoa

let reuseIdentifier = "NewsViewCell"

class NewsTableViewController: UITableViewController {
    private var articles = [Article]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureUI()
        
        populateNews()
    }
    
    private func configureUI() {
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Good News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        let url = URL(string: "http://newsapi.org/v2/top-headlines?country=us&apiKey=e3afcb3ba22d49bd8d9b8724c49037ad")!
        let res = Resource<ArticlesList>(url: url)
        
        URLRequest.load(resource: res).subscribe(onNext: {result in
            if let res = result {
                self.articles = res.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NewsViewCell else { fatalError("") }
        
        cell.bindData(article: articles[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
