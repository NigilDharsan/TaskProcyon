//
//  ListModel.swift
//  ListView
//
//  Created by NigilDharsan on 13/10/22.
//

import Foundation


class listDataModel : NSObject {

let networkManger = NetworkManager()

// MARK: - Get Notes data's
func getListAPI(api: String, params:[String:Any]?, completionHandler: @escaping (_ response: [ResponseData]?, _ error: Error? ) -> Void){
    
    networkManger.requestWith(.get, strURL: api, params: nil, headers: nil, success: { (data) in
        self.decodeListData(data) { (result, error) in
            completionHandler(result,error)
        }
    }) { (error) in
        completionHandler(nil, error)
    }
}

func decodeListData(_ responseData: Data, completionHandler: @escaping (_ response: [ResponseData]?, _ error: Error? ) -> Void){
    do {
        let jsonDecoder = JSONDecoder()
        let decodedResponse = try jsonDecoder.decode([ResponseData].self, from: responseData)
        completionHandler(decodedResponse, nil)
        
    }catch let decodedError {
        print(decodedError)
        completionHandler(nil, decodedError)
    }
}
}


// MARK: - DataModel Store data
 class APICallRepository {
    
    let apiClient: APIClient!
         
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
     func getDetails(_ completion: @escaping (String) -> ()){
         let resource = Resource(url: URL(string:  "https://jsonplaceholder.typicode.com/posts")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(String.self, from: data)
                    DispatchQueue.main.async {
                    completion((items))
                    }
                } catch {
                    completion(("error"))
                }
            case .failure(let error):
                completion(("error"))
            }
        }
    }
    
}








// MARK: - Model Data....

struct ResponseData : Codable {
    
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?

        enum CodingKeys: String, CodingKey {
           
            
            case userId = "userId"
            case id = "id"
            case title = "title"
            case body = "body"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            userId = try values.decodeIfPresent(Int.self, forKey: .userId)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            body = try values.decodeIfPresent(String.self, forKey: .body)
            
        }


}
