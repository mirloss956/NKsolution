import SwiftUI
import AVKit
import WebKit

// MARK: - App entry
struct ContentView: View {
    var body: some View {
        WaterCrossRootView()
            .preferredColorScheme(nil)
    }
}

// MARK: - Data models
struct CharacterProfile: Identifiable {
    let id: String
    let name: String
    let role: String
    let era: String
    let imageName: String?
    let introduction: String
}

struct StoryChapter: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let backgroundName: String
    let body: String
}

struct GalleryItem: Identifiable {
    let id: Int
    let title: String
    let caption: String
    let imageName: String
}

enum WaterCrossData {
    static let characters: [CharacterProfile] = [
        .init(
            id: "rene", name: "雷內", role: "研究者／水仙十字結社的大師", era: "後代四人組",
            imageName: "Character_Rene",
            introduction: """
            雷內是白松鎮鎮長雷諾的兒子。白松之圍後，他與雅各布失去父親，一起進入水仙十字院，在那裡和阿蘭、瑪麗安成為朋友。童年時四人常玩「勇者鬥惡龍」：雷內扮演惡龍，雅各布是巫師，阿蘭是勇者，瑪麗安則是公主。雷內一直戴著阿蘭送給他的懷錶，裡面保存著水仙十字院眾人的合照。

            被冒險家卡爾收養後，雷內跟著他前往須彌，接觸坎瑞亞遺跡與古代知識。他分析甘露花海的聖蓮時，發現自己與雅各布的身體組分和聖蓮有相似之處；雅各布病危時，他更瞞著卡爾使用深淵力量救人。雅各布活了下來，身體也發生變化，獲得承受深淵力量的能力。這次成功使雷內相信，世界之外的力量可能成為改變命運的變數。

            回到楓丹後，雷內進入自然哲學學院，先在阿蘭的研究室工作。他依據坎瑞亞資料推導出「世界式」，反覆計算提瓦特的未來，得出楓丹將遭遇漲水、提瓦特也可能迎來毀滅的結果。阿蘭要求親自驗算，並不接受單憑雷內的結論；雷內則認為時間緊迫，必須立即尋找解法。兩人的友情仍在，對證據與救世方式的根本分歧卻逐漸擴大。

            雷內曾嘗試用深淵力量救治好友卡特，結果卡特的身體崩解成異形，雖然仍有聲音與再生能力，卻無法恢復原狀。雷內沒有停止照料與研究，但這場失敗使他明白，深淵並不能直接把所有人改造成能承受力量的生命。此後他轉向佩特利克一帶的古代遺跡，研究靈魂、純水精靈、原始胎海之水與雷穆利亞留下的密合之約印，並以水仙十字院之名建立結社。

            雷內的古代儀式不是單純把人投入水中，而是要以密合之約印構成法陣，以聖劍作為汲取、統合意志的媒介，並借助莉莉絲這名純水精靈與原始胎海之水，讓個體意識離開原有形體、匯聚到新的承載者身上。他相信只要保存並統御眾人的意識，就能讓生命在末日中延續。結社後來以「自我割捨」儀式讓成員交出部分自我，由雷內統合；參與者不一定當場死亡，但會失去部分自主意志。

            雷內第一次把自己當作實驗對象，試圖經儀式在原始胎海中重構身體，卻失去原有形體與部分自我。雅各布為了救他，利用阿蘭懷錶中留下的情感與記憶、卡特殘存的意識等材料，重新塑造出納齊森·科魯茲，並移除雷內兩次失敗的記憶。新生的雷內仍相信自己能拯救世界，逐步完成格式塔高塔與法陣，準備接收被原始胎海溶解的楓丹人意識。

            楓丹方面開始清算水仙十字結社後，雷內安排成員與阿蘭一方在厄里納斯交戰，自己留在格式塔爭取完成計畫的時間。旅行者成為世界式原本沒有納入的變數，芙卡洛斯也已改變楓丹的命運。雷內確認世界已獲拯救後，接受自己的計畫不再必要，與昔日同伴的記憶重逢，最後在瑪麗安的夢境中告別。
            """
        ),
        .init(
            id: "jacob", name: "雅各布", role: "研究者／雷內的同伴", era: "後代四人組",
            imageName: "Character_Jacob",
            introduction: """
            雅各布是灰河領袖愛德華多·貝克的兒子。白松之圍中父親遇害後，他和雷內一起被送進水仙十字院，童年遊戲裡經常扮演巫師。深淵災厄後，冒險家卡爾收養兩人並帶他們前往須彌。雅各布在旅途中身患重病，雷內以深淵力量救治，使他活了下來；從那時起，他的身體便能承受並逐步吸收深淵力量。

            回到楓丹後，雅各布與雷內一起進入自然哲學學院，參與世界式與深淵研究。他曾自行進入厄里納斯體內吸收血肉，逐漸能短暫開啟深淵通道，召出流血狗。雖然這些力量讓他害怕，他仍願意繼續嘗試，因為他相信雷內的計畫可能找到拯救眾人的方法。

            雅各布看似膽小，遇到關鍵時刻卻常做出大膽決定。他不只支持雷內，也會在雷內失敗後接手整個水仙十字結社。雷內第一次自我重構失敗、失去形體與自我後，雅各布一面向結社成員隱瞞狀況，一面研究如何讓雷內復原。他以卡特殘存的意識、阿蘭懷錶留下的記憶與情感等材料重塑雷內，並拿掉他失敗的記憶，希望雷內能以理想中的救世者身分繼續前進。

            雷內與雅各布自幼相識，是彼此最信任的同伴。卡爾是兩人的養父；阿蘭與瑪麗安是水仙十字院的童年好友。父親愛德華多死於白松之圍，艾瑪紐埃爾又是當年參與行動的主影獵人，這段歷史讓雅各布與楓丹官方始終存在難以抹去的距離。貝瑟曾把帽上的羽毛交給雅各布代為保管，他多年守著這項約定。

            雷內沉入原始胎海後，雅各布管理結社、重塑雷內，也暗中在楓丹各地逆轉密合之約印，為雷內的復甦做準備。他曾把結社中反對自己的人當成實驗對象，也讓卡特皮拉得以誕生。後來旅行者一行打敗雅各布，聖劍與計畫的最後一步已完成；雅各布在末日時鐘前倒下，結束了自己長久守護雷內計畫的一生。
            """
        ),
        .init(
            id: "alain", name: "阿蘭", role: "科學家／自然哲學學院研究者", era: "後代四人組",
            imageName: "Character_Alain",
            introduction: """
            阿蘭和妹妹瑪麗安在水仙十字院長大，後來由主影獵人艾瑪紐埃爾·吉約丹收養。童年時阿蘭常扮演勇者，熱愛機械，曾以廢料製作懷錶送給雷內與雅各布。進入自然哲學學院後，他很快展現出驚人的研究天分，建立自己的研究團隊，投入坎瑞亞機械、能源與荒芒湮滅研究，最後完成可控的荒芒湮滅反應。

            雷內回到楓丹後，曾在阿蘭的研究室工作。阿蘭尊重好友，卻不願只靠推演就接受提瓦特必然毀滅的結論。他想親自驗算世界式，也認為深淵力量危險、難以控制。雷內則相信時間不等人，兩人雖然珍惜彼此，仍逐漸走上不同道路。

            阿蘭的助手卡特也是水仙十字院出身。卡特病重期間，阿蘭仍持續研究，但也會去探望他；他曾因擔心卡特回來找不到路，遲遲不搬到新的實驗室。卡特建議他製作一個會思考的留影機，提醒他多陪伴家人、留下共同回憶。阿蘭後來把這個點子化為西摩爾，一具能思考並陪伴瑪麗安的發條機關。

            雷內以深淵力量救治卡特失敗後，阿蘭與他決裂。這並非抹去兩人童年友情，而是阿蘭無法接受以朋友為代價繼續實驗。此後阿蘭離開原有體制，創立楓丹科學院，持續投入機械研究。艾瑪紐埃爾是他的養父，瑪麗安是他最珍視的妹妹；雷內與雅各布則是他從童年到學院時期都曾並肩的朋友。阿蘭晚年的研究成果與最終去向沒有明確交代，但西摩爾承載著他對妹妹的關心，繼續參與瑪麗安、安與瑪梅赫的旅程。
            """
        ),
        .init(
            id: "marianne", name: "瑪麗安", role: "水仙十字院的孩子", era: "後代四人組",
            imageName: "Character_Marianne",
            introduction: """
            瑪麗安是阿蘭的妹妹，從小和哥哥一起生活在水仙十字院，與雷內、雅各布一同長大。四人玩「勇者鬥惡龍」時，她常扮演等待勇者營救的公主。深淵災厄後，瑪麗安由艾瑪紐埃爾收養，與阿蘭一起留在楓丹。她和童年的朋友們始終有牽連，也曾回到被淹沒的水仙十字院探望莉莉絲。

            瑪麗安不是以研究或結社計畫推動事件的人物，但她是阿蘭、雷內、雅各布與莉莉絲都想守護的家人。卡特曾特別替她拍照，希望阿蘭不要因研究而錯過妹妹成長；西摩爾則是阿蘭為了陪伴她而製作的機械。

            水仙十字結社與阿蘭一方在厄里納斯附近交戰時，瑪麗安身受重傷。莉莉絲看到孩子將要死去，出於本能抱住她，兩人的意識與記憶因此融合。此後瑪麗安的存在延續在莉莉絲與夢境之中，並孕育出純水精靈安。安的故事帶著瑪麗安的記憶、莉莉絲的記憶，也有自己逐漸形成的生命。

            阿蘭是瑪麗安的哥哥，艾瑪紐埃爾是養父；雷內、雅各布與卡特是她自幼相識的朋友。她與莉莉絲的融合成為安誕生的關鍵，也讓西摩爾在後來的旅途中繼續尋找她。安走出童話般的故事後，與西摩爾、瑪梅赫踏上新的旅程，瑪麗安的故事也以另一種方式向前延續。
            """
        ),
        .init(
            id: "lilith", name: "莉莉絲", role: "水仙十字院院長／純水精靈", era: "兩代人的連結",
            imageName: "Character_Lilith",
            introduction: """
            莉莉絲是水仙十字院的純水精靈院長。她不擅長理解事情的前因後果，也不會數數，卻能把慈愛平等地分給每一個孩子。每當有新孩子來到孤兒院，她往往會親自迎接、擁抱他們。她和副院長貝瑟一起照顧雷內、雅各布、阿蘭、瑪麗安等孩子，成為兩代水仙十字院成員共同的依靠。

            深淵災厄期間，莉莉絲跟隨同族抵禦威脅。災厄過後，她回到已被淹沒的水仙十字院，仍相信孩子們會回來。楓丹的水受到厄里納斯影響，其他純水精靈大多離開，莉莉絲卻長年留在舊院等待。雷內與雅各布回來探望她時，她很高興孩子們記得回家；兩人也帶她前往新的居所。

            雷內的儀式需要純水精靈與原始胎海之水協助，莉莉絲因此成為他計畫中重要的一環。她並不一定理解儀式背後的全部目的，但仍以院長的身分陪伴孩子。厄里納斯一戰中，瑪麗安瀕死，莉莉絲本能地抱住她，讓兩人的意識與記憶融合。莉莉絲既是雷內、雅各布、阿蘭、瑪麗安的院長，也是安的故事與夢境的重要來源；她的等待與擁抱，把孤兒院的過去連到後日談。
            """
        ),
        .init(
            id: "beryl", name: "貝瑟", role: "水仙十字院副院長／前海軍司令", era: "前代四人組",
            imageName: "Character_Beryl",
            introduction: """
            貝瑟曾是楓丹海軍司令，後來成為水仙十字院副院長。長年的軍旅生活讓她性格剛烈、行事直接；進入孤兒院後，她開始學做點心，最後做出的下午茶成為孩子們最期待的日常。她自己也出身水仙十字院，與卡爾、艾瑪紐埃爾、德懷特同屬前代四人組，童年時也玩過勇者與惡龍的角色扮演。

            貝瑟與莉莉絲共同照顧孩子。白松之圍後，卡爾成為冒險家，艾瑪紐埃爾退出主影獵人工作，德懷特則在自然哲學學院任職；他們仍是貝瑟能拜託的舊友。深淵災厄與漲水危機來臨時，孤兒院無法繼續收留孩子，她聯絡卡爾與艾瑪紐埃爾，安排雷內、雅各布、阿蘭、瑪麗安各自被收養。

            臨行迎戰厄里納斯前，貝瑟把帽上的羽毛交給雅各布，說這不是送給他，而是請他代為保管，等自己回來再取。她也與艾瑪紐埃爾約定，等戰事結束後要親自下廚，讓老朋友嚐嚐自己進步的手藝。貝瑟率領斯彭西安號等船艦迎戰厄里納斯，最後下令衝向海獸掩護其他船隻撤離，與艦船一同沉入海中。她沒有回到孤兒院取回羽毛，但這項託付陪伴雅各布多年。
            """
        ),
        .init(
            id: "carterpilar", name: "卡特皮拉", role: "梅洛彼得堡的少年", era: "後日談",
            imageName: "Character_Caterpillar",
            introduction: """
            卡特皮拉是雅各布以卡特殘留物與丘丘人身體所塑成的存在。卡特的身體曾在深淵實驗中崩解，雅各布先取出其中與雷內相關的記憶材料，之後將剩下的部分放進丘丘人體內，讓卡特皮拉得以活動。卡特皮拉因此帶著卡特的部分意識，卻沒有一段完整承接卡特人生的記憶。

            他在梅洛彼得堡生活，認識了利諾爾，也在與旅行者相處的過程中追問自己的來歷。卡特皮拉想知道自己究竟是誰、與卡特有什麼關係，並希望能成為真正的人。他的自我探索並不容易：他所能找到的線索，多半來自雷內、雅各布對卡特的記憶與執念，而不是自己親身經歷的人生。

            雷內與雅各布是創造並照料卡特皮拉的人；卡特是他重要的意識來源，但兩者並不完全相同。利諾爾是他在梅洛彼得堡真心關心的孩子。卡特皮拉曾陪伴利諾爾、替他完成心願，之後仍走上尋找自我的路。他的身體形態並不穩定，記憶與自我也有可能逐漸消退，因此他的未來仍充滿不確定。
            """
        ),
        .init(
            id: "ann", name: "安", role: "故事中的純水精靈", era: "後日談",
            imageName: "Character_Ann",
            introduction: """
            安是與瑪麗安、莉莉絲的記憶和夢境相連的純水精靈。她生活在童話般的冒險故事裡，把自己當作勇者，踏上尋找公主、對抗惡龍的旅程。她相信故事中的同伴，也努力完成自己認定的使命；旅行者陪伴她走出故事後，她開始理解記憶、夢境與現實之間並非完全相同。

            安的故事承載著水仙十字院孩子們玩過的勇者鬥惡龍遊戲，也與瑪麗安和莉莉絲的記憶交織。莉莉絲是她故事的重要核心，瑪麗安則透過夢境與回憶留在其中。西摩爾陪伴安尋找瑪麗安，瑪梅赫也加入旅途。安走出原本的故事後，沒有停留在過去，而是和西摩爾、瑪梅赫一起踏上新的旅程，開始認識更廣闊的世界。
            """
        ),
        .init(
            id: "carter", name: "卡特", role: "阿蘭的助手與朋友", era: "後代四人組",
            imageName: nil,
            introduction: """
            卡特出身水仙十字院，成年後成為自然哲學學院的研究助手，長期協助阿蘭。他為人熱心，看到阿蘭與雷內長時間埋首研究，便以田野調查為名安排大家到佩特利克鎮散心，還借來留影機拍下瑪麗安與朋友們的照片。他希望阿蘭將來回想起妹妹時，手上有真實的共同回憶。

            卡特患有難以治癒的重病，病情逐漸惡化。阿蘭與雷內都忙於研究，仍會抽空探望他；雷內也曾把卡特的血液和皮膚樣本送往須彌求醫。當傳統治療沒有辦法時，雅各布提出以深淵力量救治。雷內向卡特說明風險與自己的研究目的後，卡特仍決定接受實驗，因為他不想只是等待死亡。

            實驗徹底失敗，深淵力量使卡特的身體組織迅速崩解，變成失去人形的異常存在。他仍偶爾能發出聲音，身體被切下的部分也會再生。雷內不斷嘗試逆轉結果，卻無法讓卡特恢復；這件事使阿蘭與雷內決裂，也成為雷內放棄直接以深淵改造人類的重要原因。

            卡特是阿蘭的助手與好友，也是雷內、雅各布、瑪麗安共同珍惜的人。雅各布後來利用卡特殘留物與部分意識重塑雷內，之後又把剩餘部分放進丘丘人的身體，形成卡特皮拉。卡特皮拉承載卡特的部分意識，卻不是原本卡特完整人生的延續；這個差異也成為卡特皮拉追尋自我的難題。
            """
        ),
        .init(
            id: "emmanuel", name: "艾瑪紐埃爾・吉約丹", role: "主影獵人／阿蘭與瑪麗安的養父", era: "前代四人組",
            imageName: nil,
            introduction: """
            艾瑪紐埃爾出身水仙十字院，成年後成為主影獵人，並參與白松之圍。當時他奉命帶隊鎮壓白松鎮，雷內與雅各布的父親都在事件中遇害。這場行動在他心中留下難以抹去的傷痕；他退出主影獵人工作後長年借酒消愁，無法真正忘記白松鎮的火光與傷亡。

            深淵災厄發生後，艾瑪紐埃爾重新投入守護楓丹的工作。水仙十字院即將遣散孩子時，副院長貝瑟拜託他收養阿蘭與瑪麗安。他成為兩人的養父後，重新找到生活目標，希望替孩子們建立安穩的未來。阿蘭與瑪麗安進入自然哲學學院生活，艾瑪紐埃爾則在背後照顧他們。

            德懷特後來委託艾瑪紐埃爾調查水仙十字結社。他循著線索找到結社基地，卻被結社成員制伏，最後遭雷內吞噬。雷內從他的記憶中看見阿蘭與瑪麗安初到家中的情景。艾瑪紐埃爾是阿蘭、瑪麗安的養父，也是雷內、雅各布父親之死的參與者；他身上同時有責任、悔恨與保護孩子的心願，讓白松之圍的傷痕延續到下一代。
            """
        ),
        .init(
            id: "karl", name: "卡爾・英戈德", role: "冒險家／雷內與雅各布的養父", era: "前代四人組",
            imageName: nil,
            introduction: """
            卡爾原本是記者，白松之圍前後曾往返白松鎮與楓丹庭，替雙方傳遞訴求。他相信灰河與楓丹庭的衝突仍有協商餘地，並替白松鎮居民拍下一張合照。照片中的愛德華多、雷諾、帕西法爾與孩子們仍望向鏡頭，盼望事情能走向更好的結果。

            白松之圍後，卡爾在帕西法爾協助下倖存。他放棄記者工作，轉而成為冒險家。深淵災厄與水仙十字院遣散孩子時，貝瑟請他收養雷內和雅各布。卡爾帶兩人前往須彌考察坎瑞亞遺跡，也成為他們在童年創傷後的重要照顧者。

            雷內想用深淵力量救治病重的雅各布時，卡爾強烈反對。他親身經歷白松之圍，也看過深淵災厄帶來的傷害，因此不願讓孩子冒險。雷內最終瞞著他完成實驗，雅各布雖然活下來，卻也走上不同於常人的道路。卡爾是雷內與雅各布的養父，也是貝瑟、艾瑪紐埃爾、德懷特的舊友；他用記者的相機留下白松鎮最後的希望，後來又以冒險家的身分陪伴兩個孩子。提供的故事沒有交代他的晚年與最終去向。
            """
        ),
        .init(
            id: "dwight", name: "德懷特・拉斯克", role: "自然哲學學院院長", era: "前代四人組",
            imageName: nil,
            introduction: """
            德懷特與貝瑟、卡爾、艾瑪紐埃爾同樣出身水仙十字院，是前代四人組的一員。成年後他成為自然哲學學院院長，管理楓丹重要的研究機構。雷內、雅各布與阿蘭進入學院時，他負責學院制度與研究資源，也見證這群年輕天才逐漸走向不同道路。

            德懷特的生活不像其他舊友那樣直接捲入戰場，但學院長的職責使他必須留意研究風險。他察覺學院中出現水仙十字結社活動，起初沒有立刻採取強硬手段，後來感到情勢不對，便委託艾瑪紐埃爾調查。這項決定使艾瑪紐埃爾找到結社基地，也讓楓丹官方與雷內的計畫正面衝突。

            德懷特與卡爾、貝瑟、艾瑪紐埃爾是多年舊友；阿蘭、雷內、雅各布則是他管理下的研究者。他在水仙十字院兩代人的故事中像一條連結線，從童年的孤兒院延伸到自然哲學學院。關於他在結社事件之後的生活，故事沒有進一步交代。
            """
        )
    ]

