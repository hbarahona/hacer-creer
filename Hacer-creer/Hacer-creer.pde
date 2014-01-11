import de.bezier.data.sql.*;
SQLite db;
String filedb = "prueba01";
// ########################## PRELOAD ##########################
//String filedb="historial";
String regex="[//]*([a-zA-Z0-9]*)[.]*([a-zA-Z0-9]*)[.]+[a-zA-Z0-9]*"; 
String query="SELECT visitsold.url AS fromvisit, substr(urls.url,0,50) AS urls, strftime('%d',date((visits.visit_time-11644473600000000)/1000000,'unixepoch')) AS dia, strftime('%m',date((visits.visit_time-11644473600000000)/1000000,'unixepoch')) AS mes, CASE(visits.transition & 255) WHEN 0 THEN '1' WHEN 1 THEN '0' WHEN 2 THEN '2' WHEN 3 THEN '3' WHEN 4 THEN '1' WHEN 5 THEN '2' WHEN 6 THEN '2' WHEN 7 THEN '3' WHEN 8 THEN '2' WHEN 9 THEN '2' WHEN 10 THEN '2' END AS transition FROM urls, visits LEFT OUTER JOIN (SELECT visits.id, urls.url FROM visits, urls WHERE urls.id=visits.url) AS visitsold ON visits.from_visit=visitsold.id WHERE urls.id=visits.url AND urls.url NOT LIKE '%file:%' AND  urls.url NOT LIKE '%chrome-extension:%' AND mes > strftime('%m',date('now'), '-03 months') ";

StringList topSitios=new StringList(); //NOMBRE DE LOS 10 PRIMEROS URLS

StringList segmentsNoLimpios = new StringList();         //Guarda los datos de la BD}
StringList segments = new StringList();        //Guarda los segments limpios

StringList urlsNoLimpios = new StringList();
StringList url = new StringList();
StringList urlComparar = new StringList();

StringList fromVisitNoLimpios = new StringList();
StringList fromVisit = new StringList();

IntList visitas = new IntList();                //Contiene las visitas
IntList dia = new IntList();
IntList mes  = new IntList();
IntList transition  = new IntList();
IntList visitsId = new IntList();

int ene, mar, may, jul, ago, oct, dic=31;
int feb=28;
int abr, jun, sep, nov=30;
//  31 ene   28 febr  31 mar  30 abril  31 mayo  30 jun  
//  31 jul  31 agos  30 sept  31 oct 30 nov  31 dic

int[][] visitasMes1 = new int[10][oct];
int[][] visitasMes2 = new int[10][nov];
int[][] visitasMes3 = new int[10][dic];

int[][] transitionMes1 = new int[10][4];
int[][] transitionMes2 = new int[10][4];
int[][] transitionMes3 = new int[10][4];

int[][] fromVisitTotales =new int [10][11];

int[][] transitionSitio1=new int[3][4];
int[][] transitionSitio2=new int[3][4];
int[][] transitionSitio3=new int[3][4];
int[][] transitionSitio4=new int[3][4];
int[][] transitionSitio5=new int[3][4];
int[][] transitionSitio6=new int[3][4];
int[][] transitionSitio7=new int[3][4];
int[][] transitionSitio8=new int[3][4];
int[][] transitionSitio9=new int[3][4];
int[][] transitionSitio10=new int[3][4];


//PANTALLA 0******************************************************
int cantidad = 300;
float tamNodo = 5;

//PANTALLA 1******************************************************
int max_visitas;
int max_visit_mes;
//Tamaño del grafico (radio)
int tamano = 280;
//Ubicacion del grafico
int offx = 683+0;
int offy = 340+25;


//COLORES
//color color1 = color(0, 255, 190);
color color1 = color(0, 145, 166);
color color2 = color(50, 195, 216);
color color3 = color(250, 130, 0);
//COLORES GRAFICO
color colorFigFondo = color (0, 255, 0);
/*color[] = colorFigFondo = {(0, 255, 0),}; 
color cPrimero = color(0, 255, 0);
color cSegundo = color(0, 225, 0);
color cTercero = color(0, 200, 0);
color cCuarto = color(0, 175, 0);
color cQuinto = color(0, 150, 0);
color cSexto = color(0, 125, 0);
color cSeptimo = color(0, 100, 0);
color cOctavo = color(0, 75, 0);
color cNoveno = color(0, 50, 0);
color cDecimo = color(0, 25, 0);*/

