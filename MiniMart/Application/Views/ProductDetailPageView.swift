//
//  ProductDetailPageView.swift
//  MiniMart
//
//  Created by 安達陸 on 2021/08/17.
//

import SwiftUI

struct ProductDetailPageView: View {
    var product: FetchProductsQuery.Data.Product
    @EnvironmentObject var cartState: CartState
    @State var isCartViewPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                RemoteImage(urlString: product.imageUrl)
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.title)
                    Spacer()
                        .frame(height: 32)
                    Text("\(product.price)")
                        .font(.title)
                        + Text("円")
                    Spacer()
                        .frame(height: 32)
                    Text(product.summary)
                    Spacer()
                        .frame(height: 32)
                    Button(action: {
                        cartState.add(product: product)
                    }, label: {
                        Text("カートに追加")
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.isCartViewPresented = true
                }) {
                    VStack {
                        Image(systemName: "folder")
                        Text("\(cartState.totalProductCounts)")
                        }
                }
            }
        }
        .sheet(isPresented: $isCartViewPresented){
            NavigationView{
                CartPageView(isCartViewPresented: $isCartViewPresented)
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                id: UUID().uuidString,
                name: "商品 \(1)",
                price: 100,
                summary: "おいしい食材 \(1)",
                imageUrl: "https://image.mini-mart.com/dummy/1"
                )
            )
        }
        .environmentObject(CartState())
    }
}
