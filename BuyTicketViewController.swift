//
//  BuyTicketViewController.swift
//  hfa-app
//
//  Created by Erin Pangilinan on 10/18/15.
//  Copyright © 2015 Erin Pangilinan. All rights reserved.
//

import UIKit
import PassKit
import Contacts

class BuyTicketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Our app will support all available networks in Apple Pay.
    let paymentNetworks = [
        PKPaymentNetworkAmex,
        PKPaymentNetworkDiscover,
        PKPaymentNetworkMasterCard,
        PKPaymentNetworkVisa]

    func applePayButtonPressed(){
        PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(self.paymentNetworks, capabilities: PKMerchantCapability.Capability3DS)
        let button = PKPaymentButton(type: .Buy, style: .Black)
        button.addTarget(self, action: "applePayButtonPressed", forControlEvents: .TouchUpInside)
    
            let request = PKPaymentRequest()
            let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
            self.presentViewController(applePayController, animated: true, completion: nil)
            // Display view controller

        
            request.merchantIdentifier = "com.erinjerri.hfa-iphone"
            request.supportedNetworks = self.paymentNetworks
            request.merchantCapabilities = PKMerchantCapability.Capability3DS
            request.countryCode = "US"
            request.currencyCode = "USD"

            // Request shipping information, in this case just postal address.
            request.requiredShippingAddressFields = .PostalAddress
        }
    // Payment Processed
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController as! PaySheetViewController
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        completion: PKPaymentAuthorizationStatus -> Void)
    {
        completion(.Success)
        performSegueWithIdentifier("paySheet", sender: self)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller:PKPaymentAuthorizationViewController) {
        dismissViewControllerAnimated(true, completion:nil)
    }
}


