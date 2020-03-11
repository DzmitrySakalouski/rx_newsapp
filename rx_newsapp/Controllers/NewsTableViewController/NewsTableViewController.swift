
import UIKit
import RxSwift
import RxCocoa

struct Student {
    let score: BehaviorRelay<String>
}

let reuseIdentifier = "NewsViewCell"

class NewsTableViewController: UITableViewController {
    private var articles = [Article]()
    
    let disposedBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureUI()
        test()
//        populateNews()
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//        URLRequest.test(url: url)
    }
    
    private func configureUI() {
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Good News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func test() {
        print("test")
        let john = Student(score: BehaviorRelay<String>(value: "john init"))
        let mary = Student(score: BehaviorRelay<String>(value: "mary init"))
        
        let student = PublishSubject<Student>()
        
        student
            .asObservable()
            .flatMapLatest{ $0.score.asObservable() }
            .subscribe(onNext: { print($0)}).disposed(by:disposedBag)
        
        student.onNext(john)
        john.score.accept("john 1")
        john.score.accept("john 2")
        student.onNext(mary)
        mary.score.accept("mary 1")
        john.score.accept("mary 2")
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
            }).disposed(by: disposedBag)
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
