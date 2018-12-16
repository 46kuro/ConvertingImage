//
//  SentenceListViewController.swift
//  ConvertingImage
//
//  Created by Shinji Kurosawa on 2018/12/16.
//  Copyright © 2018 Shinji Kurosawa. All rights reserved.
//

import UIKit

class SentenceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let defaultsKeySentences = "sentences"
    
    var sentences: [String] {
        get {
            let array = UserDefaults.standard.array(forKey: defaultsKeySentences)
            return array?.compactMap({ $0 as? String }) ?? [String]()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: defaultsKeySentences)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "文章を選択する"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addSentence))
        
        if sentences == [String]() {
            sentences = ["I have a pen"]
        }
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addSentence() {
        let alert = UIAlertController(title:"", message: "文章を追加する", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "追加", style: .default, handler: { action in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            var value = self.sentences
            value.append(text)
            self.sentences = value
            self.tableView.reloadData()
        })
        
        alert.addAction(cancel)
        alert.addAction(action)
        alert.addTextField(configurationHandler: {
            $0.placeholder = "追加する文章"
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension SentenceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard sentences.count > indexPath.row else { return cell }
        cell.textLabel?.text = sentences[indexPath.row]
        return cell
    }
}

extension SentenceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard sentences.count > indexPath.row else { return }
        let viewController = SentenceConvertingViewController.instantiate(sentence: sentences[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}
