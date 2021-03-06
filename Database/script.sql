USE [master]
GO
/****** Object:  Database [BookLibrary]    Script Date: 11/5/2017 4:02:00 PM ******/
CREATE DATABASE [BookLibrary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookLibrary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.HY\MSSQL\DATA\BookLibrary.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BookLibrary_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.HY\MSSQL\DATA\BookLibrary_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BookLibrary] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookLibrary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookLibrary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookLibrary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookLibrary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookLibrary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookLibrary] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookLibrary] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookLibrary] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BookLibrary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookLibrary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookLibrary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookLibrary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookLibrary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookLibrary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookLibrary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookLibrary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookLibrary] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookLibrary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookLibrary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookLibrary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookLibrary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookLibrary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookLibrary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookLibrary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookLibrary] SET RECOVERY FULL 
GO
ALTER DATABASE [BookLibrary] SET  MULTI_USER 
GO
ALTER DATABASE [BookLibrary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookLibrary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookLibrary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookLibrary] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BookLibrary]
GO
/****** Object:  Table [dbo].[tblAccount]    Script Date: 11/5/2017 4:02:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAccount](
	[Email] [varchar](50) NOT NULL,
	[Rollnumber] [varchar](10) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_tblAccount] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBook]    Script Date: 11/5/2017 4:02:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBook](
	[ID] [varchar](10) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Author] [nvarchar](50) NOT NULL,
	[Catagories] [nvarchar](50) NOT NULL,
	[Place] [nvarchar](50) NULL,
	[AddDate] [date] NOT NULL,
	[CoverPicture] [varchar](50) NULL,
	[Status] [varchar](15) NOT NULL,
 CONSTRAINT [PK_tblBook] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBookDetail]    Script Date: 11/5/2017 4:02:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBookDetail](
	[SubID] [varchar](10) NOT NULL,
	[BookID] [varchar](10) NOT NULL,
	[Status] [varchar](15) NOT NULL,
 CONSTRAINT [PK_tblBookDetail_1] PRIMARY KEY CLUSTERED 
(
	[SubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBorrow]    Script Date: 11/5/2017 4:02:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBorrow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BorrowerEmail] [varchar](50) NOT NULL,
	[BookSubID] [varchar](10) NOT NULL,
	[CreateDate] [date] NOT NULL,
	[ReturnDate] [date] NOT NULL,
	[ExtendNumber] [int] NOT NULL,
	[IsEnd] [bit] NOT NULL,
 CONSTRAINT [PK_tblBorrow] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblAccount] ([Email], [Rollnumber], [Name], [Password], [Type]) VALUES (N'bindc@fpt.edu.vn', N'LBBinDC', N'Doan Cong Bin', N'1', 1)
INSERT [dbo].[tblAccount] ([Email], [Rollnumber], [Name], [Password], [Type]) VALUES (N'hydc@fpt.edu.vn', N'LBHyDC', N'Doan Cong Hy', N'1', 1)
INSERT [dbo].[tblAccount] ([Email], [Rollnumber], [Name], [Password], [Type]) VALUES (N'thanhdcse62548@fpt.edu.vn', N'SE62548', N'Doan Cong Thanh', N'1', 0)
INSERT [dbo].[tblAccount] ([Email], [Rollnumber], [Name], [Password], [Type]) VALUES (N'tricvmse62549@fpt.edu.vn', N'SE62549', N'Che Van Minh Tri', N'1', 0)
INSERT [dbo].[tblAccount] ([Email], [Rollnumber], [Name], [Password], [Type]) VALUES (N'tuhmse62531@fpt.edu.vn', N'SE62531', N'Huynh Minh Tu', N'1', 0)
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'GD01', N'Graphic Design: The New Basics', N'Our bestselling introduction to graphic design is now available in a revised and updated edition. In Graphic Design: The New Basics, bestselling author Ellen Lupton (Thinking with Type, Type on Screen) and design educator Jennifer Cole Phillips explain the key concepts of visual language that inform any work of design, from logo or letterhead to a complex website. Through visual demonstrations and concise commentary, students and professionals explore the formal elements of twodimensional design, such as point, line, plane, scale, hierarchy, layers, and transparency.
', N'Ellen Lupton', N'Design', N'E3', CAST(N'2016-05-05' AS Date), N'/Images/GD01.jpg', N'Unavailable')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'GD02', N'Creative Workshop: 80 Challenges', N'Have you ever struggled to complete a design project on time? Or felt that having a tight deadline stifled your capacity for maximum creativity? If so, then this book is for you.

Within Creative Workshop, you''ll find 80 creative challenges that will help you achieve a breadth of stronger design solutions, in various media, within any set time period. Exercises range from creating a typeface in an hour to designing a paper robot in an afternoon to designing web pages and other interactive experiences. Each exercise includes compelling visual solutions from other designers and background stories to help you increase your capacity to innovate.', N'David Sherwin', N'Design', N'A1', CAST(N'2017-11-20' AS Date), N'/Images/GD02.jpg', N'Unavailable')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'GD03', N'The Non-Designer''s Design Book', N'For nearly 20 years, designers and non-designers alike have been introduced to the fundamental principles of great design by author Robin Williams. Through her straightforward and light-hearted style, Robin has taught hundreds of thousands of people how to make their designs look professional using four surprisingly simple principles. Now in its fourth edition, The Non-Designer’s Design Book offers even more practical design advice, including a new chapter on the fundamentals of typography, more quizzes and exercises to train your Designer Eye, updated projects for you to try, and new visual and typographic examples to inspire your creativity.', N'Robin Williams', N'Design', N'E5', CAST(N'2016-04-05' AS Date), N'/Images/GD03.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'GD04', N'Draplin Design Co.: Pretty Much Everything', N'Esquire. Ford Motors. Burton Snowboards. The Obama Administration. While all of these brands are vastly different, they share at least one thing in com­mon: a teeny, little bit of Aaron James Draplin. Draplin is one of the new school of influential graphic designers who combine the power of design, social media, entrepreneurship, and DIY aesthetic to create a successful business and way of life.', N'Aaron James Draplin', N'Design', N'B2', CAST(N'2016-05-05' AS Date), N'/Images/GD04.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'OT01', N'The Good Samaritan', N'She’s a friendly voice on the phone. But can you trust her?

The people who call End of the Line need hope. They need reassurance that life is worth living. But some are unlucky enough to get through to Laura. Laura doesn’t want them to hope. She wants them to die.

Laura hasn’t had it easy: she’s survived sickness and a difficult marriage only to find herself heading for forty, unsettled and angry. She doesn’t love talking to people worse off than she is. She craves it.

But now someone’s on to her—Ryan, whose world falls apart when his pregnant wife ends her life, hand in hand with a stranger. Who was this man, and why did they choose to die together?

The sinister truth is within Ryan’s grasp, but he has no idea of the desperate lengths Laura will go to…

Because the best thing about being a Good Samaritan is that you can get away with murder.', N'John Marrs', N'Others', N'B1', CAST(N'2017-11-02' AS Date), N'/Images/OT01.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'OT02', N'The Unkillable Kitty O''Kane', N'When fiery and idealistic Kitty O’Kane escapes the crushing poverty of Dublin’s tenements, she’s determined that no one should ever suffer like she did. As she sets out to save the world, she finds herself at the forefront of events that shaped the early twentieth century. While working as a maid, she survives the sinking of the Titanic. As a suffragette in New York’s Greenwich Village, she’s jailed for breaking storefront windows. And traveling war-torn Europe as a journalist, she’s at the Winter Palace when it’s stormed by the Bolsheviks. Ultimately she returns to her homeland to serve as a nurse in the Irish Civil War.

During Kitty’s remarkable journey, she reunites with her childhood sweetheart, Tom Doyle, but Tom doesn’t know everything about her past—a past that continues to haunt her. Will Kitty accept that before she can save everyone else, she needs to find a way to save herself? Or will the sins of her past stop her from pursuing her own happiness?', N'Colin Falconer', N'Others', N'B2', CAST(N'2017-11-01' AS Date), N'/Images/OT02.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'OT03', N'Harry Potter and the Prisoner of Azkaban', N'For twelve long years, the dread fortress of Azkaban held an infamous prisoner named Sirius Black. Convicted of killing thirteen people with a single curse, he was said to be the heir apparent to the Dark Lord, Voldemort.



Now he has escaped, leaving only two clues as to where he might be headed: Harry Potter''s defeat of You-Know-Who was Black''s downfall as well. And the Azkaban guards heard Black muttering in his sleep, "He''s at Hogwarts . . . he''s at Hogwarts."



Harry Potter isn''t safe, not even within the walls of his magical school, surrounded by his friends. Because on top of it all, there may well be a traitor in their midst.', N'J.K. Rowling', N'Others', N'B3', CAST(N'2017-10-02' AS Date), N'/Images/OT03.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'OT04', N'Before We Were Yours', N'Memphis, 1939. Twelve-year-old Rill Foss and her four younger siblings live a magical life aboard their family’s Mississippi River shantyboat. But when their father must rush their mother to the hospital one stormy night, Rill is left in charge—until strangers arrive in force. Wrenched from all that is familiar and thrown into a Tennessee Children’s Home Society orphanage, the Foss children are assured that they will soon be returned to their parents—but they quickly realize the dark truth. At the mercy of the facility’s cruel director, Rill fights to keep her sisters and brother together in a world of danger and uncertainty.', N'Lisa Wingate', N'Others', N'C1', CAST(N'2017-05-02' AS Date), N'/Images/OT04.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SB01', N'Economics in One Lesson', N'Called by H. L. Mencken, one of the few economists in history who could really write, Henry Hazlitt achieved lasting fame for this brilliant but concise work. In it, he explains basic truths about economics and the economic fallacies responsible for unemployment, inflation, high taxes, and recession', N'Henry Hazlitt', N'Economic', N'D1', CAST(N'2016-05-05' AS Date), N'/Images/SB01.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SB02', N'Misbehaving: The Making of Behavioral Economics', N'Nobel laureate Richard H. Thaler has spent his career studying the radical notion that the central agents in the economy are humans?predictable, error-prone individuals. Misbehaving is his arresting, frequently hilarious account of the struggle to bring an academic discipline back down to earth?and change the way we think about economics, ourselves, and our world.', N'Richard H. Thaler', N'Economic', N'B1', CAST(N'2017-05-05' AS Date), N'/Images/SB02.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SB03', N'The New Confessions of an Economic Hit Man', N'Shocking Bestseller: The original version of this astonishing tell-all book spent 73 weeks on the New York Times bestseller list, has sold more than 1.25 million copies, and has been translated into 32 languages. ', N'John Perkins', N'Economic', N'E2', CAST(N'2017-05-06' AS Date), N'/Images/SB03.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SB04', N'Naked Economics: Undressing the Dismal Science', N'Finally! A book about economics that won’t put you to sleep. In fact, you won’t be able to put this bestseller down. In our challenging economic climate, this perennial favorite of students and general readers is more than a good read, it’s a necessary investment?with a blessedly sure rate of return. Demystifying buzzwords, laying bare the truths behind oft-quoted numbers, and answering the questions you were always too embarrassed to ask, the breezy Naked Economics gives readers the tools they need to engage with pleasure and confidence in the deeply relevant, not so dismal science.', N'Charles Wheelan', N'Economic', N'E3', CAST(N'2017-05-07' AS Date), N'/Images/SB04.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SB05', N'Economics: The User''s Guide', N'In his bestselling 23 Things They Don''t Tell You About Capitalism, Cambridge economist Ha-Joon Chang brilliantly debunked many of the predominant myths of neoclassical economics. Now, in an entertaining and accessible primer, he explains how the global economy actually works--in real-world terms. Writing with irreverent wit, a deep knowledge of history, and a disregard for conventional economic pieties, Chang offers insights that will never be found in the textbooks.', N'Ha-Joon Chang', N'Economic', N'D1', CAST(N'2017-03-20' AS Date), N'/Images/SB05.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SE01', N'Java: A Beginner''s Guide, Sixth Edition', N'Essential Java Programming Skills--Made Easy!
Fully updated for Java Platform, Standard Edition 8 (Java SE 8), Java: A Beginner''s Guide, Sixth Edition gets you started programming in Java right away. Bestselling programming author Herb Schildt begins with the basics, such as how to create, compile, and run a Java program. He then moves on to the keywords, syntax, and constructs that form the core of the Java language. This Oracle Press resource also covers some of Java''s more advanced features, including multithreaded programming, generics, and Swing. Of course, new Java SE 8 features such as lambda expressions and default interface methods are described. An introduction to JavaFX, Java''s newest GUI, concludes this step-by-step tutorial.', N'Herbert Schildt', N'Engineer', N'D2', CAST(N'2017-03-02' AS Date), N'/Images/SE01.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SE02', N'JavaScript: The Good Parts ', N'Most programming languages contain good and bad parts, but JavaScript has more than its share of the bad, having been developed and released in a hurry before it could be refined. This authoritative book scrapes away these bad features to reveal a subset of JavaScript that''s more reliable, readable, and maintainable than the language as a whole—a subset you can use to create truly extensible and efficient code.', N'Douglas Crockford', N'Engineer', N'C2', CAST(N'2017-04-03' AS Date), N'/Images/SE02.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SE03', N'C Programming Language', N'The authors present the complete guide to ANSI standard C language programming. Written by the developers of C, this new version helps readers keep up with the finalized ANSI standard for C while showing how to take advantage of C''s rich set of operators, economy of expression, improved control flow, and data structures. The 2/E has been completely rewritten with additional examples and problem sets to clarify the implementation of difficult language constructs. For years, C programmers have let K&R guide them to building well-structured and efficient programs. ', N'Brian W. Kernighan', N'Engineer', N'B2', CAST(N'2016-05-03' AS Date), N'/Images/SE03.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SE04', N'Refactoring: Improving the Design of Existing Code', N'As the application of object technology--particularly the Java programming language--has become commonplace, a new problem has emerged to confront the software development community. Significant numbers of poorly designed programs have been created by less-experienced developers, resulting in applications that are inefficient and hard to maintain and extend. Increasingly, software system professionals are discovering just how difficult it is to work with these inherited, non-optimal applications.', N'Martin Fowler', N'Engineer', N'B1', CAST(N'2016-05-03' AS Date), N'/Images/SE04.jpg', N'Available')
INSERT [dbo].[tblBook] ([ID], [Name], [Description], [Author], [Catagories], [Place], [AddDate], [CoverPicture], [Status]) VALUES (N'SE05', N'Data Structures and Algorithms in Java', N'Data Structures and Algorithms in Java, Second Edition is designed to be easy to read and understand although the topic itself is complicated. Algorithms are the procedures that software programs use to manipulate data structures. Besides clear and simple example programs, the author includes a workshop as a small demonstration program executable on a Web browser. The programs demonstrate in graphical form what data structures look like and how they operate. In the second edition, the program is rewritten to improve operation and clarify the algorithms, the example programs are revised to work with the latest version of the Java JDK, and questions and exercises will be added at the end of each chapter making the book even more useful.', N'Robert Lafore', N'Engineer', N'A2', CAST(N'2017-05-12' AS Date), N'/Images/SE05.jpg', N'Available')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0101', N'GD01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0102', N'GD01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0103', N'GD01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0201', N'GD02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0301', N'GD03', N'Lost')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'GD0401', N'GD04', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0101', N'OT01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0102', N'OT01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0103', N'OT01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0201', N'OT02', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0203', N'OT02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0301', N'OT03', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0302', N'OT03', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'OT0401', N'OT04', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0101', N'SB01', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0201', N'SB02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0202', N'SB02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0203', N'SB02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0204', N'SB02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0301', N'SB03', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0401', N'SB04', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0402', N'SB04', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0501', N'SB05', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SB0502', N'SB05', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0101', N'SE01', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0102', N'SE01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0103', N'SE01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0104', N'SE01', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0105', N'SE01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0106', N'SE01', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0201', N'SE02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0202', N'SE02', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0301', N'SE03', N'Borrowed')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0401', N'SE04', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0501', N'SE05', N'Free')
INSERT [dbo].[tblBookDetail] ([SubID], [BookID], [Status]) VALUES (N'SE0502', N'SE05', N'Free')
SET IDENTITY_INSERT [dbo].[tblBorrow] ON 

INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (22, N'thanhdcse62548@fpt.edu.vn', N'SE0301', CAST(N'2017-10-30' AS Date), CAST(N'2017-11-05' AS Date), 3, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (23, N'thanhdcse62548@fpt.edu.vn', N'SE0101', CAST(N'2017-10-20' AS Date), CAST(N'2017-11-01' AS Date), 3, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (24, N'thanhdcse62548@fpt.edu.vn', N'SE0401', CAST(N'2017-07-20' AS Date), CAST(N'2017-11-05' AS Date), 0, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (26, N'hydc@fpt.edu.vn', N'OT0401', CAST(N'2017-10-03' AS Date), CAST(N'2017-11-05' AS Date), 2, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (27, N'hydc@fpt.edu.vn', N'OT0301', CAST(N'2017-10-20' AS Date), CAST(N'2017-10-30' AS Date), 3, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (29, N'hydc@fpt.edu.vn', N'SB0301', CAST(N'2017-07-20' AS Date), CAST(N'2017-11-04' AS Date), 0, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (30, N'thanhdcse62548@fpt.edu.vn', N'OT0201', CAST(N'2017-10-11' AS Date), CAST(N'2017-11-16' AS Date), 1, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (31, N'thanhdcse62548@fpt.edu.vn', N'SE0502', CAST(N'2017-10-11' AS Date), CAST(N'2017-11-10' AS Date), 2, 0)
INSERT [dbo].[tblBorrow] ([ID], [BorrowerEmail], [BookSubID], [CreateDate], [ReturnDate], [ExtendNumber], [IsEnd]) VALUES (32, N'thanhdcse62548@fpt.edu.vn', N'SE0101', CAST(N'2017-10-11' AS Date), CAST(N'2017-11-20' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[tblBorrow] OFF
ALTER TABLE [dbo].[tblBookDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblBookDetail_tblBook] FOREIGN KEY([BookID])
REFERENCES [dbo].[tblBook] ([ID])
GO
ALTER TABLE [dbo].[tblBookDetail] CHECK CONSTRAINT [FK_tblBookDetail_tblBook]
GO
ALTER TABLE [dbo].[tblBorrow]  WITH CHECK ADD  CONSTRAINT [FK_tblBorrow_tblAccount] FOREIGN KEY([BorrowerEmail])
REFERENCES [dbo].[tblAccount] ([Email])
GO
ALTER TABLE [dbo].[tblBorrow] CHECK CONSTRAINT [FK_tblBorrow_tblAccount]
GO
ALTER TABLE [dbo].[tblBorrow]  WITH CHECK ADD  CONSTRAINT [FK_tblBorrow_tblBookDetail] FOREIGN KEY([BookSubID])
REFERENCES [dbo].[tblBookDetail] ([SubID])
GO
ALTER TABLE [dbo].[tblBorrow] CHECK CONSTRAINT [FK_tblBorrow_tblBookDetail]
GO
USE [master]
GO
ALTER DATABASE [BookLibrary] SET  READ_WRITE 
GO