    static let chapters: [StoryChapter] = [
        .init(id: 1, title: "灰河、白松鎮與白松之圍", subtitle: "一場人與人之間的衝突，改變兩代人的命運",
              backgroundName: "StoryBG_01",
              body: """
              灰河是楓丹城下水道中的聚落。楓丹推動城市優化，把貧民逐出地面城區，卻沒有妥善處理他們的生活。灰河因此形成自己的秩序：愛德華多·貝克以一根廢棄銅管擊退威脅居民的鱷魚，後來保護商販、調解衝突，逐漸成為灰河領袖。城市整肅再次擴大時，愛德華多等人反抗並被捕；同伴救出他們後，一行人暫居白松鎮，試圖以執律庭人質與楓丹庭談判。

              記者卡爾·英戈德在白松鎮與楓丹庭之間往返，傳遞雙方訴求。他替居民拍下合照：灰河領袖愛德華多與兒子雅各布、白松鎮鎮長雷諾與兒子雷內、帕西法爾，以及其他居民都在照片裡。卡爾相信衝突仍可化解，照片也留下了白松鎮尚未被火光吞沒前的希望。

              楓丹庭最後派主影獵人夜襲白松鎮。這次行動造成大量死傷，雷內與雅各布失去父親；卡爾在帕西法爾協助下倖存。白松之圍也深深影響了參與行動的艾瑪紐埃爾·吉約丹，使他多年無法面對自己的過去。事件讓楓丹官方與灰河居民的裂痕延續下去，也解釋了雷內為何不信任楓丹庭。

              雷內與雅各布被送入水仙十字院，與阿蘭、瑪麗安相識。四個孩子玩勇者鬥惡龍，阿蘭是勇者、雷內是惡龍、雅各布是巫師、瑪麗安是公主。阿蘭送給雷內一枚懷錶，卡爾留下的合照則被放在錶中。這些童年遊戲與物件後來成為他們記憶、選擇與命運的象徵。
              """),
        .init(id: 2, title: "水仙十字院與深淵災厄", subtitle: "院長、貝瑟與四個孩子被迫分離",
              backgroundName: "StoryBG_02",
              body: """
              水仙十字院是收容孤兒與罪犯子女的機構，院長莉莉絲是純水精靈，副院長貝瑟曾是楓丹海軍司令。莉莉絲不擅長理解複雜的事，卻總能平等地關心每個孩子；貝瑟則從嚴厲的軍人逐漸學會做點心，讓孩子們在下午茶時間共享難得的安穩。兩人共同照顧孩子，也把孤兒院變成不同世代水仙十字成員的家。

              深淵災厄爆發，厄里納斯等深淵魔獸威脅楓丹，災厄又造成海水上漲，水仙十字院逐漸被淹。莉莉絲與貝瑟必須離開孤兒院投入防衛，孩子們也不能再留在原處。貝瑟聯絡自己的舊友卡爾、艾瑪紐埃爾與德懷特，安排孩子們的去處：卡爾收養雷內與雅各布，艾瑪紐埃爾收養阿蘭與瑪麗安。

              臨行前，貝瑟把帽上的羽毛交給雅各布保管，並約定戰後回來取回。她也答應艾瑪紐埃爾，等自己回來要親自下廚，讓大家嚐嚐她進步的手藝。貝瑟率領斯彭西安號等艦船追擊厄里納斯，最後下令衝向海獸，以犧牲自己與船艦掩護其他船隻撤離。她再也沒有回來。

              莉莉絲則在災厄後回到被淹沒的孤兒院。因楓丹水域受厄里納斯影響，其他純水精靈大多離開，莉莉絲仍留在舊址等待孩子們。她不明白孩子們為何離去，卻一直相信他們會回來。多年後雷內與雅各布確實回到孤兒院，莉莉絲的等待也讓她重新進入雷內的計畫與後來的故事。
              """),
        .init(id: 3, title: "世界式與雅各布的變化", subtitle: "雷內開始尋找改變末日的方法",
              backgroundName: "StoryBG_03",
              body: """
              卡爾收養雷內與雅各布後，帶他們前往須彌考察坎瑞亞遺跡。雷內展現出極高的觀察與計算能力，分析甘露花海的聖蓮時，發現聖蓮與自己、雅各布的身體組分有相似之處；他也研究靈光、深淵與提瓦特運行規則。雅各布病重時，雷內認為深淵力量或許能改變生命，於是瞞著卡爾進行實驗。雅各布因此活下來，並獲得承受深淵力量的特殊體質。

              雷內依據坎瑞亞知識推導出「世界式」，這套計算可以預測提瓦特未來。他反覆計算後得出楓丹會迎來第二次漲水危機、提瓦特也可能走向毀滅的結果；與過去文明毀滅後仍有新文明誕生的循環不同，這次可能不再有新文明接續。雷內認為必須引入世界之外的力量作為變量，否則無論重算幾次，結果都不會改變。

              雷內回到楓丹後，與雅各布重逢阿蘭與瑪麗安。四人仍像童年一樣親近，但各自已有新的生活：阿蘭進入自然哲學學院研究機械與能源，瑪麗安陪伴哥哥，雷內與雅各布則想找到更多研究資源。阿蘭希望親自驗算世界式，雷內認為時間緊迫；兩人對末日的判斷與如何拯救世界，從此埋下分歧。

              雷內也前往厄里納斯體內研究深淵。雅各布認為時間不等人，曾自行吸收厄里納斯的血肉，力量增強後能短暫打開深淵通道，召出流血狗。雅各布被這些生物嚇得哭泣，仍成功將牠們擊退。這使雷內更相信深淵能成為世界式中的變量，也讓他開始尋找把力量轉化為可用方法的途徑。
              """),
        .init(id: 4, title: "自然哲學學院與卡特的實驗", subtitle: "朋友、研究與無法挽回的失敗",
              backgroundName: "StoryBG_04",
              body: """
              雷內與雅各布進入自然哲學學院後，被分配到阿蘭的研究室。阿蘭研究可控的荒芒湮滅與能源轉換，雷內則協助研究，並觀察學院裡是否有能理解世界式的同伴。卡特是阿蘭的助手，也是水仙十字院出身的朋友。他為了讓眾人離開研究室喘口氣，以田野調查為名帶大家到佩特利克鎮，並借留影機替瑪麗安拍照，希望阿蘭能珍惜與妹妹相處的時間。西摩爾後來的構想，也與卡特這番提醒有關。

              卡特患上難以治癒的重病，雷內將他的血液和皮膚樣本送去須彌求醫，但傳統醫療沒有辦法。雅各布提出，卡特或許能像自己一樣吸收深淵力量而存活。雷內沒有隱瞞風險，也坦白自己需要新樣本驗證研究；卡特仍決定接受，因為他不願只是等待死亡。

              實驗失敗得非常徹底。深淵力量使卡特的組織崩解，成為失去人形的異常存在，卻還能發出卡特的聲音，受損部分也會再生。雷內嘗試各種方法，包括尋找不同材料逆轉變化，仍無法讓他恢復。雅各布與雷內都想救卡特，阿蘭卻無法接受以朋友的身體繼續實驗，於是與雷內決裂。

              這次事件改變了雷內的研究方向。他不再相信直接把深淵力量注入人類就能普遍救人，轉而回到佩特利克遺跡，研究古代文明如何處理生命、靈魂與意志。卡特的遭遇也成為雷內與雅各布多年未能放下的心結，最後與卡特皮拉的誕生相連。
              """),
        .init(id: 5, title: "古代儀式：密合之約印與聖劍", subtitle: "從改造肉體轉向統合意志",
              backgroundName: "StoryBG_05",
              body: """
              卡特實驗失敗後，雷內與雅各布重新調查佩特利克一帶的古代遺跡，並在雷穆利亞相關遺物中找到「密合之約印」。雷內推測，古人曾研究如何把生命的靈性或意志從原本形體中提取，再放入另一個容器。水仙十字院本身也可能建在更古老的研究場所上，院內故事與孩子們玩過的勇者鬥惡龍，藏有古代資料的隱喻。

              雷內的古代儀式有幾個彼此配合的部分。第一，密合之約印提供法陣與能量流向的結構，結社後來又根據楓丹原始胎海的分布改造、逆轉它。第二，原始胎海之水是讓形體溶解、重構與意識流動的媒介。第三，純水精靈莉莉絲能參與儀式，協助分離或承接意識。第四，水仙十字聖劍並非只有武器用途，更像一把能汲取、統合意志的鑰匙。雷內希望把自己變成承載者，讓被溶解的眾人意識匯集到自己身上。

              這項儀式並非單純「跳進水裡就成神」。雷內需要先定位原始胎海的決口與匯流位置，改造法陣，建立格式塔高塔，取得聖劍，並準備能協助儀式的莉莉絲。結社成員負責尋找封印與水道、提供資源並建造格式塔；雅各布協助研究、維持組織；阿蘭與楓丹方面則成為反對者。雷內相信只要在末日之前完成這些步驟，就能保存眾人意識，讓生命不因肉體溶解而真正消失。

              雷內先以自己為實驗對象。他在莉莉絲協助下進行自我割捨，試圖割離可能受提瓦特命運影響的部分，再藉原始胎海之水重構自身。結果第一次實驗失敗，雷內失去原有形體與部分自我。雅各布沒有放棄，開始研究如何重塑他。雷內的失敗經驗後來被刻意移除，成為新生納齊森·科魯茲記憶中的空白。
              """),
        .init(id: 6, title: "納齊森·科魯茲與水仙十字結社", subtitle: "雅各布如何重塑雷內",
              backgroundName: "StoryBG_06",
              body: """
              雷內第一次自我重構失敗後，雅各布獨自接手水仙十字結社。他要維持組織、繼續推進格式塔計畫，同時尋找讓雷內恢復的方法。雅各布以阿蘭送給雷內的懷錶作為重要材料，利用懷錶中留下的情感與雷內記憶，再加上卡特殘存的意識與研究成果，重新塑造出雷內的形體與人格，並把他命名為納齊森·科魯茲。

              雅各布刻意拿掉雷內兩次失敗的記憶：一次是以深淵力量改造卡特造成災難，另一次是雷內自己在原始胎海儀式中失敗。雅各布相信這些記憶會阻礙雷內完成救世理想，因此希望新生的雷內能恢復信念。這項選擇讓納齊森·科魯茲保有雷內的理想與情感，卻不完全知道自己曾經歷過的失敗。

              雷內復甦後成為結社的大師，透過「自我割捨」儀式擴大力量。參與者在莉莉絲協助下分離部分自我意志，再由雷內統合；這不一定立刻使肉體死亡，卻會讓個人失去部分自主性。結社透過《揭示之書》讓接觸者看見自己心中最接近末日的景象，藉此招募成員，並逐步建立能動員人力、財力與研究資源的組織。

              雅各布也利用卡特剩餘的部分意識與丘丘人的身體，塑造出卡特皮拉。卡特皮拉被送往梅洛彼得堡生活，後來努力理解自己與卡特的關係。雷內、雅各布都想保存卡特，但他們創造出的卡特皮拉並不是卡特完整人生的復活，而是帶著部分意識、由新經歷逐步形成的另一個存在。
              """),
        .init(id: 7, title: "格式塔、楓丹清算與厄里納斯之戰", subtitle: "救世計畫與阻止計畫的人們",
              backgroundName: "StoryBG_07",
              body: """
              雷內的計畫逐漸擴大，水仙十字結社尋找原始胎海的封印與水道，並在決口附近建造格式塔高塔。格式塔是雷內預定接收、統合眾人意識的核心場所；密合之約印負責導引力量與意識，聖劍則是統御意志的重要媒介。雷內打算讓原始胎海水淹沒楓丹，使楓丹人溶解後的意識匯流到指定位置，再由經過儀式改造的自己承接。

              雷內相信這不是為了支配他人，而是要讓眾人在末日中以意識形式延續。他的計畫仍需要大量準備，也會奪走個體原有形體與部分自主性。雅各布負責維持結社、安排人手並暗中完成法陣；莉莉絲協助儀式；結社成員提供資源。艾瑪紐埃爾受德懷特委託調查結社，最後被雷內吞噬。阿蘭則以研究者與楓丹一方的立場勸雷內停止，兩人再度見面時沒有激烈爭吵，但阿蘭的勸告沒有改變雷內的決定。

              結社被楓丹官方認定為非法激進組織後，雷內安排成員、雅各布與莉莉絲前往厄里納斯一帶迎戰阿蘭一方，藉此爭取格式塔完成計畫的時間。戰鬥造成重大傷亡，西摩爾受損，瑪麗安瀕臨死亡。莉莉絲出於保護孩子的本能抱住瑪麗安，兩人的意識與記憶融合。戰鬥的碎片也刺入厄里納斯體內，與後來美露莘的故事相連。

              雷內則留在格式塔，最後進入原始胎海等待計畫完成的時機。結社遭到清算，格式塔被封閉，雅各布倖存並繼續暗中逆轉密合之約印。阿蘭在衝突後更加沉默，投入機械研究並創立楓丹科學院。貝瑟早已在對抗厄里納斯的海戰中犧牲；艾瑪紐埃爾也死於調查結社的行動。兩代人的關係在這場衝突中走向不同結局。
              """),
        .init(id: 8, title: "旅行者、安與水仙十字的後日談", subtitle: "計畫失敗之後，眾人各自走向新的旅程",
              backgroundName: "StoryBG_08",
              body: """
              幾百年後，旅行者來到楓丹，重新走進水仙十字院、厄里納斯與格式塔相關的故事。安生活在童話般的冒險裡，西摩爾尋找瑪麗安，卡特皮拉則在梅洛彼得堡追問自己的身世。雅各布仍想讓雷內的計畫完成，並以聖劍與逆轉後的密合之約印迎接最後時刻。

              旅行者成為世界式沒有預先納入的變數；同時，芙卡洛斯改變楓丹命運的安排已經完成。雷內醒來後看見世界不再需要他以原計畫拯救。他沒有否認自己曾經的努力，而是接受計畫已失去必要性，與旅行者一同回望昔日同伴，並在瑪麗安的夢境中告別。雅各布完成自己能做的事後，在末日時鐘前倒下。

              瑪麗安與莉莉絲的記憶在夢境中孕育出純水精靈安。旅行者陪安走出故事後，安與西摩爾、瑪梅赫踏上旅程；西摩爾仍尋找瑪麗安的下落，也延續阿蘭製作它時的情感。卡特皮拉則試著建立屬於自己的身分。他承載卡特的部分意識，卻沒有卡特完整的人生記憶，因此無法只靠別人的回憶找到答案，身體與自我也仍不穩定。

              阿蘭的晚年與最終去向沒有完整交代。卡爾的後續也未明確說明。貝瑟、艾瑪紐埃爾、雅各布等人的選擇則留在楓丹歷史與其他人的記憶裡。從孤兒院的童年遊戲到格式塔的最後計畫，水仙十字的故事最後沒有停在救世或失敗，而是讓安、西摩爾、瑪梅赫與卡特皮拉各自帶著過去，走向尚未寫完的未來。
              """)
    ]

