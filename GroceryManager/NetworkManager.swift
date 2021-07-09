//
//  NetworkManager.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 28/04/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation
//import Alamofire

/*class NetworkManager {
    
    var sessionManager: SessionManager?
    static var sharedManager: NetworkManager = NetworkManager()
    
    private init(){
        
    }
    
    public func getItems(completionBlock: @escaping ((DataResponse<Data>)->())){
        let apiToContact = Constants.itemsAPI
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseData { (dataResponse) in
            completionBlock(dataResponse)
        }
        /*Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    //let json = JSON(value)
                    print(value)
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    

                }
            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    public func pinningWithPublicKey(host: String) {
        let serverTrustPolicy: [String: ServerTrustPolicy] = [host: .pinPublicKeys(
            publicKeys: ServerTrustPolicy.publicKeys(),
            validateCertificateChain: true,
            validateHost: true
            )]
        
        sessionManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicy)
        )
    }
    
    public func pinningWithCertificate(host: String) {
        let certificates: [SecCertificate] = getCertificate(resource: "google", withExtension: ".cer")
        let serverTrustPolicy: [String: ServerTrustPolicy] = [host: .pinCertificates(certificates: certificates, validateCertificateChain: true, validateHost: true)]
        
        sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicy))
        
    }
    public func getCertificate(resource: String, withExtension: String) -> [SecCertificate] {
        guard let url  = Bundle.main.url(forResource: resource, withExtension: withExtension)
            else {
             return []
        }
        let localCertificate = try! Data(contentsOf: url) as CFData
        guard let certificate = SecCertificateCreateWithData(nil, localCertificate)
            else {
                return []
        }
        return [certificate]
    }
}*/
