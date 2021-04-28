import java.awt.*;
import processing.sound.*;

SoundFile sample;
Waveform waveform;






// Programa que muestra waveform y dibujos de canciones descargadas.
// Permite cambiar la velocidad y el volumen de reproducción.

// Basado en FractalLand de Sebin Serban
// y en SimplePlayback de Processing Org. 
















Cell[][] oldB, newB;
int levels, old_levels;
float scaleRange, old_scaleRange;
int bandera;
float xb;
float yb;
float width1, height1;
float contador;
float contador2;
float var, var2;


int samples = 200;

void settings() {
  fullScreen(P3D);
  smooth(3);
}

public void setup() {

  surface.setSize(800, 800);
  surface.setResizable(true);
  surface.setLocation(560,140);
  var = 0;
  var2 = 0;
  contador = 0;
  contador2 = 0;
  sample = new SoundFile(this, "PONERNOMBREDEARCHIVOAQUI.wav");
  sample.loop();


  waveform = new Waveform(this, samples);
  waveform.input(sample);
  surface.setTitle("Musica");
  levels = 8;
  scaleRange = 0.12;
  old_levels = levels;
  old_scaleRange = scaleRange;
  bandera=0;
  background(random(255), random(255), random(255));
}

public void draw() {
  contador += 1.85;
  contador2 += 1;
  xb = mouseX;
  yb = mouseY;

  if (contador >= 100) {
    background(random(255), random(255), random(255));
    contador=0;
  }

  
  if (contador2 >= 5) {
    stroke(random(255), random(255), random(255), random(50, 255));
    strokeWeight(3.5);
    noFill();

    float playbackSpeed = map(xb, 0, width, 0.25, 1);
    sample.rate(playbackSpeed);

    float amplitude = map(yb, 0, width, 0.2, 1);
    sample.amp(amplitude);


    waveform.analyze();

    beginShape();
    for (int i = 0; i < samples; i++) {
      vertex(
        map(i, 0, samples, 0, width), 
        map(waveform.data[i], -1, 1, 0, height)
        );
    }
    endShape();
    contador2=0;
  }


  strokeWeight(random(1, 4));
  stroke(random(255), random(255), random(255), 255);
  var = random(width);
  var2 = random(height);
  line(var, var2, var+random(10), var2+random(15));


  strokeWeight(1);
  stroke(random(255), random(255), random(255));
  levels = round( ( xb / 800 ) * 8 );
  scaleRange = yb * 10 / ( 8 * 5 );
  scaleRange = scaleRange / 1000;
  if ((old_levels != levels) || (old_scaleRange != scaleRange))
  {

    int level=0;
    int n=2;
    oldB = new Cell[n][n];
    oldB[0][0] = new Cell(150, 150);
    oldB[0][1] = new Cell(150, 700);
    oldB[1][0] = new Cell(700, 150);
    oldB[1][1] = new Cell(700, 700);

      
    while (level<levels)
    {
      n=2*n-1;
      newB = new Cell[n][n];
      for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++) {
          if (((i%2) == 0) && ((j%2) == 0)) {
            int ii = i/2;
            int jj = j/2;
            newB[i][j] = new Cell(oldB[ii][jj].x, oldB[ii][jj].y);
          } else if (((i%2) == 0) && ((j%2) == 1)) {
            int ii = i/2;
            int jj = (j-1)/2;
            float x=( oldB[ii][jj].x + oldB[ii][jj+1].x ) / 2;
            float y=( oldB[ii][jj].y + oldB[ii][jj+1].y ) / 2;
            float d= sqrt( sq(oldB[ii][jj].x - oldB[ii][jj+1].x) + sq(oldB[ii][jj].y - oldB[ii][jj+1].y) );
            float rng = d*scaleRange;
            float xu = random(-rng, rng);
            float yu = random(-rng, rng);
            newB[i][j] = new Cell(x+xu, y+yu);
          } else if (((i%2) == 1) && ((j%2) == 0)) {
            int ii = (i-1)/2;
            int jj = j/2;
            float x=( oldB[ii][jj].x + oldB[ii+1][jj].x ) / 2;
            float y=( oldB[ii][jj].y + oldB[ii+1][jj].y ) / 2;
            float d= sqrt( sq(oldB[ii][jj].x - oldB[ii+1][jj].x) + sq(oldB[ii][jj].y - oldB[ii+1][jj].y) );
            float rng = d*scaleRange;
            float xu = random(-rng, rng);
            float yu = random(-rng, rng);
            newB[i][j] = new Cell(x+xu, y+yu);
          } else if (((i%2) == 1) && ((j%2) == 1)) {
            int ii = (i-1)/2;
            int jj = (j-1)/2;
            float x=( oldB[ii][jj].x + oldB[ii+1][jj+1].x ) / 2;
            float y=( oldB[ii][jj].y + oldB[ii+1][jj+1].y ) / 2;
            float d= sqrt( sq(oldB[ii][jj].x - oldB[ii+1][jj+1].x) + sq(oldB[ii][jj].y - oldB[ii+1][jj+1].y) );
            float rng = d * scaleRange * 0.7;
            float xu = random(-rng, rng);
            float yu = random(-rng, rng);
            newB[i][j] = new Cell(x+xu, y+yu);
          }
        }
      }
      level ++;
      oldB = newB;
    }

    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        if ((i<n-1) && (j<n-1)) {
          line( oldB[i][j].x, oldB[i][j].y, oldB[i][j+1].x, oldB[i][j+1].y);
          line( oldB[i][j].x, oldB[i][j].y, oldB[i+1][j].x, oldB[i+1][j].y);
        } else if ((i == (n-1)) && (j<n-1)) {
          line( oldB[i][j].x, oldB[i][j].y, oldB[i][j+1].x, oldB[i][j+1].y);
        } else if ((i<n-1) && (j == (n-1))) {
          line( oldB[i][j].x, oldB[i][j].y, oldB[i+1][j].x, oldB[i+1][j].y);
        }
      }
    }
    old_levels = levels;
    old_scaleRange = scaleRange;

  }

} 


void keyPressed() {
  background(random(255), random(255), random(255));
}


class Cell {
  float x, y; 

  // Cell Constructor
  Cell(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }
}