    static let gallery: [GalleryItem] = [
        .init(id: 1, title: "水仙十字院", caption: "兩代人的故事起點", imageName: "Gallery_Orphanage"),
        .init(id: 2, title: "水仙十字結社", caption: "雷內建立的組織", imageName: "Gallery_Order"),
        .init(id: 3, title: "原始胎海之水", caption: "雷內儀式與楓丹命運的關鍵", imageName: "Gallery_PrimordialSea"),
        .init(id: 4, title: "白松鎮", caption: "改變多名角色命運的事件", imageName: "Gallery_PineTown"),
        .init(id: 5, title: "懷錶", caption: "雷內記憶與情感的寄託", imageName: "Gallery_PocketWatch"),
        .init(id: 6, title: "水仙十字聖劍", caption: "統合意志的重要媒介", imageName: "Gallery_SacredSword"),
        .init(id: 7, title: "格式塔", caption: "結社計畫的核心場所", imageName: "Gallery_Gestalt"),
        .init(id: 8, title: "勇者鬥惡龍", caption: "孩子們的童年遊戲", imageName: "Gallery_HeroDragon")
    ]
}

// MARK: - Shared visual components
struct BlurredImageBackground: View {
    var imageName: String = "Background_Main"
    var blurRadius: CGFloat = 2
    var grayOverlay: Double = 0.35
    var imageOpacity: Double = 1.0
    var lightWash: Double = 0.0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color(.systemGroupedBackground)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .blur(radius: blurRadius)
                    .scaleEffect(1.08)
                    .clipped()
                    .opacity(imageOpacity)
                    .overlay(Color.gray.opacity(grayOverlay))
                    .overlay(Color(.systemBackground).opacity(lightWash))
            }
        }
        .ignoresSafeArea()
    }
}

