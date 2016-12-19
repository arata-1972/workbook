//
//  MasterViewController.swift
//  Hand
//
//  Created by 村上幸雄 on 2016/04/29.
//  Copyright © 2016年 Bitz Co., Ltd. All rights reserved.
//

import UIKit

protocol SourceType: UITableViewDataSource {
    //var dataObject: DataType {get set}
    //var conditionForAdding: Bool {get}
    func insertTopRowIn(tableView: UITableView)
    func deleteRowAtIndexPath(indexPath: NSIndexPath, from tableView: UITableView)
}

extension SourceType {
    func insertTopRowIn(tableView: UITableView) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func deleteRowAtIndexPath(indexPath: NSIndexPath, from tableView: UITableView) {
        tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
    }
}

class DataSource: NSObject, UITableViewDataSource, SourceType {
    internal var document = Document.sharedInstance
    
    func addItemTo(tableView: UITableView) {
        if document.conditionForAdding {
            document.addNewItem(at: 0)
            insertTopRowIn(tableView: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return document.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("This method must be overriden")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            document.deleteCard(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

class HandDataSource: DataSource {
    override init() {
        super.init()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as? CardCell else {
            return UITableViewCell()
        }
        let card = document.getItem(at: indexPath.row)
        cell.fillWith(card: card)
        return cell
    }
}

class HandVC: UITableViewController {
    private var dataSource = HandDataSource()
}

class MasterViewController: HandVC {

    //private var dataSource = DataSource()
    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ableView.dataSource = dataSource
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MasterViewController.addNewCard(sender:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func addNewCard(sender: UIBarButtonItem) {
        dataSource.addItemTo(tableView: tableView)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let card = Document.sharedInstance.getItem(at: indexPath.row)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = card
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

