//
//  Created by Alex.M on 16.06.2022.
//

import SwiftUI

struct AttachmentCell: View {
    @Environment(\.chatTheme) private var theme

    let attachment: Attachment
    let onTap: (Attachment) -> Void

    var body: some View {
        Group {
            switch attachment.type {
            case .image:
                content
            case .video:
                content
                    .overlay {
                        theme.images.message.playVideo
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                    }
            }
        }
        .contentShape(.rect)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            onTap(attachment)
        }), including: .all)
    }

    var content: some View {
        AsyncImageView(url: attachment.thumbnail)
    }
}

struct AsyncImageView: View {

    @Environment(\.chatTheme) var theme
    let url: URL

    var body: some View {
        CachedAsyncImage(url: url, urlCache: .imageCache) { imageView in
            imageView
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundColor(theme.colors.inputLightContextBackground)
                    .frame(minWidth: 100, minHeight: 100)
                ActivityIndicator(size: 30, showBackground: false)
            }
        }
    }
}