struct SharedAppBackground: View {
    var body: some View {
        BlurredImageBackground(
            imageName: "Home_Background",
            blurRadius: 4,
            grayOverlay: 0.0,
            imageOpacity: 0.45,
            lightWash: 0.25
        )
    }
}

struct SystemPageBackground: View {
    var body: some View {
        SharedAppBackground()
    }
}

struct ImagePortrait: View {
    let imageName: String
    var size: CGFloat = 54

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .background(Color.gray.opacity(0.22))
            .clipShape(Circle())
            .overlay(Circle().stroke(.white.opacity(0.55), lineWidth: 1))
            .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
            .accessibilityLabel("人物圖片")
    }
}

struct SoftCardModifier: ViewModifier {
    var tint: Color = .blue

    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(tint.opacity(0.18), lineWidth: 1)
            )
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
}

#if canImport(UIKit)
import UIKit

enum OrientationManager {
    static func lockLandscape() {
        AppDelegate.orientationLock = .landscape
        updateOrientation(to: .landscape)
    }

    static func unlockOrientation() {
        AppDelegate.orientationLock = .allButUpsideDown
        updateOrientation(to: .portrait)
    }

    private static func updateOrientation(to orientation: UIInterfaceOrientationMask) {
        let activeScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        guard let windowScene = activeScenes.first(where: { $0.activationState == .foregroundActive }) ?? activeScenes.first else {
            return
        }

        let preferences: UIWindowScene.GeometryPreferences.iOS
        if orientation == .landscape {
            preferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: .landscape)
        } else {
            preferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: .portrait)
        }

        windowScene.requestGeometryUpdate(preferences) { _ in }
        windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
    }
}
#endif

