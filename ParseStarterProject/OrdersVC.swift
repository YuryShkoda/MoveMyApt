//
//  OrdersVC.swift
//  moveMyStuff
//
//  Created by Yury on 8/25/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataController = DataController()
    var selectedOrder = Order()
    var orders = [Order]()
    var offers = [Offer]()
    
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataController.getOffers(moverID: Mover.sharedInstance.id!)
        dataController.getActiveOrders()
        
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            print("get orders")
            self.dataController.getOffers(moverID: Mover.sharedInstance.id!)
            self.dataController.getActiveOrders()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.Name("refreshOrdersList"), object: nil)
    }
    
    func refresh() {
        orders = dataController.orders
        offers = dataController.offers
        ordersTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrderDetails" {
            if let offerVC = segue.destination as? OfferVC {
                if selectedOrder.customerID != nil {
                    offerVC.order = selectedOrder
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataController.orders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOrder = orders[indexPath.row]
        performSegue(withIdentifier: "ShowOrderDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        if orders.count > 0 {
            cell.dateLabel?.text = "Date: " + orders[indexPath.row].date!
            cell.fromLabel?.text = "From: " + orders[indexPath.row].pickUpAddress!
            cell.toLabel?.text   = "To: " + orders[indexPath.row].dropOffAddress!
            cell.sizeLabel?.text = "Stuff: " + orders[indexPath.row].stuff!
            if offers.count > 0 {
                for offer in offers {
                    if offer.orderID == orders[indexPath.row].id {
                        cell.status?.text = "Status: offered $" + String(describing: offer.total!)
                        continue
                    } else {
                        cell.status?.text = "Status: No offer"
                    }
                }
            }
        }
        return cell
    }
}
