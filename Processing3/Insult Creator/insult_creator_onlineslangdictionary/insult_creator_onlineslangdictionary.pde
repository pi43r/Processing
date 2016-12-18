import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
Timer timer;
int w;
int w2;
int faceX, faceY;
boolean timerStarted = false;

//Insults
String[]arraySubject = {
 "10-4","304","404","40-watt club","5150","5ux0r","abbreviated piece of nothing","accident","acid freak","acid head","a face that only a mother could love","a few cans short of a six pack","ahole","airhead","almy","Amazon","anal retentive","anorak","antwacky","arse","arsehole","arsewipe","as much use as a chocolate fireguard","as much use as a chocolate teapot","as much use as a handbrake on a canoe","a snore","ass","asscan","ass-can","assclown","ass clown","ass-end of space","ass face","ass fuck","assful","asshole","assholery","ass-kisser","ass monkey","ass munch","ass up","ass-wipe","ate up","ate up with the dumb ass","attention whore","b","b4k4","baby","back 40","bad-ass","bad guy","bad news","bad seed","badussy","bag","bag bitch","bagger","bag of shit","bait","bait out","bamma","bananas","bang","banged up","bang hole","barf","Barney","basket case","bastard","bat fastard","batty","beast","beastly","beat","beater","beat-up","beat with the ugly stick","Becky","beep face","beeyatch","beyotch","BFD","BFE","B.G.","bia","biatch","bible thumper","biddy","big deal","big whoop","billy","bimbo","bint","biotch","bird","bird-brain","bisnitch","bisnotch","bitch","bitch ass","bite","bite it","bite me","bite my ass","bite the pillow","bizatch","biznatch","biznitch","bizo","bizzo","blabbermouth","blah","blank-stick","blech","bloatware","blonde","blood","blow","blow chunks","blow me","bludger","blue-hair","bobo","boed","bof","BOFH","bogus","bollocks","bomb","bonehead","boner","bonkers","boob","booby","booey","BOOF","boojee","bookworm","boondocks","boonies, the","boop, leave a message","booshi","boot","boot-leg","bootlicker","boots","booty","bore shitless","bore stiff","bottom feeder","bourgee","box of rocks","bozo","brainiac","breezy","brew","brick","bridezilla","broke","brown-noser","brutal","brutes","buck","buckled","buckshot","budissy","buff","buffalo","buffoon","bugaboo","bugger","bugly","bullshit","bull shit","bull stuff","bum","bum around","Bumblefuck","bumfuck","Bum Fuck, Egypt","bumlick","bump","bumpkin","bum rap","bun","bunk","buns","'burbs, the","burned","burned out","burner","burnout","burn-out","bush league","bushpig","bust","busted","busted-ass","butt","butterface","butter face","butterhead","butters","Butt-Fuck, Egypt","Butt-Fucking, Egypt","butt-fugly","butt-head","butt hugger","butt-munch","butt plug","butt ugly","Cairo","cake","call girl","camper","candy-ass","candy-assed","Captain Whiskey Dick","cathouse","celebutard","certifiable","chach","chank","chap","cheese nug","cherries","chew","chicken","chicken head","chicken hoe","chicken-shit","chillbilly","chincy","chintzy","choad","chochie","chode","chode monster","chode muffin","chooch","choot","chowder head","chronic lag","chucklehead","chump","CI","clean","clod","clone","cock","cockbag","cock knocker","cock-roach","cocksucker","codger","coke whore","commie","cool guy McGee","coot","cooter","cottage","couch potato","cougar","cow","coxo","coyote","coyote ugly","crackass","crack baby","cracked out","crack head","cra-cra","crank","crank whore","crap","crap-fest","crappy","craptacular","craptastic","cray","cray-cray","crazier than a run-over dog","crazier than a shit-house rat","craziness","crazy-pants","creep","creeper","creepy","cretin","crew","crim","Criminole","crockadillapig","cronk","crotch fruit","crumb bum","crummy","crunchy","crunk","cuckoo","cuckoo for Cocoa Puffs","culture vulture","cum dumpster","cunt","cuntbag","cunt grabber","cunt head","cunt hole","cunt licker","cuntosaurus","cuntsicle","'c' word","damaged goods","DAN","date","d bag","DBI","DD","dead","dead rubber","Debbie Downer","Deliveranceville","derf","desk monkey","devil, the","dick","dick face","dickhead","dick lick","dick smack","dick sucker","dick wad","dildo","dill hole","dill weed","dim","dimp","dimwit","ding-a-ling","dingbat","ding-head","dingus","dink","dipshit","dipstick","dirt","dirtwad","dirty","ditz","div","dodgy","dodo","doe","dog","dog-faced","doiche","doink","dolt","do my head","dong","donkey-faced","doofus","doorknocker","doosh","dope","dope fiend","dope monger","doper","dope whore","dork","dork breath","dork slap","dosser","do the pooch","double-bagger","double R","doubly purdy","douche","douche b","douche bag","douche canoe","douche dick","douche nozzle","doucher","DP","drag","drainer","drongo","drop dead","drop in the bucket","dropkick","druggie","duck","Dullsville","dumbass","dumb-ass","dumb bunny","dumbfuck","dumb-fuck","dumb-head","dump","dump truck","durge","dweeb","EAD","East Bumblefuck","East Butt-fuck","East Nowhere","eat a bitch","eat a dick","eat it","eat me","eat my shorts","eat shit","eat shit and die","eejit","eff off","egghead","Egypt","ent","escort","e-tard","e-tarded","eye broccoli","face like a workman's bench","fag","faggot","fail","fake","false","fanboi","fanboy","fanny","farging icehole","far out","fart","fart face","fartknocker","fart-knocker","fatal attraction","fecker","fence","feral","fidiot","FILF","fish","flid","flipper","FLK","floozie","floozy","fluck a duck","fluff","flyover country","FOAD","focker","fool","FOP","freak","freaking","freaky","freaky-deaky","fried","FRO","from hunger","fruitcake","FU","FUBAR","fubugly","fuck","fuck-bitch","fuckbunny","fucked up","fucker","fuck face","fuckhead","fuck head","fucking","fuck nigga","fucknut","fuck nut","fucko","fuck off","fuck (one's self)","fucksqueek","fuck stain","fuck stick","fucktard","fuck up","fuckward","fuckwit","fuckwitt","fuck yo mama","fug","fugazi","fugly","FUGMO","funk","funkdafied","funky","funky monkey","fun sponge","futhermucker","g","gang banger","gangstar","garden tool","gay","geek","geek chic","geek monster","get a life","get bent","get stuffed","get to fuck","GFE","GFY","GFYS","ghettified","ghetto","ghetto bird","gigolo","gimp","girlfriend experience","girly-girl","git","give the skeeves","give the wiggins","gnarly","gobshite","go fly a kite","go fuck a","go fuck (one's self)","go fuck on (one's self)","go jerk yourself","go make me a sandwich","gomer","goober","gooberhead","goocher","good from afar, far from good","good from afar; far from good","good ol' boy","good old boy","goon","go pear-shaped","gorby","gorp","gotard","go to hell","granola","grasshopper","griefer","grit","gritter","grizzly chicken","grody","grommet","gronk","grub","Guam","gumby","gump","gutter punk","hack","hacked up","hackish","hairbag","half-ass","hard on the eyes","has-been","hater","have a face fit for radio","have a face like a bag of hammers","have a screw loose","hayseed","head","head case","heinous","hellacious","herb","hick","hillbilly","himbo","hit","hit up from the chin up","hit with an ugly stick","ho","hockey whore","hodger","hoe","hoebag","hoe stroll","hogley","hog-wild","hole digger","home boy","Homer","homo thug","ho-nasty","hooch","hoochie","hood","hook","hooked","hooker","hoopty","hoover","hop-head","horndog","horse shit","horse's petute","hose beast","hoser","hoss","hotbox","hugly","humdrum","hump","hurt","hussy","huzzie","hype","hyphy","icky","ID10T","ID-10-T","idjet","ijit","in my face","insane in the membrane","jabroni","jabronie","jack","jackass","jacked up","jackhole","jack hole","jack off","jackpine savage","jackwagon","jack wagon","jag-off","jag-wagon","jank","JB","j-cat","jecka","Jenny McCarthy","jerk","jerk-ass","jerk-face","jerk-nut","jerk off","jerkwad","jobber","John","jork","jughead","jumpoff","jump the shark","junkie","junky","Keep digging, Watson.","kicking","kid","kiddie","kiddie stroll","kife","kiss your ass","klink","knob","knobhead","know-it-all","knuckle dragger","knucklehead","knuckle-nuts","kook","kooky","kutta","lame","lame-ass","lame-o","lame sauce","larry","lazy dog","leafy","leebo","lemon","lencho","libtard","lick it","lick my froth","lick my scroat","lick my clit","like ass","like ass pie","like death warmed over","like watching paint dry","limpdick","limp dick","llama","LMP","loaf","loaf about","loaf around","loc","LOLITA","loon","loony","looper","loopy","loose","lot lizard","loud","louse","lunchin'","lunkhead","lurker","mack daddy","mad","madame","mad as a hatter","madcap","mad hatter","mad whack","mafugly","mahfugly","mangy","mank","man-slut","manster","manwhore","Mary","melon","Melv","Melvin","merked","mess","messed","messed up","Mickey Mouse","middle of nowhere, the","MILF","mimbo","minger","mob","mofo","mo fo","mofugly","mole","momo","Mona Bushpig","mondo bizarro","monet","monster","moron","mothafucka","mother fucker","mother trucker","motor-mouth","mouth breather","mud duck","mudpout","mugly","mule head","munchkin","mundane","muppet","mushroom","MWF","naff","nappy","nas","nastafied","nasty","NAUF","neck","neckbeard","need a check up from the neck up","nerd","nerdcore","nerdery","nerdgasm","nerdulent","nerdy","newb","newbie","nightmare","nimrod","nincompoop","nitwit","NMS","no biggie","noid","non-linear","noob face","not mind safe","nucking futs","nugget","numb nut","numb-nuts","numbskull","nummah","numpt","numptie","numpty","nut","nut job","nuts","nutso","nutter","nuttso","nutty","obeast","off my box","off my nut","off my rocker","off the deep end","off the wall","OG","old bag","old fart","Old Man Jenkins","old timer","Omega Mu","on crack","one fry short of a Happy Meal","my face","my highness","otaku","out of hand","out of my mind","out of the box","out there","out to lunch","over the hill","oxygen thief","pants","pap","paper bag trick","pass around pussy","pay lay","Pebbles","pencildick","penis-face","perma-fried","perp","person of interest","perv","perve","Peter","pickle fucker","pid","piece","piece of shit","pieon","pig","pigeon","PIK","piker","pill","pill popper","pimp","pinhead","pish","piss","piss-ant","pisshead","piss-poor","PITA","pits, the","plank","player hate","player hater","plonker","Poindexter","poon","poophead","poop on you, then.","poo-poo on you","poopy","pop","popcorn hoe","popper","pop slag","poseur","postal","pound sand","prannock","prick tease","pro","prole","proof or STFU","propellerhead","prostitot","psycho","psycho-bitch","psychonaut","puck bunny","pud-whack","pud whacker","pug fugly","puke","pukoid","punk","punter","pussy","pussy-hole","put that in my pipe and smoke it","putz","quack","quart","Quayle","queaf","queef","ram","rassclat","rat","raunch","raunchy","redic","redneck","reechy","reject","religitard","REMF","re-re","rest and vest","retaardvark","retard","retarded","rhino","ridonkulous","rim","rinky-dink","ripper","robot","rot in hell","r-tard","RUB","rubbish","rug-rat","runner","run with the world","sack of shit","sad","Sally","salty","santorum","sausage","sausage fest","sausage jockey","sausage party","scag","scarred","scary","schlong","schlub","schmuck","screw","screw off","screw the badger","screwy","scrote","scrub","scud","scum","scumbag","scum-bucket","scum of the earth","sea donkey","sea hag","seven thirty","shawty","sheep","sheisty","sherlock","shiksa","shill","shit","shit-bag","shitface","shit fucker","shithead","shit out of luck","shits, the","shit stirrer","shitty","shmuck","shorty","shove it","shove it up my ass","shovel-face","shove off","sick","sick fuck","skag","skank","skeeve","skeevy","skeevy ho","skeezy","skeezy ho","sketchy","sketel","skid","sko","slackass","slack-jaw","slack-jawed","slack-jawed lackey","slag","sleazeball","sleep around","slimebag","slimeball","slitch","slob","slore","slub","slumpbuster","slump buster","slunt","slut","slutty","smacktard","small potatoes","smoke crack","smoke my johnson","smoke on that","SNAF","snake","snapperhead","snatch","snitch","snooze","so-and-so","sod","SOL","son of a gun","sons of bitches","sorostitute","spastic","spaz","sped","speed freak","spich","spork","square","stank","STFU","stick","sticks, the","stiff","stig","stink","stinkie cheese","stoner","stooge","stoopid","straight","strange duck","strill","stroll","stu","stuff it","stuffy","stupid","suck","suck a bag of dicks","suck a fat baby's dick","sucka-fu chicken-head","suck at","suck it","suck my dick","suck on that","suck rocks","suck shit","suck so hard","suck that","suck the big one","suck up","sucky","sugar honey ice tea","sux","swamp donkey","swede","sweetie","sword fight","tacky","take a hike","tard","tart","tart monkey","tattle tail","tattle tale","tea bag","technotard","tech weenie","television bum","ten pounds of shit in a five-pound bag","terribad","thanks for nothing","throwed","throwed off","thug","tight-ass","tired","toc","toe","toe up","toilet","toker","tool","toolbox","tore back","tore up","tore up from the floor up","tosser","tough shit","tough titty","tow up","trailer trash","trainwreck","train wreck","tramp","trash","trench coat","trendy loke","trick","trif","trifling","trippy","troglodyte","troll","TUFU","turd","twat","tweaker","tweeker","tween","twerp","twinkie","twisted","twit","twittlefuck","two-bagger","two-bit","two cans short of a six pack","two o'clock beauty queen","ugly","ugly as sin","ugly stick","unbelievabubble","uncle fucker","uncool","up my nose with a rubber hose","Upper Rubber Boot","up yours","USer","vag","varmint","village bicycle, the","viper","vulture capitalist","wackadoodle","wacked","wacked out","wain","wally","wank","wanker","Wanker Town, USA","wanksta","WASPy","wassock","waste","wastoid","wazzock","weak","weenie","weirdo","welch","welfare","wet","wet blanket","whack","whacked","whacked out","whack job","whatever","whipper-snapper","Whiskey Tango","white bread","white trash","whore","whorehouse","whoremonkey","wideo","wigged out","window licker","winner","wipper-snapper","wise guy","woofer","word up to your mother","worked","working girl","write-only code","wuppie","wuss","Xbox","xippie","yahoo","yak","yokel","yo momma","younger model","youngin'","your mamma","your mom","your mom was good last night","yuck","yucky","yutz","zany"
};
void setup() {
  size(displayWidth,displayHeight);
  frameRate(24);
  //textFont(font);
  textSize(16);
  video = new Capture(this,640,480,"USB2.0 Camera");
  //video = new Capture(this,640,480);
  opencv = new OpenCV(this, 640, 480); //Divide by two for better performance
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();

  timer = new Timer(2000);
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  
  //println(faces.length);
  if (faces.length == 0) {
    fill(#FF0000);
    text("Please face the fucking Camera!", 150,30);
    timer.start();
    timerStarted = true;
    if (timer.isFinished()) {
      println("randomized!");
      w = int(random(0, arraySubject.length));
      w2 = int(random(0, arraySubject.length));
      timerStarted = false;
    }
  }
  if (faces.length == 1){
    fill(#FF0000);
    text(arraySubject[w], faces[0].x, faces[0].y + 50);
    }
  if (faces.length == 2){
    fill(#FF0000);
    text(arraySubject[w], faces[0].x, faces[0].y + 50);
    text(arraySubject[w2], faces[1].x, faces[1].y + 50);
    }
  /*
  if (faces.length >= 0) {
    for (int i = 0; i < faces.length; i++) {
      //    println(faces[i].x + "," + faces[i].y);
      //    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

      fill(#FF0000);
      //textAlign(CENTER);
      text(arraySubject[w] + arrayDescriptor[t] + arrayObject[f], faces[i].x, faces[i].y + 50);
      text(arraySubject[w2] + arrayDescriptor[t2] + arrayObject[f2], faces[i].x, faces[i].y + 50);
    }
  } */
  //println(w +"," + t +","+ f);
  //println(faces);
}

void captureEvent(Capture c) {
  c.read();
}

class Timer {
  int savedTime;
  int totalTime;

  Timer (int tempTotalTime) {
    totalTime = tempTotalTime;
  }


  //starting Timer
  void start() {
    if ( timerStarted == false) {
      savedTime = millis();
      timerStarted = true;
      println("timer started");
    }
  }

  boolean isFinished() {
    //Check how much time has passed
    int passedTime = millis() - savedTime;
    println("passed Time: " + passedTime);
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}