enum AppTab: Hashable {
    case home, characters, story, video, gallery
}

// MARK: - Root tabs
struct WaterCrossRootView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("首頁", systemImage: "house.fill", value: .home) {
                NavigationStack { HomeView() }
            }
            Tab("角色", systemImage: "person.3.fill", value: .characters) {
                NavigationStack { CharacterListView() }
            }
            Tab("劇情", systemImage: "book.closed.fill", value: .story) {
                NavigationStack { StoryView() }
            }
            Tab("手書", systemImage: "play.rectangle.fill", value: .video) {
                NavigationStack { VideoHubView(isActive: selectedTab == .video) }
            }
            Tab("圖鑑", systemImage: "square.grid.2x2.fill", value: .gallery) {
                NavigationStack { GalleryView() }
            }
        }
        .onChange(of: selectedTab) { oldTab, newTab in
            #if canImport(UIKit)
            if newTab == .video {
                OrientationManager.lockLandscape()
            } else if oldTab == .video {
                OrientationManager.unlockOrientation()
            }
            #endif
        }
        .tabViewStyle(.sidebarAdaptable)
        .tint(.cyan)
    }
}

// MARK: - Landing page
struct HomeView: View {
    @State private var didAppear = false

    var body: some View {
        ZStack {
            SharedAppBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("FONTAINE · STORY GUIDE", systemImage: "drop.fill")
                            .font(.caption.weight(.bold))
                            .tracking(1.4)
                            .foregroundStyle(.secondary)
                            .symbolEffect(.pulse, options: .repeating)

                        Text("水仙十字")
                            .font(.system(size: 38, weight: .black, design: .rounded))

                        Text("以救世之名，追尋被遺忘的故事")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("何物徒留名字？何物遍開幽谷？何物映自身於鏡水？何物象徵拯救世界的孤獨犧牲？")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 220, alignment: .bottomLeading)
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(.regularMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 14, y: 8)

                    if didAppear {
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeading(title: "故事速覽", subtitle: "左右滑動瀏覽劇情章節")
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
                            .frame(height: 205)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))

                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeading(title: "認識關鍵角色", subtitle: "點選人物查看完整介紹")
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 12) {
                                    ForEach(WaterCrossData.characters) { character in
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
                        .transition(.opacity)
                    }

                    Text("水仙十字")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 18)
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("水仙十字題解")
        .inlineNavigationBarTitle()
        .onAppear {
            withAnimation(.easeOut(duration: 0.55)) {
                didAppear = true
            }
        }
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
        .padding(.horizontal, 2)
    }
}

