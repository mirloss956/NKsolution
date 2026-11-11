import SwiftUI
import AVKit
import WebKit

// MARK: - App entry
struct ContentView: View {
    var body: some View {
        WaterCrossRootView()
            .preferredColorScheme(nil) // 跟隨系統淺色／深色模式
    }
}

// MARK: - Data models
struct CharacterProfile: Identifiable {
    let id: String
    let name: String
    let role: String
    let era: String
    let summary: String
    let symbol: String
    let tint: Color
    let imageURL: String?
    let note: String
}

struct StoryChapter: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let body: String
    let symbol: String
    let tag: String
}

struct GalleryItem: Identifiable {
    let id: Int
    let title: String
    let caption: String
    let symbol: String
    let imageURL: String?
}

enum WaterCrossData {
    static let characters: [CharacterProfile] = [
        .init(id: "rene", name: "雷內", role: "水仙十字院出身的研究者", era: "後代四人組",
              summary: "與雅各布一同研究深淵與提瓦特的未來。逐步形成自己的救世方案，並以水仙十字結社推動計畫。",
              symbol: "sparkles", tint: .cyan, imageURL: nil,
              note: "逐字稿中的解讀指出，他的救世理想與手段逐漸走向極端；部分細節仍屬推論。"),
        .init(id: "jacob", name: "雅各布", role: "雷內的重要同伴", era: "後代四人組",
              summary: "幼年重病時受到深淵力量影響，之後協助雷內進行研究與計畫。長年守著水仙十字院相關秘密。",
              symbol: "moon.stars.fill", tint: .indigo, imageURL: nil,
              note: "他如何承受深淵影響，部分原因在遊戲文本中仍未完全說明。"),
        .init(id: "alain", name: "阿蘭", role: "天才研究者、科學家", era: "後代四人組",
              summary: "進入自然哲學學院研究，與雷內對深淵研究及救世方法有不同看法。後來投入機械與能源研究。",
              symbol: "gearshape.2.fill", tint: .orange, imageURL: nil,
              note: "他與雷內的分歧，是水仙十字故事的重要衝突之一。"),
        .init(id: "marianne", name: "瑪麗安", role: "水仙十字院的孩子", era: "後代四人組",
              summary: "與阿蘭一同被收養。她與水仙十字院、純水精靈及後續世界任務的故事彼此交織。",
              symbol: "heart.fill", tint: .pink, imageURL: nil,
              note: "相關身分與世界任務結局的關係，建議搭配遊戲文本一併理解。"),
        .init(id: "beryl", name: "貝瑟", role: "水仙十字院副院長", era: "前代四人組",
              summary: "曾是海軍軍官，照顧水仙十字院的孩子們。深淵災厄期間，她與院長一同投入守護行動。",
              symbol: "sailboat.fill", tint: .teal, imageURL: nil,
              note: "逐字稿依據武器、聖遺物與任務文本拼合其經歷。"),
        .init(id: "director", name: "純水院長", role: "水仙十字院院長", era: "兩代人的連結",
              summary: "以純水精靈身分陪伴孤兒院的孩子。災厄後仍守著約定，成為故事中溫柔而重要的存在。",
              symbol: "drop.fill", tint: .blue, imageURL: nil,
              note: "院長的名字及部分背景，散見於多段任務與物品文本。"),
        .init(id: "carter", name: "卡特", role: "阿蘭的助手與朋友", era: "後代四人組",
              summary: "在自然哲學學院協助阿蘭，也與雷內建立友誼。他的病情促成了雷內研究方向的重要轉折。",
              symbol: "clock.fill", tint: .purple, imageURL: nil,
              note: "卡特事件的細節主要由任務文本與雷內筆記補足。")
    ]

