import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let taskTextField = UITextField()
    let addButton = UIButton()
    let tableView = UITableView()
    let todayDate = UILabel()
    var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(todayDate)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월dd일"
        todayDate.text = dateFormatter.string(from: date)
        
        todayDate.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        // Add Task TextField
        view.addSubview(taskTextField)
        taskTextField.snp.makeConstraints { make in
            make.top.equalTo(todayDate.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        taskTextField.borderStyle = .roundedRect
        
        // Add Button
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(taskTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .blue
        addButton.layer.cornerRadius = 5
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // TableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func addButtonTapped() {
        if let task = taskTextField.text, !task.isEmpty {
            tasks.append(task)
            tableView.reloadData()
            taskTextField.text = ""
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Task", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.tasks[indexPath.row]
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alertController] _ in
            guard let self = self, let alertController = alertController, let textField = alertController.textFields?.first else {
                return
            }
            self.tasks[indexPath.row] = textField.text ?? ""
            tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
