//
//  ApiClient.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import Foundation
import Alamofire

class APIClient{


    ///Home Slider
    static func getNowPlaying(
        completion:@escaping (_ success:Bool,_ error:String,_ user:DataResults?)->Void) {


        var url = "\(Constants.Api.baseURL)\(Constants.Api.nowplaying)"


        let parameters: [String: Any] = [
            "api_key" : "\(Constants.Api.key)",

        ]
        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")


        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<DataResults>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,"Error",nil)
            }

        }


    }

    ///Home List
    static func getUpcoming(
        page:Int,
        completion:@escaping (_ success:Bool,_ error:String,_ user:DataResults?)->Void) {


        var url = "\(Constants.Api.baseURL)\(Constants.Api.upcoming)"


        let parameters: [String: Any] = [
            "api_key" : "\(Constants.Api.key)",
            "page" : page,

        ]
        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")


        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<DataResults>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,"Error",nil)
            }

        }


    }

    ///Search Page
    static func getSearch(
        searchText:String,
        page:Int,
        completion:@escaping (_ success:Bool,_ error:String,_ user:DataResults?)->Void) {


        var url = "\(Constants.Api.baseURL)\(Constants.Api.search)"

        let parameters: [String: Any] = [
            "api_key" : "\(Constants.Api.key)",
            "query" : searchText,
            "page" : page

        ]
        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")

        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<DataResults>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,"Error",nil)
            }

        }


    }


    ///Detail Page Details
    static func getDetail(
        id:Int,
        completion:@escaping (_ success:Bool,_ error:String,_ user:Details?)->Void) {


        var url = "\(Constants.Api.baseURL)\(Constants.Api.detail)\(id)"

        let parameters: [String: Any] = [
            "api_key" : "\(Constants.Api.key)",


        ]
        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")

        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<Details>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,"Error",nil)
            }

        }


    }

    ///More Like This
    static func getSimilar(
        id:Int,
        completion:@escaping (_ success:Bool,_ error:String,_ user:DataResults?)->Void) {


        var url = "\(Constants.Api.baseURL)\(Constants.Api.detail)\(id)/\(Constants.Api.similar)"

        let parameters: [String: Any] = [
            "api_key" : "\(Constants.Api.key)",
        ]
        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")

        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<DataResults>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,"Error",nil)
            }

        }


    }
}
