//
//  CountryTableViewController.swift
//  RestCountriesList
//
//  Created by juris.katkovskis on 23/08/2022.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    private var countries: [Country] = []
       private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NetworkManager.fetchData { countries in
                   self.countries = countries
                   dump(self.countries)
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }


    }
    private func setupView(){
           view.backgroundColor = .secondarySystemBackground
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
           setupNavigationBar()
           //gestureRecogniser
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
                self.view.addGestureRecognizer(longPressRecognizer)
         
       }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer){
            if sender.state == UIGestureRecognizer.State.began {
                let touchPoint = sender.location(in: self.tableView)
                if let indexPath = tableView.indexPathForRow(at: touchPoint){
                    basicActionSheet(title: countries[indexPath.row].name.common, message: countries[indexPath.row].name.official)
                }
            }
        }
    private func setupNavigationBar(){
            title = "Country List"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
                let imageView = UIImageView(image: titleImage)
                self.navigationItem.titleView = imageView

          
            
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.tintColor = .label
            
            //infoItemTapped
        }

       
    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return countries.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
            //        let cell: UITableViewCell = {
            //            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            //                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
            //            }
            //            return cell
            //        }()
            // Configure the cell...
            let country = countries[indexPath.row]
            cell.textLabel?.text = country.name.common
            cell.detailTextLabel?.text = country.name.official
            cell.selectionStyle = .none
            
            return cell
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountryTableViewController{
    
    private func basicActionSheet(title: String?, message: String?){
        DispatchQueue.main.async {
            let actionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true)
        }
    }
    
}
