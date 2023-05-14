//
//  ProductDetailView.swift
//  pushNotification
//
//  Created by Irfan Izudin on 08/05/23.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var vm: AppViewModel
    let id: Int
    
    var body: some View {
        ScrollView {
            if let image = vm.product?.image,
               let title = vm.product?.title,
               let description = vm.product?.description,
               let price = vm.product?.price {
                
                VStack {
                    AsyncImage(url: URL(string: image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200, alignment: .center)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    Text(description)
                        .font(.body)
                        .foregroundColor(Color.black.opacity(0.8))
                    
                    Divider()
                    
                    Text("Rp \(price)")
                        .font(.callout)
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                
                
            }
        }
        .navigationTitle("Product Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.getProductDetail(id: id)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(id: 1)
            .environmentObject(AppViewModel())
    }
}