//Tiempo de animaciones
float anim_entrar = 1;
float anim_salir = .5;
float anim_rapido = .2;

//PANTALLA 2******************************************************

//Tamaño gráfico chico
int tamgc = 140;
int margen = 10;
//Tamaño gráfico grande
int tamgg = 500;
int margengg = 15;
int espaciado_vertical = 15;

//PANTALLA 3******************************************************
int ancho_to = 90;
int ancho_from = 99;
color[] to_bg = new int[11];

int a3_posx=0;

//PANTALLA 4******************************************************
int a4_margen = 5;
float sizex = 0;
int sizey = 0;
float a4_x = 450;
float anim_chile=25;
float a4_mundo_x = 450;
float anim_mundo=25;
int a4_y = 25;
float mundo_op = 0;
//VARIABLES
String[] chile= {
  "google.cl", "facebook.com", "youtube.com", "live.com", "yahoo.com", "twitter.com", "wikipedia.org", "blogspot.com", "emol.com", "linkedin.com", "lun.com", "mercadolibre.cl", "latercera.cl", "biobiochile.cl", "tumblr.com", "falabella.com", "amazon.com", "bancoestado.cl", "wordpress.com", "terra.cl", "xvideos.com", "taringa.net", "instagram.com", "jaidefinichon.com", "bancochile.cl", "yapo.cl", "cooperativa.cl", "theclinic.cl", "eazel.com", "neobux.com", "santander.cl", "elmercurio.com", "gov.cl", "lan.com", "sii.cl", "bci.cl", "pinterest.com", "portalinmobiliario.com", "msn.com", "pcfactory.cl", "ask.fm", "nic.cl", "vube.com", "portalnet.cl", "ebay.com", "ask.com", "paris.cl", "sodimac.cl", "apple.com", "flickr.com", "elmostrador.cl", "ripley.cl", "wordreference.com", "stackoverflow.com", "lacuarta.com", "chileautos.cl", "microsoft.com", "transbank.cl", "entel.cl", "economicos.cl", "soychile.cl", "adf.ly", "aliexpress.com", "13.cl", "groupon.cl", "akamaihd.net", "paypal.com", "vimeo.com", "olx.cl", "softonic.com", "movistar.cl", "24horas.cl", "iminent.com", "bing.com", "fayerwayer.com", "thepiratebay.sx", "servipag.com", "eldinamo.cl", "correos.cl", "wordpress.org", "blogger.com", "pornhub.com", "alibaba.com", "imdb.com", "plp.cl", "hootsuite.com", "dafiti.cl", "dropbox.com", "adobe.com", "trovit.cl", "publimetro.cl", "adcash.com", "imgur.com", "slideshare.net", "eldefinido.cl", "marca.com", "lasegunda.com", "glamorama.cl", "uc.cl", "n-mobile.net", "snapdo.com", "badoo.com", "forobeta.com", "guioteca.com", "netflix.com"
};
String[] chileLimpio= {
  "google", "facebook", "youtube", "live", "yahoo", "twitter", "wikipedia", "blogspot", "emol", "linkedin", "lun", "mercadolibre", "latercera", "biobiochile", "tumblr", "falabella", "amazon", "bancoestado", "wordpress", "terra", "xvideos.com", "taringa", "instagram", "jaidefinichon", "bancochile", "yapo", "cooperativa", "theclinic", "eazel", "neobux", "santander", "elmercurio", "gov", "lan", "sii", "bci", "pinterest", "portalinmobiliario", "msn", "pcfactory", "ask", "nic", "vube", "portalnet", "ebay", "ask", "paris", "sodimac", "apple", "flickr", "elmostrador", "ripley", "wordreference", "stackoverflow", "lacuarta", "chileautos", "microsoft", "transbank", "entel", "economicos", "soychile", "adf", "aliexpress", "13", "groupon", "akamaihd", "paypal", "vimeo", "olx", "softonic", "movistar", "24horas", "iminent", "bing", "fayerwayer", "thepiratebay", "servipag", "eldinamo", "correos", "wordpress", "blogger", "pornhub", "alibaba", "imdb", "plp", "hootsuite", "dafiti", "dropbox", "adobe", "trovit", "publimetro", "adcash", "imgur", "slideshare", "eldefinido", "marca", "lasegunda", "glamorama", "uc", "n-mobile", "snapdo", "badoo", "forobeta", "guioteca", "netflix"
};
String[] seg_prueba = {
  "biobiochile.cl", "tumblr.com", "falabella.com", "amazon.com", "bancoestado.cl", "wordpress.com", "terra.cl", "xvideos.com", "bci.cl", "imgur.com", "slideshare.net", "akamaihd.net", "paypal.com", "vimeo.com"
};
String[] seg_prueba2 = {
  "biobiochile.cl", "tumblr.com", "falabella.com", "amazon.com", "bancoestado.cl", "wordpress.com", "terra.cl", "xvideos.com", "bci.cl", "imgur.com", "slideshare.net", "akamaihd.net", "paypal.com", "vimeo.com"
};

