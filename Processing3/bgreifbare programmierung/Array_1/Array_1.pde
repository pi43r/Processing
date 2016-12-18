int[] okPasswords;
int enteredPassword;


void setup()    
{

size(300,200);
//noLoop();
//---------------------------------------------------
//our entered password is:
//enteredPassword = mouseX;
//---------------------------------------------------
//creating the okPasswords array with the length of 2
okPasswords = new int[2];
okPasswords[0] = 120;
okPasswords[1] = 200;


}



void draw()
{
 int laenge = okPasswords.length;
  
background(0);
enteredPassword = mouseX;
/*if(enteredPassword == okPasswords[0]){
 background(255,0,0);
 println("your password is ok");  
 text("your password is ok!", 15, 30); 
}
else if(enteredPassword == okPasswords[1]){
 background(255,0,0);
 println("your password is ok");
 text("your password is ok!", 15, 30); 
}*/


for(int i=0; i< laenge; i++){
    if(enteredPassword == okPasswords[i]){
     background(255,0,0);
     println("your password is ok");
     text("your password is ok!", 15, 30);
     break;
     }
  else{
    background(0);
     println("your password " + enteredPassword + " is NOT ok!");
     text("your password " + enteredPassword +  " is NOT ok!", 15, 30); 
     } 
  }
}

