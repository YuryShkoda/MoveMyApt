//
//  OffersVC.swift
//  
//
//  Created by Yury on 9/4/17.
//
//

import UIKit

class OffersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataController = DataController()
    var selectedOffer = Offer()
    var offers = [Offer]()
    
    @IBOutlet weak var offersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataController.getOffers(customerID: Customer.sharedInstance.id!)
        
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            print("get offers")
            self.dataController.getOffers(customerID: Customer.sharedInstance.id!)
        })
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.Name("refreshOffersList"), object: nil)
    }
    
    func refresh() {
        offers = dataController.offers
        offersTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferCell
        if offers.count > 0 {
            cell.mover?.text  = "Mover: " + offers[indexPath.row].moverName!
            cell.total?.text  = "Total: $" + String(offers[indexPath.row].total!)
            cell.status?.text = "Status: " + offers[indexPath.row].status!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click!")
    }

}