String[] mundo= {
  "google.com", "facebook.com", "youtube.com", "yahoo.com", "baidu.com", "wikipedia.org", "qq.com", "amazon.com", "taobao.com", "live.com", "twitter.com", "linkedin.com", "sina.com.cn", "blogspot.com", "hao123.com", "163.com", "weibo.com", "ebay.com", "wordpress.com", "yandex.ru", "bing.com", "vk.com", "360.cn", "tmall.com", "sohu.com", "tumblr.com", "pinterest.com", "soso.com", "msn.com", "ask.com", "mail.ru", "paypal.com", "microsoft.com", "instagram.com", "apple.com", "xvideos.com", "ifeng.com", "imdb.com", "craigslist.org", "blogger.com", "xhamster.com", "bbc.co.uk", "go.com", "stackoverflow.com", "neobux.com", "alibaba.com", "adobe.com", "fc2.com", "imgur.com", "people.com.cn", "cnn.com", "akamaihd.net", "huffingtonpost.com", "xinhuanet.com", "vube.com", "alipay.com", "odnoklassniki.ru", "conduit.com", "flickr.com", "reddit.com", "espn.go.com", "gmw.cn", "pornhub.com", "aliexpress.com", "youku.com", "about.com", "rakuten.co.jp", "adcash.com", "godaddy.com", "ku6.com", "dailymotion.com", "netflix.com", "cnet.com", "dailymail.co.uk", "vimeo.com", "thepiratebay.sx", "kickass.to", "sogou.com", "walmart.com", "redtube.com", "indiatimes.com", "uol.com.br", "xnxx.com", "youporn.com", "aol.com", "themeforest.net", "livejasmin.com", "weather.com", "dropbox.com", "slideshare.net", "adf.ly", "directrev.com", "nytimes.com", "pixnet.net", "etsy.com", "globo.com", "mozilla.org", "secureserver.net", "wikimedia.org", "fiverr.com", "ameblo.jp", "deviantart.com", "hootsuite.com", "wikia.com", "blogfa.com",
};
String[] mundoLimpio= {
  "google", "facebook", "youtube", "yahoo", "baidu", "wikipedia", "qq", "amazon", "taobao", "live", "twitter", "linkedin", "sina", "blogspot", "hao123", "163", "weibo", "ebay", "wordpress", "yandex", "bing", "vk", "360", "tmall", "sohu", "tumblr", "pinterest", "soso", "msn", "ask", "mail", "paypal", "microsoft", "instagram", "apple", "xvideos", "ifeng", "imdb", "craigslist", "blogger", "xhamster", "bbc.co.uk", "go", "stackoverflow", "neobux", "alibaba", "adobe", "fc2", "imgur", "people", "cnn", "akamaihd.net", "huffingtonpost", "xinhuanet", "vube", "alipay", "odnoklassniki", "conduit", "flickr", "reddit", "espn", "gmw", "pornhub", "aliexpress", "youku", "about", "rakuten", "adcash", "godaddy", "ku6", "dailymotion", "netflix", "cnet", "dailymail", "vimeo", "thepiratebay", "kickass.to", "sogou", "walmart", "redtube", "indiatimes", "uol", "xnxx", "youporn", "aol", "themeforest", "livejasmin", "weather", "dropbox", "slideshare", "adf", "directrev", "nytimes", "pixnet", "etsy", "globo", "mozilla", "secureserver", "wikimedia", "fiverr", "ameblo", "deviantart", "hootsuite", "wikia", "blogfa",
};

