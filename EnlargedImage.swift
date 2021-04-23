import SwiftUI

struct EnlargedImage: View {
    //required to pass in
    var image: UIImage!
    
    //calculated:
    @State var scale: CGFloat = 1.0
    @State var lastScaleValue: CGFloat = 1.0
    @State var originalScale: CGFloat = 1.0
    
    //for supporting closing from a sheet or navigation view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            
            GeometryReader(content: { geometry in
                Color.clear.frame(width: 1, height: 1).onAppear(perform: {
                    print("calculating geo for image")
                    print(image.size)
                    print(geometry.size)
                    if image.size.width >= image.size.height {
                        if image.size.width > geometry.size.width {
                            originalScale = 1 - ((image.size.width - geometry.size.width) / image.size.width)
                            scale = originalScale
                        } else {
                            originalScale = 1
                            scale = 1
                        }
                    } else {
                        if image.size.height > geometry.size.height {
                            originalScale = 1 - ((image.size.height - geometry.size.height) / image.size.height)
                            scale = originalScale
                        } else {
                            originalScale = 1
                            scale = 1
                        }
                    }
                    print("original scale: \(originalScale)")
                })
            })
            
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                ZStack {
        
                    Image(uiImage: image).aspectRatio(contentMode: .fit).scaleEffect(scale)
                        .gesture(MagnificationGesture().onChanged { val in
                            let delta = val / self.lastScaleValue
                            self.lastScaleValue = val
                            var newScale = self.scale * delta
                            if newScale < originalScale
                            {
                                newScale = originalScale
                            }
                            scale = newScale
                        }.onEnded{val in
                            lastScaleValue = 1
                        })
                    
                }.frame(width: image.size.width * scale, height: image!.size.height * scale, alignment: .center)
            }.background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            //shows a close button, remove if you like:
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Text("close").padding(). //your close button text or image, or just remove the entire button
                    })
                }
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
