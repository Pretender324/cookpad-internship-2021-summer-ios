import Foundation
import Combine

final class CartState: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func add(product: FetchProductsQuery.Data.Product) -> Void {
        if let itemIndex = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            var item = cartItems[itemIndex]
            item.quantity += 1
            cartItems[itemIndex] = item
        } else {
            cartItems.append(.init(product: product, quantity: 1))
        }
    }
    
    func subtract(product: FetchProductsQuery.Data.Product) -> Void {
        if let itemIndex = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            var item = cartItems[itemIndex]
            if item.quantity > 0 {
                item.quantity -= 1
                cartItems[itemIndex] = item
            }
        }
    }
    
    func clear() {
        cartItems.removeAll()
    }
    
    var totalPrice: Int {
        cartItems.reduce(0) { sum, item in
            sum + item.price
        }
    }
    
    var totalProductCounts: Int {
        cartItems.reduce(0) { sum, item in
            sum + item.quantity
        }
    }
}