    static let chapters: [StoryChapter] = [
        .init(id: 1, title: "孤兒院與兩代人", subtitle: "故事的起點",
              body: "水仙十字院收容孤兒，也成為兩代孩子共同的家。前代與後代人物之間，透過收養、承諾與舊物彼此連結。",
              symbol: "house.fill", tag: "角色關係"),
        .init(id: 2, title: "白松鎮的創傷", subtitle: "人與人之間的衝突",
              body: "逐字稿將白松鎮事件視為楓丹暗線的重要背景：權力與貧困的衝突造成悲劇，也影響雷內等人對楓丹廷的信任。",
              symbol: "flame.fill", tag: "背景"),
        .init(id: 3, title: "深淵研究與分歧", subtitle: "朋友走向不同道路",
              body: "雷內、雅各布與阿蘭投入研究，卻對風險、證據與拯救方式有不同判斷。卡特事件使原本的分歧更加尖銳。",
              symbol: "waveform.path.ecg", tag: "轉折"),
        .init(id: 4, title: "水仙十字結社", subtitle: "救世理想的代價",
              body: "雷內以水仙十字院之名建立結社，嘗試尋找改變命運的方法。其計畫的部分細節，需結合任務、筆記及物品文本解讀。",
              symbol: "water.waves", tag: "計畫"),
        .init(id: 5, title: "《水仙的安》", subtitle: "記憶、夢境與告別",
              body: "世界任務將童話、記憶與水仙十字院的往事交織。它既是冒險故事，也讓玩家重新思考角色的身分與承諾。",
              symbol: "book.closed.fill", tag: "世界任務")
    ]

    static let gallery: [GalleryItem] = [
        .init(id: 1, title: "水仙十字院", caption: "兩代人的故事起點", symbol: "building.2.fill", imageURL: nil),
        .init(id: 2, title: "水仙十字結社", caption: "以救世為名的計畫", symbol: "circle.hexagongrid.fill", imageURL: nil),
        .init(id: 3, title: "原始胎海之水", caption: "楓丹劇情的重要意象", symbol: "water.waves", imageURL: nil),
        .init(id: 4, title: "白松鎮", caption: "逐字稿提及的歷史創傷", symbol: "tree.fill", imageURL: nil),
        .init(id: 5, title: "懷錶與舊物", caption: "記憶與承諾的象徵", symbol: "clock.fill", imageURL: nil),
        .init(id: 6, title: "童話與勇者", caption: "孩子們的角色扮演遊戲", symbol: "book.fill", imageURL: nil)
    ]
}

// MARK: - Reusable styles
struct SoftCardModifier: ViewModifier {
    var tint: Color = .blue
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(tint.opacity(0.09), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(tint.opacity(0.15), lineWidth: 1))
    }
}

extension View {
    func softCard(tint: Color = .blue) -> some View {
        modifier(SoftCardModifier(tint: tint))
    }

    @ViewBuilder
    func inlineNavigationBarTitle() -> some View {
        #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
        self.navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }

    @ViewBuilder
    func urlInputStyle() -> some View {
        #if os(iOS) || os(tvOS) || os(visionOS)
        self.textInputAutocapitalization(.never)
            .keyboardType(.URL)
        #else
        self
        #endif
    }
}

// MARK: - Root tabs
struct WaterCrossRootView: View {
    var body: some View {
        TabView {
            Tab("首頁", systemImage: "house.fill") {
                NavigationStack { HomeView() }
            }
            Tab("角色", systemImage: "person.3.fill") {
                NavigationStack { CharacterListView() }
            }
            Tab("劇情", systemImage: "book.closed.fill") {
                NavigationStack { StoryView() }
            }
            Tab("影片", systemImage: "play.rectangle.fill") {
                NavigationStack { VideoHubView() }
            }
            Tab("圖鑑", systemImage: "square.grid.2x2.fill") {
                NavigationStack { GalleryView() }
            }
        }
        .tabViewStyle(.sidebarAdaptable) // iPhone 底部標籤；iPad 可使用側邊欄
        .tint(.cyan)
    }
}

