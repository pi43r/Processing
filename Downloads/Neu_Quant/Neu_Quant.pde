/* NeuQuant Neural-Net Quantization Algorithm
 * ------------------------------------------
 *
 * Copyright (c) 1994 Anthony Dekker
 *
 * NEUQUANT Neural-Net quantization algorithm by Anthony Dekker, 1994.
 * See "Kohonen neural networks for optimal colour quantization"
 * in "Network: Computation in Neural Systems" Vol. 5 (1994) pp 351-367.
 * for a discussion of the algorithm.
 * See also  http://www.acm.org/~dekker/NEUQUANT.HTML
 *
 * Any party obtaining a copy of these files from the author, directly or
 * indirectly, is granted, free of charge, a full and unrestricted irrevocable,
 * world-wide, paid up, royalty-free, nonexclusive right and license to deal
 * in this software and documentation files (the "Software"), including without
 * limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons who receive
 * copies from any such party to do so, with the only requirement being
 * that this copyright notice remain intact.
 */
 
 // Adapted for Processing by Mario Klingemann
 // http://www.incubator.quasimondo.com


PImage pic;
NeuQuant nq;

void setup(){
  noStroke();
  pic=loadImage("Paul_Background.jpg");
  size(960,540);
  
}

void loop(){
 int colorCount=max(2,mouseX/4);
  image(pic,0,0);
  nq=new NeuQuant(colorCount,false);
  nq.init();
  
  for (int i=0;i<pixels.length;i++){
    pixels[i]=nq.convert(pixels[i]);
  }
  
  int[] map=nq.getColorMap();
  int sz=width/map.length;
  for (int i=0;i<map.length;i++){
    fill(map[i]);
    rect(i*sz,height-16,(i+1)*sz,height);
  }
}



// Constructors:
//    public NeuQuant (Image im, ImageObserver obs) throws IOException -- default sample = 1
//    public NeuQuant (int sample, Image im, ImageObserver obs) throws IOException
//    public NeuQuant (Image im, int w, int h) throws IOException -- default sample = 1
//    public NeuQuant (int sample, Image im, int w, int h) throws IOException

// Initialisation method: call this first
//    public void init ()

// Methods to look up pixels (use in a loop)
//    public int convert (int pixel)
//    public int lookup (int pixel)
//    public int lookup (Color c)
//    public int lookup (boolean rgb, int x, int g, int y)


