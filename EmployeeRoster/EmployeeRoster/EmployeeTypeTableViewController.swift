//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by student-2 on 25/11/24.
//

import UIKit



// Define the custom delegate protocol
protocol EmployeeTypeTableViewControllerDelegate: AnyObject {
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController {

    // Property to track the currently selected employee type
    var employeeType: EmployeeType?
    
    // Delegate property
    weak var delegate: EmployeeTypeTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure the table view can be updated correctly.
        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // We have one section for employee types
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeType.allCases.count // The number of employee types
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell using the identifier set in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath)

        // Get the corresponding EmployeeType for this row
        let type = EmployeeType.allCases[indexPath.row]
        
        // Configure the cell's default content configuration
        var content = cell.defaultContentConfiguration()
        content.text = type.description // Set the text to the description of the EmployeeType
        
        // Set the content of the cell
        cell.contentConfiguration = content

        // If this EmployeeType is the one selected, add a checkmark
        if employeeType == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    // MARK: - Table View Delegate

    // When a row is selected, update the employeeType and reload the table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after selection
        tableView.deselectRow(at: indexPath, animated: true)

        // Set the selected employeeType to the corresponding type
        employeeType = EmployeeType.allCases[indexPath.row]

        // Call the delegate method to pass the selected employee type back
        if let selectedType = employeeType {
            delegate?.employeeTypeTableViewController(self, didSelect: selectedType)
        }

        // Dismiss the current view controller
        navigationController?.popViewController(animated: true)
    }
}