// MARK: - Landing page
struct HomeView: View {
    @State private var showIntro = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(colors: [.indigo, .blue, .cyan.opacity(0.8)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                    Circle().fill(.white.opacity(0.12)).frame(width: 220).blur(radius: 1)
                        .offset(x: 210, y: -50)
                    VStack(alignment: .leading, spacing: 10) {
                        Label("FONTAINE · STORY GUIDE", systemImage: "drop.fill")
                            .font(.caption.weight(.bold)).tracking(1.4)
                            .foregroundStyle(.white.opacity(0.85))
                        Text("水仙十字")
                            .font(.system(size: 38, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                        Text("以救世之名，追尋被遺忘的故事")
                            .font(.headline).foregroundStyle(.white.opacity(0.9))
                        Button {
                            withAnimation(.spring(duration: 0.45)) { showIntro.toggle() }
                        } label: {
                            Label(showIntro ? "收合導讀" : "展開導讀",
                                  systemImage: showIntro ? "chevron.up" : "arrow.right")
                                .font(.subheadline.weight(.bold))
                                .padding(.horizontal, 16).padding(.vertical, 10)
                                .background(.white, in: Capsule())
                                .foregroundStyle(.indigo)
                        }
                        .padding(.top, 4)
                    }
                    .padding(24)
                }
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 58))
                        .foregroundStyle(.white.opacity(0.28))
                        .symbolEffect(.pulse, options: .repeating)
                        .padding(24)
                }

                if showIntro {
                    Text("本指南依據提供的劇情分析逐字稿整理。遊戲文本中的明確資訊與創作者的推論會分開呈現；涉及未明說的身世、計畫細節或象徵解讀，請視為分析觀點。")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .softCard(tint: .cyan)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

                VStack(alignment: .leading, spacing: 12) {
                    SectionHeading(title: "故事速覽", subtitle: "左右滑動，快速掌握脈絡")
                    #if os(macOS)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(WaterCrossData.chapters) { chapter in
                                NavigationLink {
                                    ChapterDetailView(chapter: chapter)
                                } label: {
                                    ChapterCard(chapter: chapter)
                                        .frame(width: 320)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 3)
                    }
                    .frame(height: 210)
                    #else
                    TabView {
                        ForEach(WaterCrossData.chapters) { chapter in
                            NavigationLink {
                                ChapterDetailView(chapter: chapter)
                            } label: {
                                ChapterCard(chapter: chapter)
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 3)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 210)
                    #endif
                }

                VStack(alignment: .leading, spacing: 12) {
                    SectionHeading(title: "認識關鍵角色", subtitle: "點選角色查看介紹")
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 12) {
                            ForEach(WaterCrossData.characters.prefix(5)) { character in
                                NavigationLink {
                                    CharacterDetailView(character: character)
                                } label: {
                                    CharacterMiniCard(character: character)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }

                NavigationLink {
                    StoryView()
                } label: {
                    HStack {
                        Image(systemName: "text.book.closed.fill")
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text("從頭梳理水仙十字")
                                .font(.headline)
                            Text("五個章節・含解讀提示")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .softCard(tint: .indigo)
                }
                .buttonStyle(.plain)

                Text("內容為粉絲向劇情整理，角色與作品著作權歸原權利人所有。")
                    .font(.caption2).foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 18)
            }
            .padding()
        }
        .navigationTitle("水仙十字")
        .inlineNavigationBarTitle()
    }
}

struct SectionHeading: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.title3.bold())
            Text(subtitle).font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct ChapterCard: View {
    let chapter: StoryChapter
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: chapter.symbol)
                    .font(.title2).symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.cyan)
                    .symbolEffect(.bounce, value: chapter.id)
                Spacer()
                Text(chapter.tag).font(.caption.bold())
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(.cyan.opacity(0.12), in: Capsule())
            }
            Text(chapter.title).font(.title2.bold())
            Text(chapter.subtitle).font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
            Text(chapter.body).font(.caption).foregroundStyle(.secondary)
                .lineLimit(2)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .softCard(tint: .cyan)
    }
}

