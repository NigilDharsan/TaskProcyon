//
//  ListViewModel.swift
//  ListView
//
//  Created by NigilDharsan on 13/10/22.
//

import Foundation


class ListViewModel :NSObject  {
    
    var dataModel = listDataModel()
    
    var listArr = [ResponseData]()
    
    func getListAPI( completionHandler: @escaping ( _ error: String?) -> Void){
        
        let apiStr : String =   "https://jsonplaceholder.typicode.com/posts"
        
        dataModel.getListAPI(api: apiStr ,params: nil) { (response, error) in
            if error != nil{
                completionHandler(error?.localizedDescription)
                return
            }
            if let result = response {
                self.listArr = result
                completionHandler("")
            }
        }
    }

}

