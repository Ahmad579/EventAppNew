//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var success                          :       Bool?
    var message                          :       String?
    var response_code                    :       Int?
    var data                             :       UserInformation?
    var event                            :       [EventObjectDetail]?
    var eventDetail                      :       [EventObjectDetail]?
    var clubList                         :       [ClubObject]?
    var clubDetailList                   :       [ClubDetailObject]?
    var blog                             :       [BlogObject]?



    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        response_code <- map["response_code"]
        data    <- map["user"]
        event <- map["events"]
        eventDetail <- map["events"]
        clubList <- map["shops"]
        clubDetailList <- map["bar"]
        blog  <- map["user "]
    }
}

class EventObject : Mappable {
    
    var eventid: String?
//    var eventids: Int?

    var bar_name: String?
    var event_name: String?
    var picture: String?
    var distance: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        eventid <- map["event_id"]

        bar_name <- map["bar_name"]
        event_name <- map["event_name"]
        picture <- map["picture"]
        distance <- map["distance"]

    }
}

class EventObjectDetail : Mappable {
    
    var eventid: String?
    var bar_name: String?
    var event_name: String?
    var picture: String?
    var date: String?
    var time_from: String?
    var time_to: String?
    var about: String?
    var location: String?
    var total_tickets: String?
    var price_ticket: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        eventid <- map["event_id"]
        bar_name <- map["bar_name"]
        event_name <- map["event_name"]
        picture <- map["picture"]
        date <- map["date"]
        time_from <- map["time_from"]
        time_to <- map["time_to"]
        about <- map["about"]
        location <- map["location"]
        total_tickets <- map["total_tickets"]
        price_ticket <- map["price_ticket"]

        
    }
}

class BlogObject : Mappable {
    
    var id: String?
    var title: String?
    var category: String?
    var image: String?
    var description: String?
    var created_at: String?
    var video: String?
    var video_thumb: String?
    var comment   : [BlogComment]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        category <- map["category"]
        image <- map["image"]
        description <- map["description"]
        created_at <- map["created_at"]
        video <- map["video"]
        video_thumb <- map["video_thumb"]
        comment <- map["comments"]
        
        
    }
}

class BlogComment : Mappable {
    
    var fullname: String?
    var comment: String?
    var created_at: String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        fullname <- map["fullname"]
        comment <- map["comment"]
        created_at <- map["created_at"]

        
        
        
    }
}

class ClubObject : Mappable {
    
    var bar_id: String?
    var bar_name: String?
    var picture: String?
    var distance: String?
    var longitude: String?
    var latitude: String?
    var IsFavorite: Bool?
    var open_time: String?
    var close_time: String?
    var totalReviews: String?
    var rating: String?
    var clunInfo  : ClubInfo?
    var clubTeam  : [ClubTeam]?
    var clubPhoto : [ClubPhoto]?
    var clubVideo : [ClubVideos]?
    var social    : [ClubTeam]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        bar_id <- map["bar_id"]
        bar_name <- map["bar_name"]
        distance <- map["distance"]
        picture <- map["picture"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        IsFavorite <- map["IsFavorite"]
        open_time <- map["open_time"]
        close_time <- map["close_time"]
        totalReviews <- map["totalReviews"]
        rating <- map["rating"]
        clunInfo <- map["info"]
        clubTeam <- map["team"]
        clubPhoto <- map["bar_images"]
        clubVideo <- map["bar_videos"]
        social    <- map["social"]
        
        
    }
}

class ClubDetailObject : Mappable {
    
    var name: String?
    var image: String?
    var club_type: String?
    var longitude: String?
    var latitude: String?
    var open_time: String?
    var close_time: String?
    var clunInfo  : ClubInfo?
    var clubTeam  : [ClubTeam]?
    var clubPhoto : [ClubPhoto]?
    var clubVideo : [ClubVideos]?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        club_type <- map["club_type"]
        image <- map["image"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        open_time <- map["open_time"]
        close_time <- map["close_time"]
        clunInfo <- map["info"]
        clubTeam <- map["team"]
        clubPhoto <- map["bar_images"]
        clubVideo <- map["bar_videos"]

        
    }
}

class ClubInfo : Mappable {
    
    var information: String?
    var contact_number: String?
    var website: String?
    var email: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        information <- map["information"]
        contact_number <- map["contact_number"]
        email <- map["email"]
        website <- map["website"]
        
        
        
    }
}

class ClubTeam : Mappable {
    
    var title: String?
    var designation: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        designation <- map["designation"]
        
        
        
    }
}

class ClubPhoto : Mappable {
    
    var image: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        
        
        
    }
}

class ClubVideos : Mappable {
    
    var image: String?
    var thumbNail : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["video"]
        thumbNail <- map["thumbnail"]
        
        
        
    }
}

class ClubSocial : Mappable {
    
    var twitter: String?
    var facebook: String?
    var website: String?
    var instagram: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        twitter <- map["twitter"]
        facebook <- map["facebook"]
        website <- map["website"]
        instagram <- map["instagram"]
        
        
        
    }
}


class UserInformation : Mappable {
    
    var user_id: Int?
    var user_name: String?
    var token: String?
    var email: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        user_name <- map["user_name"]
        email <- map["name"]
        token <- map["token"]



    }
}

class DealData : Mappable {
    
