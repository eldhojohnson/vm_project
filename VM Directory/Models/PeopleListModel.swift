



import ObjectMapper
import Foundation

class PeopleListModel: Mappable {
    
    var createdAt: String?
    var firstName: String = ""
    var avatar: String?
    var lastName: String = ""
    var email: String?
    var jobtitle: String?
    var favouriteColor: String?
    var id: String?
    var data: PeopleListDataModel?
    var to: String?
    var fromName: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        
        createdAt <- map["createdAt"]
        firstName <- map["firstName"]
        avatar <- map["avatar"]
        lastName <- map["lastName"]
        email <- map["email"]
        jobtitle <- map["jobtitle"]
        favouriteColor <- map["favouriteColor"]
        id <- map["id"]
        data <- map["data"]
        to <- map["to"]
        fromName <- map["fromName"]
        
        
    }
  
}

class PeopleListDataModel: Mappable {
    
    var title: String?
    var body: String?
    var id: String?
    var toId: String?
    var fromId: String?
    var meetingid: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        toId <- map["toId"]
        fromId <- map["fromId"]
        meetingid <- map["meetingid"]

    }
  
}
