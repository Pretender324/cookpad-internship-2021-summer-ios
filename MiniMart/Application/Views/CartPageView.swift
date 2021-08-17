//
//  CartPageView.swift
//  MiniMart
//
//  Created by 安達陸 on 2021/08/17.
//

import SwiftUI

struct CartPageView: View {
    @EnvironmentObject var cartState: CartState
    @State var isOrderConfirmationAlertPresented = false
    @Binding var isCartViewPresented: Bool
    
    var body: some View {
        VStack {
            List(cartState.cartItems, id: \.product.id) { cartItem in
                HStack(alignment: .top) {
                    RemoteImage(urlString: cartItem.product.imageUrl)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .leading) {
                        Text(cartItem.product.name)
                        Spacer()
                            .frame(height: 8)
                        Text("\(cartItem.product.price)円")
                        Spacer()
                            .frame(height: 8)
                        Text("\(cartItem.quantity)個")
                    }
                        
                        
                    }
                    .padding(.vertical, 8)
                }
            Divider()
            Text("合計: \(cartState.totalPrice)円")
            Divider()
            Button(action: {self.isOrderConfirmationAlertPresented = true }, label: {
                Text("注文する")
            })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.vertical, 8)
        .alert(isPresented: self.$isOrderConfirmationAlertPresented){
                Alert(title: Text("注文が完了しました"),
                      message: nil,
                      dismissButton: Alert.Button.default(Text("OK")) {
                            isCartViewPresented = false
                            cartState.clear()
                }
            )
        }
        .navigationTitle("カート")
    }
}

struct CartPageView_Previews: PreviewProvider {
    @State static var isCartViewPresented: Bool = false
    static var previews: some View {
        CartPageView(isCartViewPresented: $isCartViewPresented)
            .environmentObject(CartState())
    }
}