struct CharacterMiniCard: View {
    let character: CharacterProfile
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: character.symbol)
                .font(.title2)
                .foregroundStyle(character.tint)
                .frame(width: 46, height: 46)
                .background(character.tint.opacity(0.12), in: Circle())
            Text(character.name).font(.headline)
            Text(character.role).font(.caption).foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .frame(width: 145, height: 120, alignment: .leading)
        .softCard(tint: character.tint)
    }
}

// MARK: - Characters
struct CharacterListView: View {
    var body: some View {
        List(WaterCrossData.characters) { character in
            NavigationLink {
                CharacterDetailView(character: character) // 將自訂 struct 資料傳到下一頁
            } label: {
                HStack(spacing: 14) {
                    CharacterSymbol(character: character, size: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(character.name).font(.headline)
                        Text(character.role).font(.subheadline).foregroundStyle(.secondary)
                        Text(character.era).font(.caption).foregroundStyle(character.tint)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("角色介紹")
    }
}

struct CharacterDetailView: View {
    let character: CharacterProfile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                CharacterSymbol(character: character, size: 96)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                Text(character.name).font(.largeTitle.bold())
                Label(character.role, systemImage: "person.fill")
                    .font(.headline).foregroundStyle(character.tint)
                Text(character.summary).font(.body).lineSpacing(5)
                VStack(alignment: .leading, spacing: 8) {
                    Label("閱讀提示", systemImage: "lightbulb.fill")
                        .font(.headline).foregroundStyle(.orange)
                    Text(character.note).font(.subheadline).foregroundStyle(.secondary)
                }
                .softCard(tint: .orange)
            }
            .padding()
        }
        .navigationTitle(character.name)
        .inlineNavigationBarTitle()
    }
}

struct CharacterSymbol: View {
    let character: CharacterProfile
    var size: CGFloat
    var body: some View {
        ZStack {
            Circle().fill(character.tint.gradient)
            Image(systemName: character.symbol)
                .font(.system(size: size * 0.42, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(width: size, height: size)
        .shadow(color: character.tint.opacity(0.25), radius: 10, y: 5)
        .accessibilityLabel(character.name)
    }
}

// MARK: - Story
struct StoryView: View {
    var body: some View {
        List(WaterCrossData.chapters) { chapter in
            NavigationLink {
                ChapterDetailView(chapter: chapter)
            } label: {
                Label {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(chapter.title).font(.headline)
                        Text(chapter.subtitle).font(.caption).foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: chapter.symbol)
                        .foregroundStyle(.cyan)
                        .frame(width: 30)
                }
            }
        }
        .navigationTitle("劇情脈絡")
    }
}

struct ChapterDetailView: View {
    let chapter: StoryChapter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Image(systemName: chapter.symbol)
                    .font(.system(size: 56))
                    .foregroundStyle(.cyan.gradient)
                    .symbolEffect(.pulse, options: .repeating)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                Text(chapter.title).font(.largeTitle.bold())
                Text(chapter.subtitle).font(.title3.weight(.medium)).foregroundStyle(.secondary)
                Text(chapter.body).font(.body).lineSpacing(7)
                Divider()
                Label("本頁整理自提供的逐字稿；對尚未由遊戲明確說明的內容，以「分析觀點」呈現。", systemImage: "info.circle")
                    .font(.footnote).foregroundStyle(.secondary)
                    .softCard(tint: .blue)
            }
            .padding()
        }
        .navigationTitle(chapter.title)
        .inlineNavigationBarTitle()
    }
}

// MARK: - Gallery
struct GalleryView: View {
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(WaterCrossData.gallery) { item in
                    GalleryTile(item: item)
                }
            }
            .padding()
        }
        .navigationTitle("意象圖鑑")
    }
}

