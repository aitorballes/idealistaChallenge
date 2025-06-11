import SwiftUI

struct ImageZoomView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var imageRotation: Double = 0

    let imageUrl: URL

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear

                CustomImageView(
                    imageUrl: imageUrl,
                    size: 300,
                    contentMode: .fit
                )
                .cornerRadius(10)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                .opacity(isAnimating ? 1 : 0)
                .animation(.linear(duration: 1), value: isAnimating)
                .offset(x: imageOffset.width, y: imageOffset.height)
                .scaleEffect(imageScale)
                .rotationEffect(.degrees(imageRotation))
                .onTapGesture(
                    count: 2,
                    perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                        .onEnded { _ in
                            if imageScale > 5 {
                                imageScale = 5
                            } else if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
            }
            .onAppear(perform: {
                isAnimating = true
            })
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30),
                alignment: .top
            )
            .overlay(
                Group {
                    HStack {

                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1

                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }

                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(
                                icon:
                                    "arrow.up.left.and.down.right.magnifyingglass"
                            )
                        }

                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1

                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }

                        Button {
                            withAnimation(.spring()) {
                                imageRotation += 90
                            }
                        } label: {
                            ControlImageView(icon: "rotate.right")
                        }

                        Button {
                            withAnimation(.spring()) {
                                imageRotation -= 90
                            }
                        } label: {
                            ControlImageView(icon: "rotate.left")
                        }
                    }
                    .padding(
                        EdgeInsets(
                            top: 12,
                            leading: 20,
                            bottom: 12,
                            trailing: 20
                        )
                    )
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 30),
                alignment: .bottom
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .tint(.primary)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    private func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
}

struct ControlImageView: View {
    let icon: String

    var body: some View {
        Image(systemName: icon)
            .imageScale(.large)

    }
}

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize

    @State private var isInfoPanelVisible: Bool = false

    var body: some View {
        HStack {

            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }

            Spacer()

            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")

                Spacer()

                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")

                Spacer()

                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")

                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)

            Spacer()
        }
    }
}

#Preview {
    ImageZoomView(
        imageUrl: URL(
            string:
                "https://img4.idealista.com/blur/480_360_mq/0/id.pro.es.image.master/45/42/55/1216590405.webp"
        )!
    )
}
