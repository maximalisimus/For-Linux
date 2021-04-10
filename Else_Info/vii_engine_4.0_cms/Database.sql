-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Дек 16 2012 г., 17:19
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `vii-engine`
--

-- --------------------------------------------------------

--
-- Структура таблицы `vii_albums`
--

CREATE TABLE IF NOT EXISTS `vii_albums` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `111` int(11) NOT NULL,
  `photo_num` mediumint(9) NOT NULL,
  `comm_num` mediumint(9) NOT NULL,
  `cover` text NOT NULL,
  `descr` text NOT NULL,
  `ahash` text NOT NULL,
  `position` text NOT NULL,
  `adate` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `privacy` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_attach`
--

CREATE TABLE IF NOT EXISTS `vii_attach` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo` text NOT NULL,
  `ouser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `vii_attach`
--

INSERT INTO `vii_attach` (`id`, `photo`, `ouser_id`) VALUES
(1, 'a4a459ef5a5c05c092d5.jpg', 53);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_audio`
--

CREATE TABLE IF NOT EXISTS `vii_audio` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `auser_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `url` text NOT NULL,
  `artist` text NOT NULL,
  `adate` varchar(25) NOT NULL,
  `user_search_pref` int(11) NOT NULL,
  PRIMARY KEY (`aid`),
  FULLTEXT KEY `search` (`name`,`artist`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_banned`
--

