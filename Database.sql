USE [master]
GO
/****** Object:  Database [FortanFoniBlog]    Script Date: 17.08.2018 18:45:37 ******/
CREATE DATABASE [FortanFoniBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FortanFoniBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\FortanFoniBlog.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FortanFoniBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\FortanFoniBlog_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FortanFoniBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FortanFoniBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FortanFoniBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FortanFoniBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FortanFoniBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FortanFoniBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FortanFoniBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FortanFoniBlog] SET  MULTI_USER 
GO
ALTER DATABASE [FortanFoniBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FortanFoniBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FortanFoniBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FortanFoniBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FortanFoniBlog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [FortanFoniBlog]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 17.08.2018 18:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[ArticleId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Text] [nvarchar](max) NULL,
	[ArticlePhoto] [nvarchar](500) NULL,
	[Time] [nchar](10) NULL CONSTRAINT [DF_Article_ArticleTime]  DEFAULT (getdate()),
	[CategoryId] [int] NULL,
	[UserId] [int] NULL,
	[Displayed] [int] NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 17.08.2018 18:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
	[ParentId] [int] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 17.08.2018 18:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[CommentText] [nvarchar](400) NULL,
	[UserId] [int] NULL,
	[ArticleId] [int] NULL,
	[CommentTime] [datetime] NULL CONSTRAINT [DF_Comment_CommentTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 17.08.2018 18:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](25) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 17.08.2018 18:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](40) NULL,
	[Mail] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[UserPhoto] [nvarchar](500) NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (17, N'Sağlık Saçlar', N'<div class="newArticle mn-container group" id="news_1032100" data-id="1032100" data-title="Doğal sa&ccedil; bakımı nasıl yapılır?" data-url="/guzellik/sac/haber/1032100-dogal-sac-bakimi-nasil-yapilir">
<div class="group news-dt news-dt-margin-bottom">
<p>Doğal sa&ccedil; bakımının ilk şartı, sa&ccedil;a s&uuml;r&uuml;len doğal malzemeleri kimyevi yollarla &ccedil;ıkarmaya &ccedil;alışmamaktır! &Ccedil;&uuml;nk&uuml; bu sa&ccedil;ınızı daha fazla yıpratmaktan başka bir işe yaramaz. Verdiğimiz p&uuml;f noktalarını uygularsanız sağlıklı sa&ccedil;lara sahip olabilirsiniz.&nbsp;</p>
<h3><br /><span>Tembel işi yumurtalı sa&ccedil; bakımı&nbsp;</span></h3>
<p>Vaktiniz yoksa ya da &ouml;n hazırlık yapmaya &uuml;şeniyorsanız sadece yumurta kullanın. Peşin uyarı: Sa&ccedil;ınız ıslak olmalı. Sa&ccedil;ınız kısaysa 1, orta boyda ise 2, &ccedil;ok uzunsa 3 yumurtayı kırıp &ccedil;ırpın. &Ouml;nce sa&ccedil; derinize masaj yaparak yedirin. Sonra dipten u&ccedil;lara doğru hafif hafif yedirin. Yarım saat bekleyin. Bu esnada bir bardak ısırgan &ccedil;ayı demleyin. P&uuml;f noktası: &Ouml;nce sa&ccedil;ınızı iyice durulayın, sonra hafif şampuanla yıkayın. Ilık bir kabın i&ccedil;ine demlenmiş ısırganı katın ve sa&ccedil;ınızı son olarak bu suyla durulayın. &nbsp;Dikkat: Sıcak su kullanmayın, başınızdaki yumurtayı pişirir!</p>
<h3><br /><span>Doğal yağ karışımı ile sa&ccedil; bakımı&nbsp;</span></h3>
<p>Kısa sa&ccedil;lılar &ouml;l&ccedil;&uuml; olarak tatlı kaşığı, &ccedil;ok uzun ve g&uuml;r sa&ccedil;lılar yemek kaşığı kullanmalı. &nbsp;1&rsquo;er &ouml;l&ccedil;&uuml; hindistan cevizi yağı, badem yağı ve zeytinyağını karıştırın. Sa&ccedil; diplerinizden başlayın, u&ccedil;lara kadar yağ karışımını masaj yaparak yedirin. Yarım saat bekledikten sonra şampuanla yıkayın. P&uuml;f noktası: Banyoya girerken ılık bir kap suyun i&ccedil;ine 1 yemek kaşığı elma sirkesi karıştırın. &Ccedil;ıkmadan &ouml;nce sa&ccedil;larınızı bu suyla durulayın. Sirkenin yağları &ccedil;&ouml;zme &ouml;zelliği vardır. B&ouml;ylece sa&ccedil;larınızda yağ artığı kalmaz ve huzursuz olmazsınız.&nbsp;</p>
<h3><br /><span>Soğan, sarımsak ve zeytinyağı maskesi ile sa&ccedil; bakımı</span></h3>
<p>1 soğan ile 1 diş sarımsağı blendırdan ge&ccedil;irip i&ccedil;ine 2 yemek kaşığı saf zeytinyağı katın. Karışımı bir g&uuml;n beklettikten sonra un eleğinden veya t&uuml;lbent gibi temiz bir bezden ge&ccedil;irerek s&uuml;z&uuml;n. S&uuml;zd&uuml;ğ&uuml;n&uuml;z yağ ile sa&ccedil; diplerinize masaj yapın. Yarım saat bekledikten sonra yıkayın. 1 yemek kaşığı elma sirkesi ve 1 su bardağ taze demlenmiş ısırganotunu bir kap ılık suya katın. Sa&ccedil;larınızı bu suyla durulayın. &nbsp;P&uuml;f noktası: Sa&ccedil;larınızı kuruttukten sonra bir yemek kaşığını sa&ccedil; diplerinize s&uuml;r&uuml;n. &Ccedil;eliğin sarımsak kokusunu yok etme &ouml;zelliği vardır. G&uuml;n&uuml;n farklı zaman dilimlerinde &uuml;&ccedil;-d&ouml;rt kez tekrarlarsanız koku kalmayacaktır.&nbsp;<br /><br /></p>
</div>
</div>
<div id="zone_1902" zone-id="1902" class="ads-zone" zone-viewtype="banner"></div>
<div class="group mt20">
<div class="group mb10 facebookCommentTitle">
<div class="group tt-linkes"><span class="ft18"><span class="facebookIcon"><span class="fa fa-facebook"></span></span></span></div>
</div>
</div>', N'/UpLoads/ArticlePhoto/802ee0e7-a895-4d2c-ae2b-4a2bed24aa2d.jpg', N'2018-08-16', 5, 1, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (18, N'Eller ve Temizlik', N'<p><span>Ş&uuml;phesiz işlerimizi yaparken en &ccedil;ok kullandığımız ellerimiz bakıma ve ilgiye layık en &ouml;nemli organlarımızdan biri. İnsanlarla olan ilişkilerimizde &ouml;n planda olan ve dikkat &ccedil;eken ellerimiz bakımlı ve temiz olmalıdır. Bu nedenle bug&uuml;n sizlere kadınların g&uuml;zelliğinin ve zerafetinin g&ouml;stergesi olan ellerin bakımı hakkında kapsamlı bilgiler vereceğiz. El bakımı i&ccedil;in kullanabileceğiniz bir&ccedil;ok krem ve bakım &uuml;r&uuml;nleri bulunmaktadır. Biz makalemizde bunların yanında sizlere bazı bitkisel bakım k&uuml;rlerinden de bahsedeceğiz. El bakımı k&uuml;rleri &ouml;ncesinde sizlere g&uuml;nl&uuml;k olarak ellerinizde dikkat etmeniz gereken temizlikten bahsedeceğim. Mikroplarla, dış d&uuml;nyayla haşır neşir olan ellerimiz i&ccedil;in temizlik olduk&ccedil;a &ouml;nemlidir.</span></p>
<p><span>G&uuml;n i&ccedil;erisinde sık sık ellerinizi yıkamalı ve kullandığınız temizlik &uuml;r&uuml;nlerinin kimyasal i&ccedil;erikli olmamasına dikkat etmelisiniz. Manik&uuml;r yapmaya dikkat etmeli ve eğer bir g&uuml;zellik merkezinde yaptırıyorsanız..<span id="more-216"></span>&nbsp;kullanılan malzemelerin steril olduğundan emin olmalısınız. Ellerinizin &ouml;zellikle kış g&uuml;nlerinde &ccedil;atlamaması i&ccedil;in eldiven ve bunun yanında nemlendirici &uuml;r&uuml;nler kullanmalısınız.&nbsp;<strong>El bakımı</strong>yanında tırnaklarınızın bakımı, kesim tarzı da olduk&ccedil;a &ouml;nemlidir. 3 adımda&nbsp;<a href="http://guzelliksirlarim.org/3-adimda-tirnak-bakimi-nasil-yapilir/">tırnak bakımı nasıl yapılır</a>konulu makalemizde bununla ilgili detaylı bilgiler paylaşmıştık.&nbsp;Yazımızın devamında el bakımının yanı sıra manik&uuml;r hakkında da bilgiler bulacaksınız ama &ouml;nce isterseniz el bakımına ge&ccedil;meden &ouml;nce manik&uuml;r uygulaması nasıl yapılır onu anlatalım.</span></p>', N'/UpLoads/ArticlePhoto/376c85b9-e2d5-4898-a8f0-1f3f9683380f.jpg', N'2018-08-16', 4, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (19, N'İnsan Pislolojisi', N'<div>&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_7838.htm"><b>G&ouml;&ccedil; ve G&ouml;&ccedil; Psikolojisi</b></a>&nbsp;<span>Psk.Bur&ccedil;ak DEMİRKAN</span></div>
<div>G&Ouml;&Ccedil; NEDİR? G&ouml;&ccedil;, dini, iktisadi, siyasi, sosyal ve diğer sebeplerle insan topluluklarının bir yerden bir başka yere gitmesi. Ferdi sebep ve maksatlarla yer değiştirmeye ve bu esnada nakledilen eşyaların hepsine de g&ouml;&ccedil; denmektedir. Ayrıca kuşların, balıkların ve bazı hayvan t&uuml;rlerinin, belli mevsimlerde d&uuml;nyanın &ccedil;eşitli yerlerine gitmeleri de g&ouml;&ccedil; adıyla anılır. Bir başka tanıma g&ouml;re ise, insanların, doğdukları yerden başka yerlere ge&ccedil;ici ya da s&uuml;rekli olmak &uuml;zere taşınmasına g&ouml;&ccedil; denir. G&ouml;&ccedil;ler ka&ccedil; sınıfta incelenebilir, g&ouml;&ccedil;&uuml;n nedenleri ve sonu&ccedil;ları nelerdir? Gidilen yere g&ouml;re g&ouml;&ccedil; &ccedil;eşitleri İ&ccedil; g&ouml;&ccedil;ler ve dış g&ouml;&ccedil;ler olarak 2&rsquo;ye ayrılır. A. İ&Ccedil; G&Ouml;&Ccedil;LER &Uuml;lke i&ccedil;erisi...&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_7838.htm">&raquo;&raquo;&raquo;</a></div>
<div>►&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_5475.htm"><b>Yalnızlık Psikolojisi</b></a>&nbsp;<span>Psk.Dnş.Halil İbrahim &Ccedil;ABUK</span></div>
<div>Her g&uuml;n onlarca hatta belkide y&uuml;zlerce insanla iletişim kurmamıza rağmen aslında kendimizi bazen yalnız mutsuz, anlaşılmamışlığın verdiği acı ile huzursuz etmekteyiz.Belki de sevdiğimizi sandığımız insanları sevmekten ziyade alışılagelmiş bir rutin olarak algılıyoruz fakat bu durumun farkında değiliz. Mutsuzluğumuzun sebebini kendimizde arıyor hatalı olduğumuz etiketini &ccedil;oğu zaman hi&ccedil; d&uuml;ş&uuml;nmeden kendimize yapıştırıyoruz. Eşimiz , &ccedil;ocuklarımız ailemizde kim varsa bazen sanki kendimize yabancı geliyor olabilir. Yukarıda tanımlamaya &ccedil;alıştığım duruma kendimizi o kadar inandırmış olmamız hasebiyle MUTLULUK HUZUR bizim i&ccedil;in ulaşılması imkansız bir hayal olma yolunda ilerliyor. Olumlu duygular...&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_5475.htm">&raquo;&raquo;&raquo;</a></div>
<div>►&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_4494.htm"><b>İnsan Psikolojisi Alanında Artan Suistimaller ve Arabadan Gelen Her Sesin Arıza Olarak Algılattırılması</b></a>&nbsp;<span>Psk.İzzet G&Uuml;LL&Uuml;</span></div>
<div>Yardım vaatlerinde s&uuml;rekli "zaman" ger&ccedil;eği ve "doğal &ccedil;&ouml;z&uuml;m" fakt&ouml;r&uuml; g&ouml;z ardı ediliyor. Son yıllarda, kendi sorunlarınız hakkında ya da &ccedil;ocuklarınızla ilgili olarak araştırma yaparken okuduğunuz mesleki metinlerde &ldquo;Şunları şunları deneyin, olmazsa bir uzmandan mutlaka yardım isteyin&rdquo; c&uuml;mlelerini &ccedil;ok sık olarak duyduğumuz hepimizin malumudur. Bura verilen gizli, ancak muhataplar i&ccedil;in anlamı son derece a&ccedil;ık olan mesaj şudur: Yaşadıklarınız &ouml;nemli bir sorundur, dolayısı ile mutlaka &ccedil;&ouml;z&uuml;lmesi gerekiyor. &Ccedil;&ouml;z&uuml;m demek yok etmek, derhal ortadan kaldırmak demektir. Bu ise ancak size vereceğimiz bazı bilgilerle, bu da olmazsa şayet bizden alacağınız sınırlı s&uuml;reli (sihirli) yardımla m&uuml;...&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_4494.htm">&raquo;&raquo;&raquo;</a></div>
<div>►&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_18906.htm"><b>21. Y&uuml;zyılda Teknolojinin İnsan Ruh Haline Etkisi</b></a>&nbsp;<span><a href="http://www.tavsiyeediyorum.com/psikolog_29129_mehmet_bakay.htm" class="siiryazara">Psk.Mehmet BAKAY</a></span></div>
<div>Teknolojinin &ouml;zellikle 21 . yy da kaydettiği ilerleme, yadsınamaz boyuttadır. Ş&ouml;yle ki; teknoloji artık hayatımızın her alanında mutfakta, salonumuzda,sokakta hayatımızın her alanında kendini g&ouml;stermektedir. Teknoloji sayesinde toplumsal bilincimiz de artmaktadır. İnsanlar &ccedil;evresinde olan olaylara karşı daha duyarlı hale gelmektedir. Teknolojinin olmadığı bir alan artık yok denecek kadar azdır. Fakat bu yazımda değineceğim konu teknolojinin hayatımız da ki kolaylıklarının dışında problem i&ccedil;eren nedenlerine değinmektir. Televizyon, film, video oyunları, radyo, bilgisayar ve internet gibi kitle iletişim ara&ccedil;larının ayrı kullanma &ccedil;ocuk ve ergenlerin beden ve ruh sağlığı i&ccedil;in ciddi bir tehli...&nbsp;<a href="http://www.tavsiyeediyorum.com/makale_18906.htm">&raquo;&raquo;&raquo;</a></div>', N'/UpLoads/ArticlePhoto/8b761c7d-ddb8-4256-bd87-e97d7b672434.jpeg', N'2018-08-17', 7, 13, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (23, N'Eğitim Nerede Başlar?', N'<p>Okul &ouml;ncesinde verilen anaokulu eğitiminde 3-5 yaş arasındaki &ccedil;ocuklar, ev ortamından &ccedil;ıkarak ebeveynleri dışındaki kişilerle de iletişim kurmaya başlar. Bu da g&uuml;nl&uuml;k yaşam becerilerini artırması i&ccedil;in ona fırsat yaratır.</p>
<p>Arkadaş ilişkileri &ouml;nem kazanır. Bir yandan oyuncaklarını ya da yiyeceğini paylaşmayı &ouml;ğrenirken diğer yandan karşılıklı iletişim kurma yeteneğini geliştirir. &Ouml;zellikle anaokulundaki arkadaşlarıyla yaşadığı &ccedil;atışmaları y&ouml;netmeyi &ouml;ğrenmesi, ileriki yaşamında fayda sağlar. Bu durum &ccedil;ocuğun &ccedil;&ouml;z&uuml;mlemeyi &ouml;ğrenmesini sağlarken, kendini nasıl ve ne zaman koruyacağına dair fikir sahibi olmasına yardımcı olur. Gelişen iletişim yeteneği sayesinde aynı zamanda karşısındaki kişiye saygı duymayı da &ouml;ğrenir.</p>', N'/UpLoads/ArticlePhoto/4bd520c5-9aa7-4daf-844c-6216dcdf1fbb.jpg', N'2018-08-16', 10, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (24, N'Bebek ve Sağlık', N'<p></p>
<p><strong>Banyo sonrası nemlendirici kullanılmalı</strong></p>
<p>Doğumdan sonraki ilk d&ouml;rt hafta bebeklerin cildinde bebeği kuruluktan, su ve ısı kaybından koruyan ayrıca mikroplara karşı da bariyer oluşturan, &ouml;rt&uuml; şeklinde bir yağ tabakası bulunur. Kendiliğinden bir hafta i&ccedil;inde kaybolacak olan bu tabaka, tamamen temizlemeye &ccedil;alışılmamalı ve nazik&ccedil;e silinmelidir. Yeni doğan bebekler ılık su ile her g&uuml;n yıkanabilir, &ouml;zellikle akşama doğru bir banyo bebeği rahatlatır. Bebekler ılık su d&ouml;k&uuml;lerek veya hafif ılık duş tutularak hızlıca yıkanmalıdır. Banyo sonrası yumuşak bir havluyla nazik&ccedil;e kurulayıp bebek nemlendiricileri s&uuml;rerek nemlenme sağlanmalıdır.&nbsp;</p>
<p><strong>G&ouml;bek b&ouml;lgesinin temizliğine &ouml;zen g&ouml;sterin</strong></p>
<p>Yeni doğan bebeğin g&ouml;bek bağı yaklaşık 7-10 g&uuml;n i&ccedil;inde kurur ve kendiliğinden d&uuml;şer. Bu d&ouml;nemde g&ouml;bek bağı b&ouml;lgesinden mikroplar girebileceği i&ccedil;in temizlik &ccedil;ok &ouml;nemlidir. Bebek bezi bağlanırken g&ouml;bek b&ouml;lgesi mutlaka dışarıda bırakılmalıdır. G&ouml;bek iltihapları tehlikeli olabileceği i&ccedil;in kızarıklık, şişlik, kanama veya akıntı gibi ş&uuml;pheli bir belirti varsa doktora g&ouml;sterilmelidir. Yeni doğan bebeklerde sa&ccedil; diplerinde halk arasında &ldquo;konak&rdquo; denilen sarı, yağlı, yapışık kepekler olabilir. Bu kepekleri tedavi etmek i&ccedil;in birka&ccedil; g&uuml;n konak olan b&ouml;lgeye az miktarda ay&ccedil;i&ccedil;ek yağı s&uuml;r&uuml;p 2-3 saat sonra ılık suyla ve bebek şampuanıyla yıkamak yeterlidir.&nbsp;</p>', N'/UpLoads/ArticlePhoto/330c3196-5ef5-4000-aa6f-73526ff36a0c.jpg', N'2018-08-18', 8, 12, 2)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (25, N'Yetişkin Eğitimi', N'<div class="breadcrumb" xmlns:v="http://rdf.data-vocabulary.org/#">
<div typeof="v:Breadcrumb" class="root"></div>
</div>
<div class="single_post"><header></header>
<div class="post-single-content box mark-links entry-content">
<div class="thecontent clearfix">
<h2>Yetişkin Eğitiminde Eğitici Notları</h2>
<ol>
<li><span style="text-decoration: underline;"></span><span style="text-decoration: underline;"><strong>Yetişkinin tanımlayıcı &ouml;zellikleri nelerdir?</strong></span></li>
</ol>
<ul>
<li>&Ccedil;ocuklara g&ouml;re daha b&uuml;y&uuml;k v&uuml;cutlara sahip olmak</li>
<li>&Ccedil;ok miktarda deneyime sahip olmak,</li>
<li>Yerleşmiş alışkanlıklara sahip olmak,</li>
<li>Otoriteye karşı bir diren&ccedil; ve refleks geliştirmek,</li>
<li>Verilecek kararlara ve &ccedil;&ouml;z&uuml;lecek sorunlara sahip olmak,</li>
<li>&Ouml;ğrenen bir kişi olma dışında sorumluluklar sahip olmak,</li>
<li>Tutum, değer ve eğilimlerden oluşan duygusal bir &ccedil;er&ccedil;eve geliştirmiş olmak,</li>
<li>Değişik se&ccedil;eneklere sahip olmak,</li>
<li>Kuvvetli desteğe ve yardıma cevap vermek</li>
<li>İhtiya&ccedil;larına y&ouml;nelik davranışlara sahip olmak,</li>
<li>Kendini kontrol edebilmek ve kısıtlı duygusal cevap vermek,</li>
<li>Bir ge&ccedil;mişe sahip olmak ancak şartlara g&ouml;re değişebilmek,</li>
<li>&Ouml;ğrenme ile ilgili kuvvetli istek geliştirebilmek,</li>
<li>Katabilecek fikirlere sahip olmak,</li>
<li>Geri kalmaktan korkmak,</li>
<li>Gururlu olmak.</li>
</ul>
<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span style="text-decoration: underline;"></span><span style="text-decoration: underline;"><strong>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</strong></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>
</div>
</div>
</div>', N'/UpLoads/ArticlePhoto/543250bd-c118-4696-9da6-5001b88e67f7.jpg', N'2018-08-16', 11, 13, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (26, N'Cildimiz', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/587cec28-cece-4382-bc3f-fc1c60911888.jpg', N'2018-08-24', 6, 13, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (27, N'Nasıl Beslenmeliyiz?', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/c2b3fb9b-783d-4a9a-9662-e29064d54ba1.jpg', N'2018-08-17', 9, 13, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (28, N'Matematik ve İnsan', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/af5b8ef3-bca2-4772-b56b-bf25987114e9.jpg', N'2018-08-26', 12, 12, 3)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (29, N'Tırnak Önemi', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/e92d1672-6330-4fd1-a888-f57f193b0c52.jpg', N'2018-08-23', 15, 12, 3)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (30, N'Bebek Beslenmsi', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/b58da2ca-ac12-44b2-a5b8-fc2781daf2b1.jpg', N'2018-08-12', 19, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (31, N'Yazmak?', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/319b64d8-a287-4274-99cf-536bcfe4f691.jpg', N'2018-08-24', 13, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (32, N'Saçlar Neden Dökülür ?', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/e5ac6079-b353-49d6-8f25-cdedf823d458.jpg', N'2018-08-04', 16, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (33, N'Ruhun Gıdası', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/33fa6007-a1d7-44c2-a391-e1f48a16dcc0.jpg', N'2018-08-04', 14, 12, 3)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (34, N'Renkli Saçlar ', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/420343c8-3072-4dcb-9a4a-7a1bcc0a35ba.jpg', N'2018-08-18', 1, 12, 1)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (35, N'Mantıkta Kırılma', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/5afcfddb-4738-4787-ac8e-6cae42a1f00a.jpg', N'2018-08-21', 21, 13, 7)
INSERT [dbo].[Article] ([ArticleId], [Title], [Text], [ArticlePhoto], [Time], [CategoryId], [UserId], [Displayed]) VALUES (36, N'Derinde Matematik', N'<p>Yetişkin eğitimi, &ccedil;ocuk ve gen&ccedil; eğitiminden farklı &ouml;zellikler taşır. Yetişkinlerin &ouml;zellikleri nedeniyle eğitim atmosferi ve &ouml;ğrenme ortamı da buna bağlı olarak değişiklikler g&ouml;stermektedir. B&ouml;yle bir eğitimde eğitmenlerin, katılımcıların farklı bir grup olan yetişkinler olduğunu, bu kişilerin artık okul sıralarındaki &ouml;ğrenciler gibi d&uuml;ş&uuml;nmediklerini, yetişkinlerin değişik &ouml;ğrenme bi&ccedil;imleri ve ihtiya&ccedil;lara sahip olduklarını bilmeleri gerekmektedir.</p>
<ol start="2">
<li><span></span><span><span>Yetişkin ve &ccedil;ocuk &ouml;ğrenmesi arasındaki farklar nelerdir?</span></span></li>
</ol>
<ul>
<li>Yetişkinler sık tekrar gerektirmeden &ouml;ğrenirler, oysa &ccedil;ocuklar &ouml;ğrenirken sık tekrara gereksinim duyarlar,</li>
<li>Yetişkinler &ouml;rnek yaşantılara dayalı genellemeler yapabilecek yeterli tecr&uuml;beye sahiptirler, oysa &ccedil;ocuklar &ouml;ğrenirken genellemeler yapmakta g&uuml;&ccedil;l&uuml;k &ccedil;ekerler ve deneyimleri arttık&ccedil;a &ouml;ğrenmeleri kolaylaşır,</li>
<li>Yetişkinlerde benlik kavramı olduk&ccedil;a gelişmiştir, oysa &ccedil;ocuklarda benlik kavramı fazla gelişmemiştir,</li>
<li>Yetişkinler &ccedil;evrelerine bağımlı değillerdir, oysa &ccedil;ocuklar b&uuml;y&uuml;klerine ve &ccedil;evrelerine bağımlıdırlar,</li>
<li>Yetişkinler kendilerini y&ouml;nlendirebilirler ve ne &ouml;ğrenmek istediklerini tanımlayıp ifade edebilirler, oysa &ccedil;ocuklar b&uuml;y&uuml;kler tarafından y&ouml;nlendirilmeye ihtiya&ccedil; duyarlar, ne &ouml;ğrenmek istediklerini bilemezler ve b&uuml;y&uuml;kler tarafından &ouml;ğrenmeleri gerekenler s&ouml;ylenince &ouml;ğrenirler,</li>
<li>Soyut d&uuml;ş&uuml;nebilir ve &ouml;ğrenebilirler, oysa &ccedil;ocukların yetişkinlere g&ouml;re kavramları ve deneyimleri daha az olduğu i&ccedil;in &ouml;ğrenirken daha &ccedil;ok somut kavram ve &ouml;rneklerle &ouml;ğrenirler.</li>
<li>Yetişkinler &ouml;ğrendiklerini hemen uygulamak isterler, oysa &ccedil;ocuklar &ouml;ğrendiklerinin bir &ccedil;oğunu hemen uygulamazlar ve ilerideki yaşantılarına ertelerler.</li>
<li>Yetişkinler eğitime g&ouml;n&uuml;ll&uuml; olarak katılırlar ve beklentilerini karşılamayan eğitimden uzaklaşırlar, oysa &ccedil;ocuklar eğitime zorunlu katılırlar ve uzaklaşma şansları yoktur.</li>
<li>Yetişkinlerin eğitimden beklentileri genellikle olduk&ccedil;a y&uuml;ksektir, oysa &ccedil;ocukların beklentileri sadece sınıflarını ge&ccedil;mektir.</li>
</ul>', N'/UpLoads/ArticlePhoto/953c9882-11ef-4f78-9258-e522d037bd33.jpg', N'2018-08-24', 20, 13, 17)
SET IDENTITY_INSERT [dbo].[Article] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (1, N'Bakım', 0)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (2, N'Sağlık', 0)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (3, N'Eğitim', 0)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (4, N'El Bakımı', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (5, N'Saç Bakımı', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (6, N'Cilt Bakımı', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (7, N'Piskolojik Sağlık', 2)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (8, N'Bebek Sağlığı', 2)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (9, N'Beslenme', 2)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (10, N'Okul Öncesi', 3)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (11, N'Yetişkin', 3)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (12, N'Matematik', 3)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (13, N'Yazarlık', 3)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (14, N'Müzik', 3)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (15, N'Tırnak Bakımı', 4)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (16, N'Saç Dökülmesi', 5)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (17, N'Boyalı Saç Bakımı', 5)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (18, N'Yeni Doğan Sağlığı', 8)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (19, N'Yeni Doğan Beslenme', 9)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (20, N'İleri Matematik', 12)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId]) VALUES (21, N'Mantık Eğitimi', 20)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (9, N'güzel.', 15, 36, CAST(N'2018-08-16 18:33:29.543' AS DateTime))
INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (10, N'daha önce okumuştum', 15, 33, CAST(N'2018-08-16 18:33:57.203' AS DateTime))
INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (11, N'testt', 14, 36, CAST(N'2018-08-16 18:35:54.793' AS DateTime))
INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (12, N'test', 14, 34, CAST(N'2018-08-16 18:36:20.873' AS DateTime))
INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (13, N'kel', 14, 32, CAST(N'2018-08-16 18:36:47.863' AS DateTime))
INSERT [dbo].[Comment] ([CommentId], [CommentText], [UserId], [ArticleId], [CommentTime]) VALUES (14, N'testtt', 13, 33, CAST(N'2018-08-17 18:37:00.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [Role]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [Role]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Mail], [Password], [UserPhoto], [RoleId]) VALUES (1, N'omerahsaf', N'omerahsafaltin@gmail.com', N'1453', NULL, 1)
INSERT [dbo].[User] ([UserId], [UserName], [Mail], [Password], [UserPhoto], [RoleId]) VALUES (12, N'admin', N'admin@gmail.com', N'1234', N'/UpLoads/UserPhoto/11bfe6e3-7704-4757-966e-3ad4ed7ccebf.jpg', 1)
INSERT [dbo].[User] ([UserId], [UserName], [Mail], [Password], [UserPhoto], [RoleId]) VALUES (13, N'burak', N'burak@gmail.com', N'1234', N'/UpLoads/UserPhoto/5c5fb667-843d-4229-8657-56881f9effb2.jpg', 1)
INSERT [dbo].[User] ([UserId], [UserName], [Mail], [Password], [UserPhoto], [RoleId]) VALUES (14, N'alex', N'alex@gmail.com', N'1234', N'/UpLoads/UserPhoto/1121aa44-d0dd-472b-9e41-705ed454c1f7.jpg', 2)
INSERT [dbo].[User] ([UserId], [UserName], [Mail], [Password], [UserPhoto], [RoleId]) VALUES (15, N'ufuk', N'ufuk@gmail.com', N'1111', N'/UpLoads/UserPhoto/bc5e9eec-8ae5-4f4f-a3cb-1dca52eba75b.jpg', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Category]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Article] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Article] ([ArticleId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Article]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [FortanFoniBlog] SET  READ_WRITE 
GO