// Other methods to interrogate colour map
//    public int getColorCount ()
//    public Color getColor (int i)




 class NeuQuant {
    
   int ncycles  =  128;      // no. of learning cycles

   int netsize;    // number of colours used
   int specials;  // number of reserved colours used
   int cutnetsize;
   int maxnetpos;

   int initrad;   // for 256 cols, radius starts at 32
   int radiusbiasshift = 6;
   int radiusbias = 1 << radiusbiasshift;
   int initBiasRadius;
   int radiusdec = 30; // factor of 1/30 each cycle

   int alphabiasshift = 10;      // alpha starts at 1
   int initalpha      = 1<<alphabiasshift; // biased by 10 bits

   double gamma = 1024.0;
   double beta = 1.0/1024.0;
   double betagamma = beta * gamma;
    
   double [] [] network; // the network itself
   int [] [] colormap; // the network itself
    
   int [] netindex = new int [256]; // for network lookup - really 256
    
   double [] bias;  // bias and freq arrays for learning
   double [] freq;

    // four primes near 500 - assume no image has a length so large
    // that it is divisible by all four primes
   
    int prime1  =  499;
   int prime2  =  491;
   int prime3  =  487;
   int prime4  =  503;
   int maxprime=  prime4;
    
   int samplefac;

   NeuQuant (int colorCount,boolean blackWhite) {
        samplefac = 1;
        
        netsize  = colorCount;    // number of colours used
        if (blackWhite)
            specials  = 2;    // number of reserved colours used
        else
            specials  = 0;    // number of reserved colours used
        cutnetsize  = netsize - specials;
        maxnetpos  = netsize-1;

        initrad   = netsize/8;   // for 256 cols, radius starts at 32
   
        initBiasRadius = initrad*radiusbias;
        
         network = new double [netsize] [3]; // the network itself
         colormap = new int [netsize] [4]; // the network itself
         bias = new double [netsize];  // bias and freq arrays for learning
         freq = new double [netsize];
   
        setUpArrays ();
    }

      
     int getColorCount () {
      return netsize;
    }

    int[] getColorMap (){
      int[] exportMap=new int[netsize];
      for (int i=0;i<netsize;i++){
        exportMap[i]=0xff000000 | colormap[i][2]<<16 | colormap[i][1]<<8 | colormap[i][0];
      }
      return exportMap;
    }

     void setUpArrays () {
      network [0] [0] = 0.0;  // black
      network [0] [1] = 0.0;
      network [0] [2] = 0.0;
      freq [0] = 1.0 / netsize;
      bias [0] = 0.0;
      
      network [1] [0] = 1.0;  // white
      network [1] [1] = 1.0;
      network [1] [2] = 1.0;
      freq [1] = 1.0 / netsize;
      bias [1] = 0.0;

                  // background
      //freq [2] = 1.0 / netsize;
      //bias [2] = 0.0;
      
        for (int i=specials; i<netsize; i++) {
        double [] p = network [i];
        p[0] = (256.0 * (i-specials)) / cutnetsize;
        p[1] = (256.0 * (i-specials)) / cutnetsize;
        p[2] = (256.0 * (i-specials)) / cutnetsize;

        freq[i] = 1.0 / netsize;
        bias[i] = 0.0;
        }
    }      

       
    
    

     void init () {
        learn ();
        fix ();
        inxbuild ();
    }

     void altersingle(double alpha, int i, double b, double g, double r) {
        // Move neuron i towards biased (b,g,r) by factor alpha
        double [] n = network[i];        // alter hit neuron
      n[0] -= (alpha*(n[0] - b));
      n[1] -= (alpha*(n[1] - g));
      n[2] -= (alpha*(n[2] - r));
    }

     void alterneigh(double alpha, int rad, int i, double b, double g, double r) {
        
      int lo = i-rad;   if (lo<specials-1) lo=specials-1;
      int hi = i+rad;   if (hi>netsize) hi=netsize;

      int j = i+1;
      int k = i-1;
      int q = 0;
      while ((j<hi) || (k>lo)) {
          double a = (alpha * (rad*rad - q*q)) / (rad*rad);
          q ++;
        if (j<hi) {
          double [] p = network[j];
          p[0] -= (a*(p[0] - b));
          p[1] -= (a*(p[1] - g));
          p[2] -= (a*(p[2] - r));
          j++;
        }
        if (k>lo) {
          double [] p = network[k];
          p[0] -= (a*(p[0] - b));
          p[1] -= (a*(p[1] - g));
          p[2] -= (a*(p[2] - r));
          k--;
        }
      }
    }
    
     int contest (double b, double g, double r) {    // Search for biased BGR values
      // finds closest neuron (min dist) and updates freq 
      // finds best neuron (min dist-bias) and returns position 
      // for frequently chosen neurons, freq[i] is high and bias[i] is negative 
      // bias[i] = gamma*((1/netsize)-freq[i]) 

      double bestd = Float.MAX_VALUE;
      double bestbiasd = bestd;
      int bestpos = -1;
      int bestbiaspos = bestpos;
        
      for (int i=0; i<netsize; i++) {
        double [] n = network[i];
        double dist = n[0] - b;   if (dist<0) dist = -dist;
        double a = n[1] - g;   if (a<0) a = -a;
        dist += a;
        a = n[2] - r;   if (a<0) a = -a;
        dist += a;
        if (dist<bestd) {bestd=dist; bestpos=i;}
        double biasdist = dist - bias [i];
        if (biasdist<bestbiasd) {bestbiasd=biasdist; bestbiaspos=i;}
        freq [i] -= beta * freq [i];
        bias [i] += betagamma * freq [i];
      }
      freq[bestpos] += beta;
      bias[bestpos] -= betagamma;
      return bestbiaspos;
    }
    
     int specialFind (double b, double g, double r) {
      for (int i=0; i<specials; i++) {
        double [] n = network[i];
        if (n[0] == b && n[1] == g && n[2] == r) return i;
      }
      return -1;
    }
    
     void learn() {
        int biasRadius = initBiasRadius;
      int alphadec = 30 + ((samplefac-1)/3);
      int lengthcount = pixels.length;
      int samplepixels = lengthcount / samplefac;
      int delta = samplepixels / ncycles;
      int alpha = initalpha;

      int i = 0;
      int rad = biasRadius >> radiusbiasshift;
      if (rad <= 1) rad = 0;
  
      //System.err.println("beginning 1D learning: samplepixels=" + samplepixels + "  rad=" + rad);

        int step = 0;
        int pos = 0;
        
      if ((lengthcount%prime1) != 0) step = prime1;
      else {
        if ((lengthcount%prime2) !=0) step = prime2;
        else {
          if ((lengthcount%prime3) !=0) step = prime3;
          else step = prime4;
        }
      }
  
      i = 0;
      while (i < samplepixels) {
          int p = pixels [pos];
          int red   = (p >> 16) & 0xff;
          int green = (p >>  8) & 0xff;
          int blue  = (p      ) & 0xff;

        double b = blue;
        double g = green;
        double r = red;

                /*
        if (i == 0) {   // remember background colour
          network [2] [0] = b;
          network [2] [1] = g;
          network [2] [2] = r;
        }
*/
        int j = specialFind (b, g, r);
        j = j < 0 ? contest (b, g, r) : j;

      if (j >= specials) {   // don't learn for specials
              double a = (1.0 * alpha) / initalpha;
          altersingle (a, j, b, g, r);
          if (rad > 0) alterneigh (a, rad, j, b, g, r);   // alter neighbours
        }

        pos += step;
        while (pos >= lengthcount) pos -= lengthcount;
          
        i++;
        if (i%delta == 0) {  
          alpha -= alpha / alphadec;
          biasRadius -= biasRadius / radiusdec;
          rad = biasRadius >> radiusbiasshift;
          if (rad <= 1) rad = 0;
        }
      }
      //System.err.println("finished 1D learning: final alpha=" + (1.0 * alpha)/initalpha + "!");
    }

     void fix() {
        for (int i=0; i<netsize; i++) {
            for (int j=0; j<3; j++) {
                int x = (int) (0.5 + network[i][j]);
                if (x < 0) x = 0;
                if (x > 255) x = 255;
                colormap[i][j] = x;
            }
            colormap[i][3] = i;
        }
    }

     void inxbuild() {
        // Insertion sort of network and building of netindex[0..255]

      int previouscol = 0;
      int startpos = 0;

      for (int i=0; i<netsize; i++) {
        int[] p = colormap[i];
        int[] q = null;
        int smallpos = i;
        int smallval = p[1];      // index on g
        // find smallest in i..netsize-1
        for (int j=i+1; j<netsize; j++) {
          q = colormap[j];
          if (q[1] < smallval) {    // index on g
            smallpos = j;
            smallval = q[1];  // index on g
          }
        }
        q = colormap[smallpos];
        // swap p (i) and q (smallpos) entries
        if (i != smallpos) {
          int j = q[0];   q[0] = p[0];   p[0] = j;
          j = q[1];   q[1] = p[1];   p[1] = j;
          j = q[2];   q[2] = p[2];   p[2] = j;
          j = q[3];   q[3] = p[3];   p[3] = j;
        }
        // smallval entry is now in position i
        if (smallval != previouscol) {
          netindex[previouscol] = (startpos+i)>>1;
          for (int j=previouscol+1; j<smallval; j++) netindex[j] = i;
          previouscol = smallval;
          startpos = i;
        }
      }
      netindex[previouscol] = (startpos+maxnetpos)>>1;
      for (int j=previouscol+1; j<256; j++) netindex[j] = maxnetpos; // really 256
    }

     int convert (int pixel) {
        int alfa = (pixel >> 24) & 0xff;
      int r   = (pixel >> 16) & 0xff;
      int g = (pixel >>  8) & 0xff;
      int b  = (pixel      ) & 0xff;
      int i = inxsearch(b, g, r);
      int bb = colormap[i][0];
      int gg = colormap[i][1];
      int rr = colormap[i][2];
      return (alfa << 24) | (rr << 16) | (gg << 8) | (bb);
    }

    int lookup (int pixel) {
      int r   = (pixel >> 16) & 0xff;
      int g = (pixel >>  8) & 0xff;
      int b  = (pixel      ) & 0xff;
      int i = inxsearch(b, g, r);
      return i;
    }

    int lookup (boolean rgb, int x, int g, int y) {
      int i = rgb ? inxsearch (y, g, x) : inxsearch (x, g, y);
      return i;
    }

       
     int inxsearch(int b, int g, int r) {
        // Search for BGR values 0..255 and return colour index
      int bestd = 1000;    // biggest possible dist is 256*3
      int best = -1;
      int i = netindex[g];  // index on g
      int j = i-1;    // start at netindex[g] and work outwards

      while ((i<netsize) || (j>=0)) {
        if (i<netsize) {
          int [] p = colormap[i];
          int dist = p[1] - g;    // inx key
          if (dist >= bestd) i = netsize;  // stop iter
          else {
            if (dist<0) dist = -dist;
            int a = p[0] - b;   if (a<0) a = -a;
            dist += a;
            if (dist<bestd) {
              a = p[2] - r;   if (a<0) a = -a;
              dist += a;
              if (dist<bestd) {bestd=dist; best=i;}
            }
            i++;
          }
        }
        if (j>=0) {
          int [] p = colormap[j];
          int dist = g - p[1]; // inx key - reverse dif
          if (dist >= bestd) j = -1; // stop iter
          else {
            if (dist<0) dist = -dist;
            int a = p[0] - b;   if (a<0) a = -a;
            dist += a;
            if (dist<bestd) {
              a = p[2] - r;   if (a<0) a = -a;
              dist += a;
              if (dist<bestd) {bestd=dist; best=j;}
            }
            j--;
          }
        }
      }

      return best;
    }

}