struct GalleryTile: View {
    let item: GalleryItem
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [.cyan.opacity(0.22), .indigo.opacity(0.16)],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                if let urlString = item.imageURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFill()
                        } else {
                            Image(systemName: item.symbol).font(.system(size: 34)).foregroundStyle(.cyan)
                        }
                    }
                    .frame(height: 120).clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: item.symbol)
                        .font(.system(size: 38, weight: .medium))
                        .foregroundStyle(.cyan.gradient)
                        .symbolRenderingMode(.hierarchical)
                }
            }
            .frame(height: 120)
            Text(item.title).font(.headline)
            Text(item.caption).font(.caption).foregroundStyle(.secondary).lineLimit(2)
        }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.quaternary, lineWidth: 1))
    }
}

// MARK: - Video / WebView
struct VideoHubView: View {
    @State private var webAddress = ""
    @State private var videoAddress = ""
    @State private var webURL: URL?
    @State private var player: AVPlayer?
    @State private var notice = "貼上影片網頁網址，或貼上可直接播放的 MP4 網址。"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Label("影片導讀", systemImage: "play.rectangle.fill")
                        .font(.title2.bold())
                    Text("目前未預設特定影片。可貼入你有權使用的影片連結；YouTube 等網頁影片會以 WebView 開啟，直連 MP4 則以 VideoPlayer 播放。")
                        .font(.subheadline).foregroundStyle(.secondary)
                    TextField("影片網頁網址（例如 YouTube）", text: $webAddress)
                        .urlInputStyle()
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                    Button {
                        loadWebPage()
                    } label: {
                        Label("載入網頁影片", systemImage: "globe")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    if let webURL {
                        WebView(url: webURL)
                            .frame(height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .transition(.opacity)
                    }
                }
                .softCard(tint: .blue)

                VStack(alignment: .leading, spacing: 10) {
                    Label("直接播放影片", systemImage: "video.fill")
                        .font(.title3.bold())
                    TextField("直連 MP4 網址", text: $videoAddress)
                        .urlInputStyle()
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                    Button {
                        loadVideo()
                    } label: {
                        Label("播放 MP4", systemImage: "play.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    if let player {
                        VideoPlayer(player: player)
                            .frame(height: 230)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .softCard(tint: .indigo)

                Text(notice)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle("影片")
        .onDisappear { player?.pause() }
    }

    private func loadWebPage() {
        guard let url = validURL(webAddress) else {
            notice = "網址格式不正確，請確認以 https:// 或 http:// 開頭。"
            return
        }
        withAnimation(.easeInOut) { webURL = url }
        notice = "網頁已載入。若影片平台限制內嵌播放，請改用平台提供的嵌入連結。"
    }

    private func loadVideo() {
        guard let url = validURL(videoAddress) else {
            notice = "MP4 網址格式不正確，請貼上可公開存取的影片直連網址。"
            return
        }
        player?.pause()
        player = AVPlayer(url: url)
        player?.play()
        notice = "影片已開始播放。"
    }

    private func validURL(_ string: String) -> URL? {
        guard let url = URL(string: string.trimmingCharacters(in: .whitespacesAndNewlines)),
              ["https", "http"].contains(url.scheme?.lowercased() ?? "") else { return nil }
        return url
    }
}

#if os(macOS)
import AppKit

struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.allowsBackForwardNavigationGestures = true
        view.load(URLRequest(url: url))
        return view
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        guard nsView.url != url else { return }
        nsView.load(URLRequest(url: url))
    }
}
#elseif canImport(UIKit)
import UIKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.allowsBackForwardNavigationGestures = true
        view.scrollView.isScrollEnabled = true
        view.load(URLRequest(url: url))
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard uiView.url != url else { return }
        uiView.load(URLRequest(url: url))
    }
}
#endif
#Preview {
    ContentView()
}

