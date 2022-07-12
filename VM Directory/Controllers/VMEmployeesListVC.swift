//
//  VMEmployeesListVC.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//

import UIKit
import SVProgressHUD

class VMEmployeesListVC: UIViewController {

    @IBOutlet weak var employeeListTable: UITableView!
    
    var employeesArray = [PeopleListModel]()
    var allEmployeesArray = [PeopleListModel]()
    var resultSearchController = UISearchController()
    var searchVC : VMEmployeesListVC?
    var isFromSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialiseView()
        
    }
    
    func initialiseView(){
        
        employeeListTable.dataSource = self
        employeeListTable.delegate = self
        if isFromSearch == false{
            getEmployeesList()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmplyeeDetails"{
            let vc = segue.destination as! EmployeeDetailsVC
            if let sender = sender as? PeopleListModel{
                vc.employeeData = sender
            }
        }
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        
        //when user click on the search button check whether resultSearchController is active or not ,if it is active move to the SearchControler with the search result
        if !resultSearchController.isActive {
            
            searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VMEmployeesListVC") as? VMEmployeesListVC
            searchVC?.isFromSearch = true
            searchVC?.allEmployeesArray = allEmployeesArray
            self.resultSearchController = ({
                let controller = UISearchController(searchResultsController: searchVC)
                controller.searchResultsUpdater = searchVC
                controller.delegate = searchVC
                controller.hidesNavigationBarDuringPresentation = true
                self.definesPresentationContext = true
                controller.searchBar.isTranslucent = false
                controller.searchBar.barTintColor = .white
                controller.searchBar.tintColor = .black
                controller.searchBar.searchBarStyle = .default
                controller.searchBar.placeholder = "Search"
                controller.searchBar.setBackgroundImage(UIImage(named: ""), for: UIBarPosition(rawValue: 0)!, barMetrics:.default)
                return controller
                
            })()
            
            self.present(resultSearchController, animated: true, completion: nil)
        }
        
    }
}

extension VMEmployeesListVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VMEmployeesListTCell") as! VMEmployeesListTCell
        
        let data = employeesArray[indexPath.row]
        cell.employeeNameLabel.text = data.firstName + " " + data.lastName
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "showEmplyeeDetails", sender: employeesArray[indexPath.row])
    }
}
extension VMEmployeesListVC{
    
    func getEmployeesList(){
        
        SVProgressHUD.show()
        
        VMWebServices.shared.getPeopleList {
            (data, isError, isNetworkError, isGoToLogin, isMaintenance) in
            
            SVProgressHUD.dismiss()
            
            if isMaintenance{
                print("isMaintenance")
                return
            }
            
            if isGoToLogin
            {
                print("Login expired")
                return
            }
            
            if  isNetworkError{
                print("No internet")
                return
                
            }
            
            
            if let responseArray = data as? [[String : Any]]{
                print(responseArray)
                for response in responseArray {
                    if let user = PeopleListModel(JSON: response){
                        self.allEmployeesArray.append(user)
                    }
                }
                self.employeesArray = self.allEmployeesArray
                self.employeeListTable.reloadData()
            }
        }
    }
}

extension VMEmployeesListVC : UISearchResultsUpdating,UISearchControllerDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if !searchController.isActive {
            print("Cancelled")
            self.employeesArray = allEmployeesArray
            employeeListTable.reloadData()
        }else{
            if let text = searchController.searchBar.text, !text.isEmpty {
                employeesArray = allEmployeesArray.filter { $0.firstName.lowercased().contains(text.lowercased()) ||  $0.lastName.lowercased().contains(text.lowercased())}
                employeeListTable.reloadData()
            }
        }

    }
   

}
