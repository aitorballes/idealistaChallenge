import SwiftUI

struct CustomImageView: View {
    let imageUrl: URL
    let size: CGFloat
    let contentMode: ContentMode

    init(imageUrl: URL, size: CGFloat = 80, contentMode: ContentMode = .fit) {
        self.imageUrl = imageUrl
        self.size = size
        self.contentMode = contentMode
    }

    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width:size, height: size)

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(height: size)
                    .clipped()
                    .cornerRadius(10)
            case .failure(_):
                Image(systemName: "photo.circle")
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(height: size)
                    .clipped()
                    .cornerRadius(10)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }

        }
    }
}

#Preview {
    CustomImageView(imageUrl: URL(string: "https://img4.idealista.com/blur/480_360_mq/0/id.pro.es.image.master/45/42/55/1216590405.webp")!)
                    

}
