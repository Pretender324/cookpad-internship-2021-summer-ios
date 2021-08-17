//
//  CartItem.swift
//  MiniMart
//
//  Created by 安達陸 on 2021/08/17.
//

import Foundation

struct CartItem {
    var product: FetchProductsQuery.Data.Product
    var quantity: Int
    
    var price: Int {
        product.price * quantity
    }
    
}