    var menuOfRestaurantOfDeal : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        menuOfRestaurantOfDeal <- map["menu"]
    }
}



class ReceipeObject : Mappable {
    
    var id: Int?
    var user_id: String?
    var title: String?
    var instructions: String?
    var ingredients : Bool?
    var time_to_cook : Bool?
    var image_url : String?
    var tags     : String?
    var user                : UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        title <- map["title"]
        instructions <- map["instructions"]
        ingredients <- map["ingredients"]
        time_to_cook <- map["time_to_cook"]
        image_url <- map["image_url"]
        user <- map["user"]
        tags <- map["tags"]
        
        
        
        
    }
}

class UserOrder : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var user_id: String?
    var order_status: String?
    var payment_date : String?
    var order_date : String?
    var sub_total : String?
    var coupon_code     : String?
    var discount     : String?
    var delivery_charges     : String?
    var tax     : String?
    var total_payment     : String?
    var address     : String?
    var reservation     : String?
    var totalperson     : String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        user_id <- map["user_id"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        order_date <- map["order_date"]
        sub_total <- map["sub_total"]
        coupon_code <- map["coupon_code"]
        discount <- map["discount"]
        tax <- map["tax"]
        total_payment <- map["total_payment"]
        address <- map["address"]
        reservation <- map["reservation"]
        totalperson <- map["totalperson"]

        
        
        
        
    }
}

class OrderListObject : Mappable {
    
    var id: Int?
    var coupon_code: String?
    var order_date: String?
    var order_status: String?
    var payment_date : Bool?
    var reservation : Bool?
    var resturant_id : String?
    var total_payment     : String?
    var user_id     : String?
    var restaurent                       :  AllRestaurantList?
    var userInfo                         :  UserInformation?
    var items                            :  [RestaurantMenu]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        coupon_code <- map["coupon_code"]
        order_date <- map["order_date"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        reservation <- map["reservation"]
        resturant_id <- map["resturant_id"]
        total_payment <- map["total_payment"]
        user_id <- map["user_id"]
        restaurent <- map["resturant"]
        items <- map["items"]


        
        
        
    }
}

class DealList : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var deal_name: String?
    var deal_type: String?
    var deal_description : String?
    var deal_price : String?
    var image : String?
    
    var restaurent                       :   AllRestaurantList?
    var userInfo                         :   UserInformation?
    var dealItemList                     :   [DealItem]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        deal_name <- map["deal_name"]
        deal_type <- map["deal_type"]
        deal_description <- map["deal_description"]
        deal_price <- map["deal_price"]
        image <- map["image"]
        restaurent <- map["resturant"]
        userInfo <- map["customer"]
        dealItemList <- map["deal_items"]
    }
}

class DealItem : Mappable {
    
    var id: Int?
    var deal_id: String?
    var menu_item_id: String?
    var quantity: String?
    var menu    : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        deal_id <- map["deal_id"]
        menu_item_id <- map["menu_item_id"]
        quantity <- map["quantity"]
        menu <- map["menu"]
    }
}


class AllRestaurantList : Mappable {
    
    
    var id: Int?
    var category_id: String?
    var name: String?
    var phone_no: String?
    var location: String?
    var latitude : String?
    var longitude : String?
    var image_url : String?
    var do_delivery     : Int?
    var about     : Int?
    var opening_time : String?
    var closing_time : String?

    var distance : String?
    var timings : String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        name    <- map["name"]
        phone_no    <- map["phone_no"]
        location    <- map["location"]
        latitude    <- map["latitude"]
        longitude    <- map["longitude"]
        image_url    <- map["image_url"]
        do_delivery    <- map["do_delivery"]
        about    <- map["about"]
        opening_time    <- map["opening_time"]
        closing_time    <- map["closing_time"]
        distance    <- map["distance"]
        timings    <- map["timings"]


    }
}

class RestaurantDetailObject : Mappable {
    
    var id: Int?
    var category_id: String?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var restaurentInfo : AllRestaurantList?
    var menuOfRestaurant : [RestaurantMenu]?
    var menu             : RestaurantMenu?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        restaurentInfo <- map["resturant"]
        menuOfRestaurant <- map["menu"]
        menu  <- map["menu"]
        

    }
}


class MenuCategory : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var menuOfRestaurant : [RestaurantMenu]?
    
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        menuOfRestaurant <- map["menu"]
        
        
    }
}


class RestaurantMenu : Mappable {
    
    var id: Int?
    var menu_category_id: String?
    var menu_item_id    : String?
    var item_name: String?
    var description: String?
    var available: String?
    var price: String?
    var order_id : String?
    var quantity : String?
    var menuItem : MenuItem?
    var menuCategory : RestaurantDetailObject?


    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        menu_item_id     <- map["menu_item_id"]
        item_name <- map["item_name"]
        description <- map["description"]
        available <- map["available"]
        price <- map["price"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        menuCategory <- map["menu_category"]
        menuItem <- map["menu_item"]

    }
}


class MenuItem : Mappable {
    
    var id                  :       Int?
    var menu_category_id              :       String?
    var item_name              :       String?
    var description              :       String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        item_name <- map["item_name"]
        description <- map["description"]

    }
}



class UserProfileObject : Mappable {
    
    var image                  :       String?
    var imageName              :       String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        imageName <- map["imagename"]
    }
}












class UserData : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}