struct ChapterCard: View {
    let chapter: StoryChapter

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("第 \(chapter.id) 章")
                .font(.caption.bold())
                .foregroundStyle(.cyan)
            Text(chapter.title).font(.title2.bold())
            Text(chapter.subtitle)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
            Text(chapter.body)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(3)
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
            if let imageName = character.imageName {
                ImagePortrait(imageName: imageName, size: 54)
            }
            Text(character.name).font(.headline)
            Text(character.role)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Spacer(minLength: 0)
        }
        .frame(width: 150, height: 145, alignment: .leading)
        .softCard(tint: .cyan)
    }
}

// MARK: - Characters
struct CharacterListView: View {
    var body: some View {
        ZStack {
            SystemPageBackground()
            List(WaterCrossData.characters) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
                } label: {
                    HStack(spacing: 14) {
                        if let imageName = character.imageName {
                            ImagePortrait(imageName: imageName, size: 56)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(character.name).font(.headline)
                            Text(character.role).font(.subheadline).foregroundStyle(.secondary)
                            Text(character.era).font(.caption).foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listRowBackground(Color(.secondarySystemGroupedBackground).opacity(0.82))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("角色介紹")
    }
}

struct CharacterDetailView: View {
    let character: CharacterProfile

    var body: some View {
        ZStack {
            // 所有角色詳情共用同一張模糊背景圖
            BlurredImageBackground(imageName: "CharacterBG_Common", blurRadius: 3, grayOverlay: 0.50)

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    if let imageName = character.imageName {
                        ImagePortrait(imageName: imageName, size: 126)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }

                    Text(character.name)
                        .font(.largeTitle.bold())

                    Text(character.role)
                        .font(.headline)
                        .foregroundStyle(.cyan)

                    Text(character.introduction)
                        .font(.body)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .softCard(tint: .cyan)
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(character.name)
        .inlineNavigationBarTitle()
    }
}

// MARK: - Story
struct StoryView: View {
    var body: some View {
        ZStack {
            SystemPageBackground()
            List(WaterCrossData.chapters) { chapter in
                NavigationLink {
                    ChapterDetailView(chapter: chapter)
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(chapter.title).font(.headline)
                        Text(chapter.subtitle).font(.caption).foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 7)
                }
                .listRowBackground(Color(.secondarySystemGroupedBackground).opacity(0.82))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("劇情介紹")
    }
}

struct ChapterDetailView: View {
    let chapter: StoryChapter

    var body: some View {
        ZStack {
            BlurredImageBackground(imageName: chapter.backgroundName, blurRadius: 2, grayOverlay: 0.35)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("第 \(chapter.id) 章")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.cyan)
                    Text(chapter.title).font(.largeTitle.bold())
                    Text(chapter.subtitle)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text(chapter.body)
                        .font(.body)
                        .lineSpacing(7)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                }
                .padding()
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(chapter.title)
        .inlineNavigationBarTitle()
    }
}

// MARK: - Gallery
struct GalleryView: View {
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            SystemPageBackground()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(WaterCrossData.gallery) { item in
                        GalleryTile(item: item)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("意象圖鑑")
    }
}

struct GalleryTile: View {
    let item: GalleryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { proxy in
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
            }
            .frame(height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(item.title).font(.headline)
            Text(item.caption)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.28), lineWidth: 1))
    }
}

// MARK: - Local hand-drawn video
struct VideoHubView: View {
    var isActive: Bool = true
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            SystemPageBackground()
            VStack {
                if let player {
                    VideoPlayer(player: player)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
                Spacer(minLength: 0)
            }
        }
        .navigationTitle("「终焉」X「End of All」")
        .inlineNavigationBarTitle()
        .onAppear {
            loadAndPlayLocalVideo()
            #if canImport(UIKit)
            OrientationManager.lockLandscape()
            #endif
        }
        .onDisappear {
            player?.pause()
            #if canImport(UIKit)
            OrientationManager.unlockOrientation()
            #endif
        }
        .onChange(of: isActive) { _, active in
            if active {
                loadAndPlayLocalVideo()
            } else {
                player?.pause()
            }
        }
    }

    private func loadAndPlayLocalVideo() {
        if player == nil {
            guard let url = Bundle.main.url(forResource: "ShuiXianVideo", withExtension: "mp4") else { return }
            let newPlayer = AVPlayer(url: url)
            player = newPlayer
            newPlayer.play()
        } else if let player {
            if let currentItem = player.currentItem, currentItem.duration.isValid, currentItem.currentTime() >= currentItem.duration {
                player.seek(to: .zero)
            }
            player.play()
        }
    }
}

// MARK: - WebView component retained for project requirements
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
