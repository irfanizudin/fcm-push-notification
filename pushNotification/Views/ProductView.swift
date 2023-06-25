//
//  SecondScreen.swift
//  pushNotification
//
//  Created by Irfan Izudin on 08/05/23.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var vm: AppViewModel
    let gridLayout = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State var selected: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 15) {
                        ForEach(vm.products, id: \.id) { product in
                            NavigationLink(tag: product.id, selection: $vm.productSelected) {
                                ProductDetailView(id: product.id)
                                    .environmentObject(vm)
                            } label: {
                                ProductCardView(product: product)

                            }

                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .onAppear {
                vm.getProducts()
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.sendPushNotification()
                        print("send push notif")
                    } label: {
                        Text("Send Notif")
                    }

                }
            }
        }
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
            .environmentObject(AppViewModel())
    }
}