CREATE TABLE IF NOT EXISTS `vii_banned` (
  `descr` text NOT NULL,
  `date` varchar(50) NOT NULL,
  `always` text NOT NULL,
  `ip` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_blog`
--

CREATE TABLE IF NOT EXISTS `vii_blog` (
  `title` varchar(30) NOT NULL,
  `story` text NOT NULL,
  `date` varchar(50) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_city`
--

CREATE TABLE IF NOT EXISTS `vii_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `id_country` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Дамп данных таблицы `vii_city`
--

INSERT INTO `vii_city` (`id`, `name`, `id_country`) VALUES
(1, 'Авдеевка', 2),
(2, 'Киев', 3),
(3, 'Омск', 2),
(4, 'Томск', 2),
(5, 'Москва', 2),
(6, 'Харьков', 3),
(7, 'Львов', 3),
(8, 'Днепропетровск', 3),
(9, 'Пыть-Ях', 2),
(10, 'Новосибирск', 2),
(11, 'Санкт-Питербург', 2),
(12, 'Ханте-Мансийск', 2),
(13, 'Табольск', 2),
(14, 'Барнаул', 2),
(15, 'Валдивосток', 2),
(16, 'Рязань', 2),
(17, 'Иркутск', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities`
--

CREATE TABLE IF NOT EXISTS `vii_communities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `descr` text NOT NULL,
  `traf` int(11) NOT NULL,
  `ulist` text NOT NULL,
  `photo` text NOT NULL,
  `admin` text NOT NULL,
  `feedback` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `real_admin` text NOT NULL,
  `rec_num` mediumint(9) NOT NULL,
  `del` varchar(3) NOT NULL,
  `ban` varchar(3) NOT NULL,
  `adres` text NOT NULL,
  `audio_num` mediumint(9) NOT NULL,
  `title` text NOT NULL,
  `date` varchar(30) NOT NULL,
  `type` int(11) NOT NULL,
  `photos_num` mediumint(9) NOT NULL,
  `cnt` text NOT NULL,
  `videos_num` int(11) NOT NULL,
  `photo_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities_audio`
--

CREATE TABLE IF NOT EXISTS `vii_communities_audio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `adate` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `artist` varchar(100) NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities_feedback`
--

CREATE TABLE IF NOT EXISTS `vii_communities_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `office` text NOT NULL,
  `fphone` text NOT NULL,
  `femail` text NOT NULL,
  `fdate` varchar(25) NOT NULL,
  `fuser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities_photos`
--

CREATE TABLE IF NOT EXISTS `vii_communities_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_id` int(11) NOT NULL,
  `add_date` varchar(30) NOT NULL,
  `photo` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities_wall`
--

CREATE TABLE IF NOT EXISTS `vii_communities_wall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `public_id` int(11) NOT NULL,
  `fast_comm_id` int(11) NOT NULL,
  `add_date` varchar(25) NOT NULL,
  `date` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `attach` text NOT NULL,
  `fasts_num` mediumint(9) NOT NULL,
  `admin` text NOT NULL,
  `likes_num` mediumint(9) NOT NULL,
  `likes_users` text NOT NULL,
  `tell_uid` int(11) NOT NULL,
  `tell_date` varchar(30) NOT NULL,
  `public` text NOT NULL,
  `tell_comm` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `vii_communities_wall`
--

INSERT INTO `vii_communities_wall` (`id`, `title`, `public_id`, `fast_comm_id`, `add_date`, `date`, `text`, `attach`, `fasts_num`, `admin`, `likes_num`, `likes_users`, `tell_uid`, `tell_date`, `public`, `tell_comm`) VALUES
(1, '', 20, 0, '1349888255', '', 'dvdv', '', 0, '', 1, 'u53|', 0, '', '', ''),
(2, '', 20, 0, '1349954042', '', 'тра', '', 0, '', 0, '', 0, '', '', ''),
(3, '', 20, 0, '1349954066', '', '', 'audio|5||audio|6||audio|6||', 0, '', 1, 'u53|', 0, '', '', ''),
(4, '', 20, 0, '1349974125', '', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''56'', ''90a8736a45457bf.jpg''); return false"><img src="/uploads/users/56/o_90a8736a45457bf.jpg" style="margin-top:3px"></a></div>', '', 0, '', 0, '', 56, '1349973974', '0', ''),
(5, '', 20, 0, '1350044520', '', 'sss', '', 0, '', 0, '', 0, '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_communities_wall_like`
--

CREATE TABLE IF NOT EXISTS `vii_communities_wall_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `vii_communities_wall_like`
--

INSERT INTO `vii_communities_wall_like` (`id`, `rec_id`, `user_id`, `date`) VALUES
(1, 1, 53, '1349954030'),
(3, 3, 53, '1349955123');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_country`
--

CREATE TABLE IF NOT EXISTS `vii_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `vii_country`
--

INSERT INTO `vii_country` (`id`, `name`) VALUES
(2, 'Россия'),
(3, 'Украина');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_doc`
--

CREATE TABLE IF NOT EXISTS `vii_doc` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `duser_id` int(11) NOT NULL,
  `dname` varchar(150) NOT NULL,
  `dsize` varchar(19) NOT NULL,
  `ddate` varchar(100) NOT NULL,
  `ddownload_name` text NOT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `vii_doc`
--

INSERT INTO `vii_doc` (`did`, `duser_id`, `dname`, `dsize`, `ddate`, `ddownload_name`) VALUES
(1, 56, 'trans.gif', '9.6 Кб', '1349973927', '280ec66cac564938663a0b85d.gif');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_fave`
--

CREATE TABLE IF NOT EXISTS `vii_fave` (
  `user_id` int(11) NOT NULL,
  `fave_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_fave`
--

INSERT INTO `vii_fave` (`user_id`, `fave_id`, `date`) VALUES
(53, 54, '2012-10-11'),
(53, 55, '2012-10-12');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_friends`
--

CREATE TABLE IF NOT EXISTS `vii_friends` (
  `user_id` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `friends_date` date NOT NULL,
  `for_user_id` int(11) NOT NULL,
  `subscriptions` int(11) NOT NULL,
  `did` int(11) NOT NULL,
  `dname` varchar(50) NOT NULL,
  `ddate` varchar(30) NOT NULL,
  `ddownload_name` varchar(50) NOT NULL,
  `duser_id` int(11) NOT NULL,
  `views` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_friends`
--

INSERT INTO `vii_friends` (`user_id`, `from_user_id`, `friend_id`, `friends_date`, `for_user_id`, `subscriptions`, `did`, `dname`, `ddate`, `ddownload_name`, `duser_id`, `views`) VALUES
(53, 0, 20, '2012-10-10', 0, 2, 0, '', '', '', 0, 0),
(47, 0, 18, '2012-10-04', 0, 2, 0, '', '', '', 0, 0),
(44, 0, 15, '2012-10-01', 0, 2, 0, '', '', '', 0, 0),
(49, 0, 19, '2012-10-04', 0, 2, 0, '', '', '', 0, 0),
(42, 0, 11, '2012-09-30', 0, 2, 0, '', '', '', 0, 0),
(53, 0, 54, '2012-10-11', 0, 1, 0, '', '', '', 0, 0),
(55, 0, 18, '2012-10-11', 0, 2, 0, '', '', '', 0, 0),
(55, 0, 20, '2012-10-11', 0, 2, 0, '', '', '', 0, 0),
(55, 0, 53, '2012-10-11', 0, 1, 0, '', '', '', 0, 0),
(53, 0, 55, '2012-10-11', 0, 0, 0, '', '', '', 0, 5),
(55, 0, 53, '2012-10-11', 0, 0, 0, '', '', '', 0, 5),
(56, 0, 20, '2012-10-11', 0, 2, 0, '', '', '', 0, 0),
(56, 0, 53, '2012-10-11', 0, 0, 0, '', '', '', 0, 4),
(53, 0, 56, '2012-10-11', 0, 0, 0, '', '', '', 0, 7),
(53, 0, 55, '2012-10-12', 0, 1, 0, '', '', '', 0, 0),
(57, 0, 20, '2012-10-12', 0, 2, 0, '', '', '', 0, 0),
(57, 0, 18, '2012-10-12', 0, 2, 0, '', '', '', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_friends_demands`
--

CREATE TABLE IF NOT EXISTS `vii_friends_demands` (
  `for_user_id` int(11) NOT NULL,
  `demand_date` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_friends_demands`
--

INSERT INTO `vii_friends_demands` (`for_user_id`, `demand_date`, `from_user_id`) VALUES
(48, 2012, 47),
(54, 2012, 53),
(58, 2012, 53);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_gifts`
--

CREATE TABLE IF NOT EXISTS `vii_gifts` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `gdate` date NOT NULL,
  `uid` int(11) NOT NULL,
  `gift` text NOT NULL,
  `from_uid` int(11) NOT NULL,
  `msg` text NOT NULL,
  `privacy` int(11) NOT NULL,
  `status` text NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `vii_gifts`
--

INSERT INTO `vii_gifts` (`gid`, `text`, `gdate`, `uid`, `gift`, `from_uid`, `msg`, `privacy`, `status`) VALUES
(1, '', '0000-00-00', 54, '698', 53, '', 1, '1'),
(2, '', '0000-00-00', 54, '147', 53, '', 1, '1'),
(3, '', '0000-00-00', 55, '698', 53, '', 1, '1'),
(4, '', '0000-00-00', 56, '147', 53, '', 1, '1'),
(5, '', '0000-00-00', 58, '147', 53, '', 1, '1'),
(6, '', '0000-00-00', 58, '698', 53, '', 1, '1');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_gifts_list`
--

CREATE TABLE IF NOT EXISTS `vii_gifts_list` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) NOT NULL,
  `img` varchar(100) NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_im`
--

CREATE TABLE IF NOT EXISTS `vii_im` (
  `all_msg_num` int(11) NOT NULL,
  `iuser_id` int(11) NOT NULL,
  `im_user_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_num` varchar(50) NOT NULL,
  `idate` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Дамп данных таблицы `vii_im`
--

INSERT INTO `vii_im` (`all_msg_num`, `iuser_id`, `im_user_id`, `id`, `msg_num`, `idate`) VALUES
(5, 53, 57, 14, '0', '1350021872'),
(1, 57, 53, 13, '0', '1350021872'),
(7, 53, 56, 12, '0', '1349974048'),
(7, 56, 53, 11, '0', '1349974048');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_invites`
--

CREATE TABLE IF NOT EXISTS `vii_invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_log`
--

CREATE TABLE IF NOT EXISTS `vii_log` (
  `ip` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `browser` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_log`
--

INSERT INTO `vii_log` (`ip`, `uid`, `browser`) VALUES
('91.220.61.68', 50, 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.10.289 Version/12.02'),
('79.136.165.214', 49, 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0'),
('178.150.152.170', 48, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('2.60.42.191', 47, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('2.60.43.134', 46, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('2.60.43.134', 45, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('176.210.20.163', 44, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('2.60.30.37', 43, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('2.60.39.231', 42, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('213.87.121.41', 51, 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4'),
('213.87.121.41', 52, 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.10.289 Version/12.02'),
('2.60.94.64', 53, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4'),
('178.95.20.174', 54, 'Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20100101 Firefox/15.0.1'),
('2.60.94.53', 55, 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'),
('78.108.79.134', 56, 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4'),
('217.173.27.182', 57, 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.1634 Safari/535.19 YI'),
('217.212.230.86', 58, 'Opera/9.80 (J2ME/MIDP; Opera Mini/7.0.30567/28.2725; U; ru) Presto/2.8.119 Version/11.10'),
('127.0.0.1', 59, 'Opera/9.80 (Windows NT 6.1) Presto/2.12.388 Version/12.11');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_mail_tpl`
--

CREATE TABLE IF NOT EXISTS `vii_mail_tpl` (
  `id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_messages`
--

CREATE TABLE IF NOT EXISTS `vii_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `for_user_id` int(11) NOT NULL,
  `pm_read` text NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `folder` text NOT NULL,
  `history_user_id` int(11) NOT NULL,
  `theme` text NOT NULL,
  `date` varchar(25) NOT NULL,
  `attach` varchar(200) NOT NULL,
  `title` text NOT NULL,
  `tell_uid` mediumint(9) NOT NULL,
  `tell_date` varchar(30) NOT NULL,
  `public` varchar(200) NOT NULL,
  `tell_comm` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=67 ;

--
-- Дамп данных таблицы `vii_messages`
--

INSERT INTO `vii_messages` (`id`, `text`, `for_user_id`, `pm_read`, `from_user_id`, `folder`, `history_user_id`, `theme`, `date`, `attach`, `title`, `tell_uid`, `tell_date`, `public`, `tell_comm`) VALUES
(52, 'но не чё норм сделал! дороботать и в поряде будет', 56, 'yes', 53, 'outbox', 56, '...', '1349974016', '', '', 0, '', '', ''),
(51, 'но не чё норм сделал! дороботать и в поряде будет', 53, 'yes', 56, 'inbox', 56, '...', '1349974016', '', '', 0, '', '', ''),
(50, '', 53, 'yes', 56, 'outbox', 53, '...', '1349973920', 'smile|37.gif||photo_u|aa9d0a1fea5976743b17.jpg|18||video|d43aee095de1354.jpg|14|53||', '', 0, '', '', ''),
(49, '', 56, 'yes', 53, 'inbox', 53, '...', '1349973920', 'smile|37.gif||photo_u|aa9d0a1fea5976743b17.jpg|18||video|d43aee095de1354.jpg|14|53||', '', 0, '', '', ''),
(48, ')))))))', 56, 'yes', 53, 'outbox', 56, '...', '1349973870', 'smile|1.gif||photo_u|attach|d729a77890a484165ed1.jpg||video|d43aee095de1354.jpg|15|56||', '', 0, '', '', ''),
(47, ')))))))', 53, 'yes', 56, 'inbox', 56, '...', '1349973870', 'smile|1.gif||photo_u|attach|d729a77890a484165ed1.jpg||video|d43aee095de1354.jpg|15|56||', '', 0, '', '', ''),
(46, '.....', 53, 'yes', 56, 'outbox', 53, '...', '1349973821', '', '', 0, '', '', ''),
(45, '.....', 56, 'yes', 53, 'inbox', 53, '...', '1349973821', '', '', 0, '', '', ''),
(44, 'тест', 56, 'yes', 53, 'outbox', 56, '...', '1349973772', '', '', 0, '', '', ''),
(43, 'тест', 53, 'yes', 56, 'inbox', 56, '...', '1349973772', '', '', 0, '', '', ''),
(53, '', 53, 'yes', 56, 'inbox', 56, '...', '1349974036', 'smile|45.gif||', '', 0, '', '', ''),
(54, '', 56, 'yes', 53, 'outbox', 56, '...', '1349974036', 'smile|45.gif||', '', 0, '', '', ''),
(55, 'стена осталась!', 56, 'yes', 53, 'inbox', 53, '...', '1349974048', '', '', 0, '', '', ''),
(56, 'стена осталась!', 53, 'yes', 56, 'outbox', 53, '...', '1349974048', '', '', 0, '', '', ''),
(57, 'купил наконецто )', 53, 'yes', 57, 'inbox', 57, '...', '1350021500', '', '', 0, '', '', ''),
(60, 'что?', 53, 'yes', 57, 'outbox', 53, '...', '1350021781', '', '', 0, '', '', ''),
(61, 'двиг)', 53, 'yes', 57, 'inbox', 57, '...', '1350021799', '', '', 0, '', '', ''),
(64, 'уже давно, почти доделал базу', 53, 'yes', 57, 'outbox', 53, '...', '1350021854', '', '', 0, '', '', ''),
(65, ':)', 53, 'yes', 57, 'inbox', 57, '...', '1350021872', '', '', 0, '', '', ''),
(66, ':)', 57, 'yes', 53, 'outbox', 57, '...', '1350021872', '', '', 0, '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_news`
--

CREATE TABLE IF NOT EXISTS `vii_news` (
  `action_text` text NOT NULL,
  `action_time` varchar(50) NOT NULL,
  `ac_id` int(11) NOT NULL AUTO_INCREMENT,
  `ac_user_id` int(11) NOT NULL,
  `action_type` tinyint(11) NOT NULL,
  `obj_id` int(11) NOT NULL,
  `author_user_id` int(11) NOT NULL,
  `for_user_id` int(11) NOT NULL,
  `fasts_num` mediumint(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `photo` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  PRIMARY KEY (`ac_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=181 ;

--
-- Дамп данных таблицы `vii_news`
--

INSERT INTO `vii_news` (`action_text`, `action_time`, `ac_id`, `ac_user_id`, `action_type`, `obj_id`, `author_user_id`, `for_user_id`, `fasts_num`, `title`, `photo`, `comments`) VALUES
('', '1350021205', 171, 55, 1, 37, 0, 0, 0, '', 0, 0),
('|u53|', '1350021211', 172, 53, 7, 37, 0, 55, 0, '', 0, 0),
('bfb', '1350021215', 173, 53, 6, 37, 0, 55, 0, '', 0, 0),
('<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''57'', ''f1f1641ae105362.jpg''); return false"><img src="/uploads/users/57/o_f1f1641ae105362.jpg" style="margin-top:3px"></a></div>', '1350021509', 174, 57, 1, 39, 0, 0, 0, '', 0, 0),
('Скоро закрою сайт!', '1350022017', 175, 53, 1, 40, 0, 0, 0, '', 0, 0),
('', '1350044304', 176, 53, 1, 41, 0, 0, 0, '', 0, 0),
('sss', '1350044520', 177, 20, 11, 5, 0, 0, 0, '', 0, 0),
('sd', '1350044529', 178, 53, 6, 37, 0, 55, 0, '', 0, 0),
('<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''53'', ''e9832e9058a4e07.jpg''); return false"><img src="/uploads/users/53/o_e9832e9058a4e07.jpg" style="margin-top:3px"></a></div>', '1350047466', 179, 53, 1, 43, 0, 0, 0, '', 0, 0),
('vfd', '1350047610', 180, 53, 1, 44, 0, 0, 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_notes`
--

CREATE TABLE IF NOT EXISTS `vii_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_text` text NOT NULL,
  `title` varchar(50) NOT NULL,
  `comm_num` varchar(25) NOT NULL,
  `owner_user_id` int(11) NOT NULL,
  `user_name` varchar(40) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `vii_notes`
--

INSERT INTO `vii_notes` (`id`, `full_text`, `title`, `comm_num`, `owner_user_id`, `user_name`, `date`) VALUES
(5, 'нннн', 'нпннн', '3', 56, '', '2012-10-11 20:41:58');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_notes_comments`
--

CREATE TABLE IF NOT EXISTS `vii_notes_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `note_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_photos`
--

CREATE TABLE IF NOT EXISTS `vii_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(25) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comm_num` mediumint(11) NOT NULL,
  `photo_name` text NOT NULL,
  `date` varchar(50) NOT NULL,
  `position` varchar(200) NOT NULL,
  `descr` text NOT NULL,
  `hash` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=62 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_photos_comments`
--

CREATE TABLE IF NOT EXISTS `vii_photos_comments` (
  `pid` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `album_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` varchar(45) NOT NULL,
  `hash` text NOT NULL,
  `owner_id` int(11) NOT NULL,
  `photo_name` varchar(50) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_photos_comments`
--

INSERT INTO `vii_photos_comments` (`pid`, `text`, `album_id`, `user_id`, `date`, `hash`, `owner_id`, `photo_name`, `id`) VALUES
(52, 'nnjkb', 14, 43, '2012-09-30 19:23:53', '494952c3e3096d67a7fed9951e230e39nnjkb52', 43, '55b185a3b62910578370.jpg', 0),
(53, 'jkbg fgxdxy', 14, 43, '2012-09-30 19:24:03', 'ea9f0888801b87e38e2627e6d1e087ffjkbg fgxdxy53', 43, '0505ab9d8f6ddb223568.jpg', 0),
(57, '1', 16, 53, '2012-10-11 06:56:07', '612bb1fccfb9a3ce33762baf219d0432157', 53, '8eaebbd32beed9022816.jpg', 0),
(61, '1', 17, 53, '2012-10-11 20:52:52', '0224886896149ea804cd7a6873b818e7161', 56, '6c5364937839b4c1ef6c.jpg', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_photos_mark`
--

CREATE TABLE IF NOT EXISTS `vii_photos_mark` (
  `mphoto_id` int(11) NOT NULL,
  `mapprove` varchar(25) NOT NULL,
  `muser_id` int(11) NOT NULL,
  `mphoto_name` varchar(100) NOT NULL,
  `msettings_pos` varchar(100) NOT NULL,
  `mmark_user_id` int(11) NOT NULL,
  `mdate` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_report`
--

CREATE TABLE IF NOT EXISTS `vii_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruser_id` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `act` text NOT NULL,
  `type` text NOT NULL,
  `text` text NOT NULL,
  `date` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_restore`
--

CREATE TABLE IF NOT EXISTS `vii_restore` (
  `email` varchar(60) NOT NULL,
  `hash` char(100) NOT NULL,
  `ip` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_static`
--

CREATE TABLE IF NOT EXISTS `vii_static` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `alt_name` varchar(255) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_support`
--

CREATE TABLE IF NOT EXISTS `vii_support` (
  `title` varchar(255) NOT NULL,
  `question` varchar(50) NOT NULL,
  `suser_id` int(11) NOT NULL,
  `sfor_user_id` int(11) NOT NULL,
  `sdate` date NOT NULL,
  `сdate` date NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `vii_support`
--

INSERT INTO `vii_support` (`title`, `question`, `suser_id`, `sfor_user_id`, `sdate`, `сdate`, `id`) VALUES
('Проверяка', 'Проверка', 51, 51, '0000-00-00', '0000-00-00', 1),
('Еще раз', 'Мало ли что и здесь', 51, 51, '0000-00-00', '0000-00-00', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_support_answers`
--

CREATE TABLE IF NOT EXISTS `vii_support_answers` (
  `qid` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adate` varchar(25) NOT NULL,
  `answer` text NOT NULL,
  `auser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_updates`
--

CREATE TABLE IF NOT EXISTS `vii_updates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NOT NULL,
  `lnk` text NOT NULL,
  `text` text NOT NULL,
  `date` varchar(25) NOT NULL,
  `type` text NOT NULL,
  `for_user_id` int(11) NOT NULL,
  `user_search_pref` text NOT NULL,
  `user_photo` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_users`
--

CREATE TABLE IF NOT EXISTS `vii_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(200) NOT NULL,
  `user_password` char(50) NOT NULL,
  `user_name` varchar(25) NOT NULL,
  `user_lastname` varchar(25) NOT NULL,
  `user_sex` int(11) NOT NULL,
  `user_day` int(11) NOT NULL,
  `user_month` int(11) NOT NULL,
  `user_year` int(11) NOT NULL,
  `user_country` varchar(50) NOT NULL,
  `user_city` varchar(50) NOT NULL,
  `user_reg_date` varchar(60) NOT NULL,
  `user_lastdate` varchar(60) NOT NULL,
  `user_group` smallint(11) NOT NULL,
  `user_hid` char(100) NOT NULL,
  `user_country_city_name` varchar(60) NOT NULL,
  `user_search_pref` varchar(25) NOT NULL,
  `user_birthday` char(11) NOT NULL,
  `user_privacy` text NOT NULL,
  `user_status` varchar(200) NOT NULL,
  `user_audio` int(11) NOT NULL,
  `user_last_visit` text NOT NULL,
  `user_photo` varchar(90) NOT NULL,
  `user_delet` int(11) NOT NULL,
  `user_ban` int(11) NOT NULL,
  `user_balance` int(11) NOT NULL,
  `user_wall_num` mediumint(11) NOT NULL,
  `user_notes_num` mediumint(11) NOT NULL,
  `user_videos_num` mediumint(11) NOT NULL,
  `user_wall_id` int(11) NOT NULL,
  `user_pm_num` mediumint(11) NOT NULL,
  `user_ban_date` datetime NOT NULL,
  `user_friends_demands` int(11) NOT NULL,
  `user_support` int(11) NOT NULL,
  `user_lastupdate` int(11) NOT NULL,
  `user_msg_type` int(11) NOT NULL,
  `user_new_mark_photos` int(11) NOT NULL,
  `user_friends_num` mediumint(11) NOT NULL,
  `user_xfields` text NOT NULL,
  `user_xfields_all` text NOT NULL,
  `user_subscriptions_num` mediumint(11) NOT NULL,
  `user_albums_num` mediumint(11) NOT NULL,
  `user_sp` int(11) NOT NULL,
  `user_gifts` int(11) NOT NULL,
  `user_public_num` mediumint(11) NOT NULL,
  `xfields` text NOT NULL,
  `user_doc_num` mediumint(11) NOT NULL,
  `user_fave_num` mediumint(11) NOT NULL,
  `user_blacklist` text NOT NULL,
  `user_blacklist_num` mediumint(11) NOT NULL,
  `all_liked_users` text NOT NULL,
  `user_cover` varchar(255) NOT NULL,
  `user_cover_pos` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `vii_users`
--

INSERT INTO `vii_users` (`user_id`, `user_email`, `user_password`, `user_name`, `user_lastname`, `user_sex`, `user_day`, `user_month`, `user_year`, `user_country`, `user_city`, `user_reg_date`, `user_lastdate`, `user_group`, `user_hid`, `user_country_city_name`, `user_search_pref`, `user_birthday`, `user_privacy`, `user_status`, `user_audio`, `user_last_visit`, `user_photo`, `user_delet`, `user_ban`, `user_balance`, `user_wall_num`, `user_notes_num`, `user_videos_num`, `user_wall_id`, `user_pm_num`, `user_ban_date`, `user_friends_demands`, `user_support`, `user_lastupdate`, `user_msg_type`, `user_new_mark_photos`, `user_friends_num`, `user_xfields`, `user_xfields_all`, `user_subscriptions_num`, `user_albums_num`, `user_sp`, `user_gifts`, `user_public_num`, `xfields`, `user_doc_num`, `user_fave_num`, `user_blacklist`, `user_blacklist_num`, `all_liked_users`, `user_cover`, `user_cover_pos`) VALUES
(1, 'admin@site.ru', '696d29e0940a4957748fe3fc9efd22a3', 'Администратор', 'Сайта', 0, 0, 0, 0, '0', '0', '1354349191', '1354349191', 1, '696d29e0940a4957748fe3fc9efd22a3499b95eea599df1950b335b8b4e3ea8b', '', 'Администратор Сайта', '0-0-0', 'val_msg|1||val_wall1|1||val_wall2|1||val_wall3|1||val_info|1||', '', 0, '1355663936', '', 0, 0, 2, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, 1355649188, 0, 0, 0, '', '', 0, 0, 0, 0, 0, '', 0, 0, '', 0, '', '', ' 196');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_videos`
--

CREATE TABLE IF NOT EXISTS `vii_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `video` text NOT NULL,
  `comm_num` mediumint(50) NOT NULL,
  `add_date` varchar(50) NOT NULL,
  `views` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `photo_num` mediumint(11) NOT NULL,
  `photo` text NOT NULL,
  `privacy` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vii_videos_comments`
--

CREATE TABLE IF NOT EXISTS `vii_videos_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `add_date` varchar(20) NOT NULL,
  `video_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `vii_videos_comments`
--

INSERT INTO `vii_videos_comments` (`id`, `author_user_id`, `text`, `add_date`, `video_id`, `user_id`) VALUES
(6, 43, 'c dvs sd', '2012-09-30 19:24:54', 12, 0),
(7, 44, 'Тест', '2012-10-01 20:42:33', 13, 0),
(8, 53, '1', '2012-10-11 13:42:12', 14, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_votes`
--

CREATE TABLE IF NOT EXISTS `vii_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `answers` text NOT NULL,
  `answer_num` mediumint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `vii_votes`
--

INSERT INTO `vii_votes` (`id`, `title`, `answers`, `answer_num`) VALUES
(2, '33', 'уу|ууу', 0),
(3, 'ssss', 'sasad|dasda', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `vii_votes_result`
--

CREATE TABLE IF NOT EXISTS `vii_votes_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vote_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `vii_votes_result`
--

INSERT INTO `vii_votes_result` (`id`, `user_id`, `vote_id`, `answer`) VALUES
(1, 53, 3, '0');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_wall`
--

CREATE TABLE IF NOT EXISTS `vii_wall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fast_comm_id` int(11) NOT NULL,
  `fasts_num` int(11) NOT NULL,
  `likes_users` text NOT NULL,
  `author_user_id` int(11) NOT NULL,
  `likes_num` mediumint(11) NOT NULL,
  `add_date` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `tell_uid` int(11) NOT NULL,
  `tell_date` int(11) NOT NULL,
  `public` int(11) NOT NULL,
  `attach` text NOT NULL,
  `for_user_id` int(11) NOT NULL,
  `type` text NOT NULL,
  `tell_comm` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `data` varchar(100) NOT NULL,
  `cnt` int(11) NOT NULL,
  `val_wall` text NOT NULL,
  `check_friend` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

--
-- Дамп данных таблицы `vii_wall`
--

INSERT INTO `vii_wall` (`id`, `fast_comm_id`, `fasts_num`, `likes_users`, `author_user_id`, `likes_num`, `add_date`, `text`, `tell_uid`, `tell_date`, `public`, `attach`, `for_user_id`, `type`, `tell_comm`, `user_id`, `data`, `cnt`, `val_wall`, `check_friend`) VALUES
(5, 0, 0, '', 47, 0, '1349191964', 'dd', 0, 0, 0, '', 48, '', '0', 0, '', 0, '', ''),
(6, 0, 0, '', 47, 0, '1349288061', '', 0, 0, 0, 'hack|start||vote|2||', 47, '', '0', 0, '', 0, '', ''),
(7, 0, 0, '', 49, 0, '1349347564', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''49'', ''0183fbc5fad2fe9.jpg''); return false"><img src="/uploads/users/49/o_0183fbc5fad2fe9.jpg" style="margin-top:3px"></a></div>', 0, 0, 0, '', 49, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(8, 0, 0, '', 49, 0, '1349347573', 'хай', 0, 0, 0, '', 49, '', '0', 0, '', 0, '', ''),
(9, 0, 0, '', 50, 0, '1349354238', 'sa', 0, 0, 0, '', 50, '', '0', 0, '', 0, '', ''),
(10, 0, 0, '', 51, 0, '1349361965', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''51'', ''b41fcbb4b3defd1.png''); return false"><img src="/uploads/users/51/o_b41fcbb4b3defd1.png" style="margin-top:3px"></a></div>', 0, 0, 0, '', 51, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(12, 0, 0, '', 53, 0, '1349954099', '', 20, 1349954066, 1, 'audio|5||audio|6||audio|6||', 53, '', '0', 0, '', 0, '', ''),
(13, 0, 0, '', 53, 0, '1349954102', 'тра', 20, 1349954042, 1, '', 53, '', '0', 0, '', 0, '', ''),
(14, 0, 0, '', 53, 0, '1349954107', 'dvdv', 20, 1349888255, 1, '', 53, '', '0', 0, '', 0, '', ''),
(15, 0, 1, '|u53|', 55, 1, '1349954422', 'dvdv', 20, 1349888255, 1, '', 55, '', '0', 0, '', 0, '', ''),
(16, 0, 0, '', 55, 0, '1349954423', 'тра', 20, 1349954042, 1, '', 55, '', '0', 0, '', 0, '', ''),
(17, 0, 0, '|u53|', 55, 1, '1349954425', '', 20, 1349954066, 1, 'audio|5||audio|6||audio|6||', 55, '', '0', 0, '', 0, '', ''),
(18, 0, 1, '|u53|', 55, 1, '1349954700', 'v v', 0, 0, 0, '', 55, '', '0', 0, '', 0, '', ''),
(19, 0, 0, '', 55, 0, '1349954865', 'nhgng', 0, 0, 0, '', 53, '', '0', 0, '', 0, '', ''),
(20, 0, 0, '', 53, 0, '1349956293', '', 0, 0, 0, 'smile|8.gif||', 53, '', '0', 0, '', 0, '', ''),
(21, 0, 1, '', 56, 0, '1349973486', 'j', 0, 0, 0, '', 56, '', '0', 0, '', 0, '', ''),
(23, 0, 1, '|u53|', 56, 1, '1349973501', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''56'', ''c5daf549023972e.jpg''); return false"><img src="/uploads/users/56/o_c5daf549023972e.jpg" style="margin-top:3px"></a></div>', 0, 0, 0, '', 56, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(25, 23, 0, '', 53, 0, '1349973706', 'в', 0, 0, 0, '', 56, '', '0', 0, '', 0, '', ''),
(26, 21, 0, '', 53, 0, '1349973722', 'в', 0, 0, 0, '', 56, '', '0', 0, '', 0, '', ''),
(27, 18, 0, '', 53, 0, '1349973726', 'в', 0, 0, 0, '', 55, '', '0', 0, '', 0, '', ''),
(28, 15, 0, '', 53, 0, '1349973744', 'в', 0, 0, 0, '', 55, '', '0', 0, '', 0, '', ''),
(29, 0, 0, '', 53, 0, '1349973785', 'свясяс', 0, 0, 0, '', 56, '', '0', 0, '', 0, '', ''),
(30, 0, 0, '', 53, 0, '1349973875', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''56'', ''c5daf549023972e.jpg''); return false"><img src="/uploads/users/56/o_c5daf549023972e.jpg" style="margin-top:3px"></a></div>', 56, 1349973501, 0, '', 53, '', '0', 0, '', 0, '', ''),
(31, 0, 1, '|u53|', 56, 1, '1349973974', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''56'', ''90a8736a45457bf.jpg''); return false"><img src="/uploads/users/56/o_90a8736a45457bf.jpg" style="margin-top:3px"></a></div>', 0, 0, 0, '', 56, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(32, 31, 0, '', 53, 0, '1349974082', 'чы', 0, 0, 0, '', 56, '', '0', 0, '', 0, '', ''),
(33, 0, 0, '', 56, 0, '1349974097', '', 0, 0, 0, 'smile|27.gif||', 56, '', '0', 0, '', 0, '', ''),
(34, 0, 0, '|u53|', 55, 1, '1350020951', '', 0, 0, 0, 'hack|start||vote|3||', 55, '', '0', 0, '', 0, '', ''),
(35, 0, 0, '', 53, 0, '1350021153', '', 0, 0, 0, 'audio|7||', 53, '', '0', 0, '', 0, '', ''),
(36, 0, 0, '|u55|', 53, 1, '1350021170', '', 0, 0, 0, 'video|d43aee095de1354.jpg|14|53||', 53, '', '0', 0, '', 0, '', ''),
(37, 0, 2, '|u53|', 55, 1, '1350021205', '', 0, 0, 0, 'photo_u|attach|ae3de53b2ae6d185f99c.gif||', 55, '', '0', 0, '', 0, '', ''),
(38, 37, 0, '', 53, 0, '1350021215', 'bfb', 0, 0, 0, '', 55, '', '0', 0, '', 0, '', ''),
(39, 0, 0, '', 57, 0, '1350021509', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''57'', ''f1f1641ae105362.jpg''); return false"><img src="/uploads/users/57/o_f1f1641ae105362.jpg" style="margin-top:3px"></a></div>', 0, 0, 0, '', 57, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(40, 0, 0, '', 53, 0, '1350022017', 'Скоро закрою сайт!', 0, 0, 0, '', 53, '', '0', 0, '', 0, '', ''),
(41, 0, 0, '', 53, 0, '1350044304', '', 0, 0, 0, 'photo_u|attach|a4a459ef5a5c05c092d5.jpg||', 53, '', '0', 0, '', 0, '', ''),
(42, 37, 0, '', 53, 0, '1350044529', 'sd', 0, 0, 0, '', 55, '', '0', 0, '', 0, '', ''),
(43, 0, 0, '', 53, 0, '1350047466', '<div class="profile_update_photo"><a href="" onClick="Photo.Profile(''53'', ''e9832e9058a4e07.jpg''); return false"><img src="/uploads/users/53/o_e9832e9058a4e07.jpg" style="margin-top:3px"></a></div>', 0, 0, 0, '', 53, 'обновил фотографию на странице:', '0', 0, '', 0, '', ''),
(44, 0, 0, '', 53, 0, '1350047610', 'vfd', 0, 0, 0, '', 53, '', '0', 0, '', 0, '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `vii_wall_like`
--

CREATE TABLE IF NOT EXISTS `vii_wall_like` (
  `rec_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `vii_wall_like`
--

INSERT INTO `vii_wall_like` (`rec_id`, `user_id`, `date`) VALUES
(15, 53, '1349955121'),
(17, 53, '1349955118'),
(18, 53, '1349960590'),
(23, 53, '1349973701'),
(31, 53, '1349974085'),
(34, 53, '1350020993'),
(36, 55, '1350021178'),
(37, 53, '1350021211');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
