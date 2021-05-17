import controlP5.*;
import processing.sound.*;
import javax.sound.sampled.*;
import java.io.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

ControlP5 cp5;

Minim minim;
AudioInput in;
AudioRecorder recorder;
boolean recorded;
boolean grabando = false;
AudioOutput out;
FilePlayer player;


SoundFile track1;
processing.sound.Waveform onda1;
SoundFile track2;
processing.sound.Waveform onda2;
SoundFile track3;
processing.sound.Waveform onda3;
SoundFile track4;
processing.sound.Waveform onda4;
SoundFile track5;
processing.sound.Waveform onda5;

public int R = int(random(255));
public int G = int(random(255));
public int B = int(random(255));

int time;
int track = 1;

Knob Knob1;
Knob Knob2;
Knob Knob3;
Knob Knob4;
Knob Knob5;

Button Boton1;
Button Boton2;
Button Boton3;
Button Boton4;
Button Boton5;
Button Boton6;
Button Boton7;
Button Boton8;
Button Boton9;
Button Boton10;
Button Boton11;
Button Boton12;

Bang Bang1G;
Bang Bang2G;
Bang Bang3G;
Bang Bang4G;
Bang Bang5G;
Bang Bang1P;
Bang Bang2P;
Bang Bang3P;
Bang Bang4P;
Bang Bang5P;
Bang Bang1C;
Bang Bang2C;
Bang Bang3C;
Bang Bang4C;
Bang Bang5C;
Bang Bang1D;
Bang Bang2D;
Bang Bang3D;
Bang Bang4D;
Bang Bang5D;

Bang trackSelect1;
Bang trackSelect2;
Bang trackSelect3;
Bang trackSelect4;
Bang trackSelect5;


Bang RandomRGB;


int myColorBackground = color(0, 0, 0);
int knobValue = 100;

int samples = 100;

// decoraciones 

int Nmax = 1000 ; 
float M = 50 ; 
float H = 0.99 ; 
float HH = 0.01 ;

float X[] = new float[Nmax+1] ; 
float Y[] = new float[Nmax+1] ; 
float Z[] = new float[Nmax+1] ;
float V[] = new float[Nmax+1] ; 
float dV[] = new float[Nmax+1] ; 
float L ; 
float RR = 2*sqrt((4*PI*(200*200)/Nmax)/(2*sqrt(3))) ;
float Lmin ; 
int N ; 
int NN ; 
float KX ; 
float KY ; 
float KZ ; 
float KV ; 
float KdV ; 
int K ;


float x;
float y;
float easing = 0.7;


int contador_grabacion1 = 1;
int contador_grabacion2 = 2;
int contador_grabacion3 = 3;
int contador_grabacion4 = 4;
int contador_grabacion5 = 5;

// Matriz

Dong[][] d;
int nx = 15;
int ny = 10;
int xx = nx;
int tempXX = xx;
Matrix Matriz;
SoundFile bass1;
SoundFile bass2;
SoundFile hiHat1;
SoundFile hiHat2;
SoundFile hiHat3;
SoundFile snare;
SoundFile snare2;
SoundFile tom1;
SoundFile tom2;
SoundFile tom3;
Slider2D volumenRitmo;
int ritmo;
float volumenP;
Slider bateriaxy;
Textlabel bpm;
int bpmI; // entero que cuenta los bpm





int temp[] = new int[3];

void settings() {
  //fullScreen(P3D);
  smooth();
}

void setup() {


  // linea de audio
  minim = new Minim(this); 
  Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
  printArray(mixerInfo);
  Mixer aaa = AudioSystem.getMixer(mixerInfo[3]); // EL 3 FUNCIONA CHIDONGONGO
  minim.setInputMixer(aaa);

  in = minim.getLineIn();


  //control tamanio de pantalla

  surface.setSize(1600, 770);
  surface.setResizable(true);
  surface.setLocation(160, 140);

  print("hola :)");
  noStroke();


  //samples, tracks y ondas
  track1 = new SoundFile(this, "bass5.mp3");
  onda1 = new processing.sound.Waveform(this, samples);
  onda1.input(track1);
  print("hola track1 ");
  track2 = new SoundFile(this, "bass5.mp3");
  onda2 = new processing.sound.Waveform(this, samples);
  onda2.input(track2);
  print("hola track2 ");
  track3 = new SoundFile(this, "bass5.mp3");
  onda3 = new processing.sound.Waveform(this, samples);
  onda3.input(track3);
  print("hola track3 ");
  track4 = new SoundFile(this, "bass5.mp3");
  onda4 = new processing.sound.Waveform(this, samples);
  onda4.input(track4);
  print("hola track4 ");
  track5 = new SoundFile(this, "bass5.mp3");
  onda5 = new processing.sound.Waveform(this, samples);
  onda5.input(track5);
  print("hola track5 ");

  cp5 = new ControlP5(this);


  // control de fondo de pantalla

  cp5.addSlider("R")
    .setRange(0, 255)
    .setPosition(40, 40)
    .setSize(150, 29);
  cp5.addSlider("G")
    .setRange(0, 255)
    .setPosition(230, 40)
    .setSize(150, 29);
  cp5.addSlider("B")
    .setRange(0, 255)
    .setPosition(420, 40)
    .setSize(150, 29);

  // botones

  Boton1 = cp5.addButton("PlayPausa1")
    .setValue(0)
    .setPosition(60, 250)
    .setSize(80, 40)
    .setLabel("Play/pause")
    ;

  Boton2 = cp5.addButton("PlayPausa2")
    .setValue(0)
    .setPosition(380, 250)
    .setSize(80, 40)
    .setLabel("Play/pause")
    ;

  Boton3 = cp5.addButton("PlayPausa3")
    .setValue(0)
    .setPosition(700, 250)
    .setSize(80, 40)
    .setLabel("Play/pause")
    ;

  Boton4 = cp5.addButton("PlayPausa4")
    .setValue(0)
    .setPosition(1020, 250)
    .setSize(80, 40)
    .setLabel("Play/pause")
    ;

  Boton5 = cp5.addButton("PlayPausa5")
    .setValue(0)
    .setPosition(1340, 250)
    .setSize(80, 40)
    .setLabel("Play/pause")
    ;

  Boton7 = cp5.addButton("loop1")
    .setValue(0)
    .setPosition(180, 250)
    .setSize(80, 40)
    .setLabel("loop")
    ;
  Boton8 = cp5.addButton("loop2")
    .setValue(0)
    .setPosition(500, 250)
    .setSize(80, 40)
    .setLabel("loop")
    ;
  Boton9 = cp5.addButton("loop3")
    .setValue(0)
    .setPosition(820, 250)
    .setSize(80, 40)
    .setLabel("loop")
    ;
  Boton10 = cp5.addButton("loop4")
    .setValue(0)
    .setPosition(1140, 250)
    .setSize(80, 40)
    .setLabel("loop")
    ;
  Boton11 = cp5.addButton("loop5")
    .setValue(0)
    .setPosition(1460, 250)
    .setSize(80, 40)
    .setLabel("loop")
    ;

  Boton6 = cp5.addButton("PlayPausaTotal")
    .setValue(0)
    .setPosition(1140, 200)
    .setSize(400, 40)
    .setLabel("Play/pause Total")
    ;

  Boton12 = cp5.addButton("LoopTotal")
    .setValue(0)
    .setPosition(295, 155)
    .setSize(100, 35)
    .setLabel("Loop Total")
    ;

  // Bangs

  Bang1G = cp5.addBang("Grabar1")
    .setPosition(60, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Grabar")
    .setColorForeground(color(121, 245, 186))
    ;
  Bang2G = cp5.addBang("Grabar2")
    .setPosition(380, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Grabar")
    .setColorForeground(color(121, 245, 186))
    ;
  Bang3G = cp5.addBang("Grabar3")
    .setPosition(690, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Grabar")
    .setColorForeground(color(121, 245, 186))
    ;
  Bang4G = cp5.addBang("Grabar4")
    .setPosition(1020, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Grabar")
    .setColorForeground(color(121, 245, 186))
    ;
  Bang5G = cp5.addBang("Grabar5")
    .setPosition(1340, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Grabar")
    .setColorForeground(color(121, 245, 186))
    ;


  Bang1P = cp5.addBang("Parar1")
    .setPosition(120, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Parar")
    .setColorForeground(color(255, 0, 0))
    ;
  Bang2P = cp5.addBang("Parar2")
    .setPosition(440, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Parar")
    .setColorForeground(color(255, 0, 0))
    ;
  Bang3P = cp5.addBang("Parar3")
    .setPosition(760, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Parar")
    .setColorForeground(color(255, 0, 0))
    ;
  Bang4P = cp5.addBang("Parar4")
    .setPosition(1080, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Parar")
    .setColorForeground(color(255, 0, 0))
    ;
  Bang5P = cp5.addBang("Parar5")
    .setPosition(1400, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Parar")
    .setColorForeground(color(255, 0, 0))
    ;

  Bang1C = cp5.addBang("Cargar1")
    .setPosition(180, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Cargar")
    .setColorForeground(color(106, 126, 255))
    ;
  Bang2C = cp5.addBang("Cargar2")
    .setPosition(500, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Cargar")
    .setColorForeground(color(106, 126, 255))
    ;
  Bang3C = cp5.addBang("Cargar3")
    .setPosition(820, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Cargar")
    .setColorForeground(color(106, 126, 255))
    ;
  Bang4C = cp5.addBang("Cargar4")
    .setPosition(1140, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Cargar")
    .setColorForeground(color(106, 126, 255))
    ;
  Bang5C = cp5.addBang("Cargar5")
    .setPosition(1460, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Cargar")
    .setColorForeground(color(106, 126, 255))
    ;


  Bang1D = cp5.addBang("Otro1")
    .setPosition(240, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Otro")
    .setColorForeground(color(246, 90, 255))
    ;
  Bang2D = cp5.addBang("Otro2")
    .setPosition(560, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Otro")
    .setColorForeground(color(246, 90, 255))
    ;
  Bang3D = cp5.addBang("Otro3")
    .setPosition(880, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Otro")
    .setColorForeground(color(246, 90, 255))
    ;
  Bang4D = cp5.addBang("Otro4")
    .setPosition(1200, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Otro")
    .setColorForeground(color(246, 90, 255))
    ;
  Bang5D = cp5.addBang("Otro5")
    .setPosition(1520, 320)
    .setSize(20, 20)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Otro")
    .setColorForeground(color(246, 90, 255))
    ;

  trackSelect1 = cp5.addBang("trackSelect1")
    .setPosition(55, 155)
    .setSize(35, 35)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Track 1")
    ;
  trackSelect2 = cp5.addBang("trackSelect2")
    .setPosition(100, 155)
    .setSize(35, 35)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Track 2")
    ;
  trackSelect3 = cp5.addBang("trackSelect3")
    .setPosition(145, 155)
    .setSize(35, 35)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Track 3")
    ;
  trackSelect4 = cp5.addBang("trackSelect4")
    .setPosition(190, 155)
    .setSize(35, 35)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Track 4")
    ;
  trackSelect5 = cp5.addBang("trackSelect5")
    .setPosition(235, 155)
    .setSize(35, 35)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("Track 5")
    ;


  RandomRGB = cp5.addBang("RandomRGB")
    .setPosition(640, 40)
    .setSize(29, 29)
    .setTriggerEvent(Bang.RELEASE)
    .setLabel("RandomRGB")
    ;

  // Knob para control

  Knob1 = cp5.addKnob("VOLUMEN TRACK 1")
    .setRange(0, 10)
    .setValue(50)
    .setPosition(60, 400)
    .setRadius(100)
    .setDragDirection(Knob.HORIZONTAL)
    ;
  Knob2 = cp5.addKnob("VOLUMEN TRACK 2")
    .setRange(0, 10)
    .setValue(50)
    .setPosition(380, 400)
    .setRadius(100)
    .setDragDirection(Knob.HORIZONTAL)
    ;
  Knob3 = cp5.addKnob("VOLUMEN TRACK 3")
    .setRange(0, 10)
    .setValue(50)
    .setPosition(699, 400)
    .setRadius(100)
    .setDragDirection(Knob.HORIZONTAL)
    ;
  Knob4 = cp5.addKnob("VOLUMEN TRACK 4")
    .setRange(0, 10)
    .setValue(50)
    .setPosition(1020, 400)
    .setRadius(100)
    .setDragDirection(Knob.HORIZONTAL)
    ;
  Knob5 = cp5.addKnob("VOLUMEN TRACK 5")
    .setRange(0, 10)
    .setValue(50)
    .setPosition(1340, 400)
    .setRadius(100)
    .setDragDirection(Knob.HORIZONTAL)
    ;

  // matriz/ bateria
  Matriz = cp5.addMatrix("matriz")
    .setPosition(1140, 20)
    .setSize(400, 150)
    .setGrid(nx, ny)
    .setGap(10, 3)
    .setInterval(500)
    .setMode(ControlP5.MULTIPLES)
    .setLabel("Ritmo");
  ;

  cp5.getController("matriz").getCaptionLabel().alignX(CENTER);
  d = new Dong[nx][ny]; //nx max = 15
  for (int x = 0; x<nx; x++) {
    for (int y = 0; y<ny; y++) {
      d[x][y] = new Dong();
    }
  } 

  volumenRitmo = cp5.addSlider2D("volumen/ritmo")
    .setPosition(1010, 20)
    .setSize(100, 150)
    .setMinMax(0, 100, 10, 1200)
    .setValue(5, 500)
    //.disableCrosshair()
    ;

  hiHat1 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/hiHat.mp3");
  hiHat2 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/hiHat2.mp3");
  hiHat3 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/hiHatOpen.mp3");
  snare = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/snare.mp3");
  snare2 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/snare2.mp3");
  bass1 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/bassL.wav");
  bass2 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/bass5.mp3");
  tom1 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/drumsticks.mp3");
  tom2 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/China.mp3");
  tom3 = new SoundFile(this, "C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/sounds/crash2.mp3");

  bateriaxy = cp5.addSlider("bateriaxy")
    .setRange(2, 15)
    .setPosition(980, 20)
    .setSize(20, 150)
    .setLabel("x");
  //frameRate(60.1);

  bpm = cp5.addTextlabel("bpm")
    .setText(bpmI +" BPM")
    .setPosition(913, 20)
    .setColorValue(color(255-R, 255-G, 255-B))
    .setFont(createFont("Agency FB", 20))
    ;
  //decoraciones 

  for ( N = 0; N <= Nmax; N++ ) {
    X[N] = random(-300, +300) ;
    Y[N] = random(-300, +300) ;
    Z[N] = random(-300, +300) ;
  }
}


void draw() {

  background(R, G, B);

  //botones
  botones();

  // knobs 

  knobs();


  // samples, tracks y ondas

  samples_tracks_ondas();


  // decoraciones

  decoracion();
  bangsTrack();
  matriz_drums();
}





// TODO KNOBS

void knobs() {
  Knob1.setColorForeground(color(255-R, 255-G, 255-B));
  Knob2.setColorForeground(color(255-R, 255-G, 255-B));
  Knob3.setColorForeground(color(255-R, 255-G, 255-B));
  Knob4.setColorForeground(color(255-R, 255-G, 255-B));
  Knob5.setColorForeground(color(255-R, 255-G, 255-B));


  float amplitud1 = Knob1.getValue()/10;
  track1.amp(amplitud1);

  float amplitud2 = Knob2.getValue()/10;
  track2.amp(amplitud2);

  float amplitud3 = Knob3.getValue()/10;
  track3.amp(amplitud3);

  float amplitud4 = Knob4.getValue()/10;
  track4.amp(amplitud4);

  float amplitud5 = Knob5.getValue()/10;
  track5.amp(amplitud5);
}







// TODO BOTONES

void botones() {
  Boton1.setColorBackground(color(255-R, 255-G, 255-B));
  Boton2.setColorBackground(color(255-R, 255-G, 255-B));
  Boton3.setColorBackground(color(255-R, 255-G, 255-B));
  Boton4.setColorBackground(color(255-R, 255-G, 255-B));
  Boton5.setColorBackground(color(255-R, 255-G, 255-B));
  Boton6.setColorBackground(color(255-R, 255-G, 255-B));
  Boton7.setColorBackground(color(180-R, 180-G, 180-B));
  Boton8.setColorBackground(color(180-R, 180-G, 180-B));
  Boton9.setColorBackground(color(180-R, 180-G, 180-B));
  Boton10.setColorBackground(color(180-R, 180-G, 180-B));
  Boton11.setColorBackground(color(180-R, 180-G, 180-B));
  Boton12.setColorBackground(color(180-R, 180-G, 180-B));
  trackSelect1.setColorForeground(color(255-R, 255-G, 255-B));
  trackSelect2.setColorForeground(color(255-R, 255-G, 255-B));
  trackSelect3.setColorForeground(color(255-R, 255-G, 255-B));
  trackSelect4.setColorForeground(color(255-R, 255-G, 255-B));
  trackSelect5.setColorForeground(color(255-R, 255-G, 255-B));
  Matriz.setBackground(color(R, G, B));
  Matriz.setColorBackground(color(255-R, 255-G, 255-B));
}

public void controlEvent(ControlEvent theEvent) {
  //println(theEvent.getController().getName());
}

public void PlayPausa1() {
  if (track1.isPlaying()) {
    track1.pause();
  } else {
    track1.play();
  }
}
public void PlayPausa2() {
  if (track2.isPlaying()) {
    track2.pause();
  } else {
    track2.play();
  }
}

public void PlayPausa3() {
  if (track3.isPlaying()) {
    track3.pause();
  } else {
    track3.play();
  }
}

public void PlayPausa4() {
  if (track4.isPlaying()) {
    track4.pause();
  } else {
    track4.play();
  }
}

public void PlayPausa5() {
  if (track5.isPlaying()) {
    track5.pause();
  } else {
    track5.play();
  }
}

public void loop1() {
  track1.loop();
}
public void loop2() {
  track2.loop();
}
public void loop3() {
  track3.loop();
}
public void loop4() {
  track4.loop();
}
public void loop5() {
  track5.loop();
}

public void PlayPausaTotal() {

  if (track1.isPlaying()==false && track2.isPlaying()==false && track3.isPlaying()==false && track4.isPlaying()==false && track5.isPlaying()==false && cp5.get(Matrix.class, "matriz").isPlaying()==false) {
    track1.play();
    track2.play();
    track3.play();
    track4.play();
    track5.play();
    cp5.get(Matrix.class, "matriz").play();
  } else {
    track1.pause();
    track2.pause();
    track3.pause();
    track4.pause();
    track5.pause();
    cp5.get(Matrix.class, "matriz").pause();
  }

  //if (cp5.get(Matrix.class, "matriz").isPlaying()==false) {
  //  cp5.get(Matrix.class, "matriz").play();
  //} else {
  //  cp5.get(Matrix.class, "matriz").pause();
  //}
}


public void LoopTotal() {

  if (track1.isPlaying()==false && track2.isPlaying()==false && track3.isPlaying()==false && track4.isPlaying()==false && track5.isPlaying()==false && cp5.get(Matrix.class, "matriz").isPlaying()==false) {
    track1.loop();
    track2.loop();
    track3.loop();
    track4.loop();
    track5.loop();
    cp5.get(Matrix.class, "matriz").play();
  } else {
    track1.pause();
    track2.pause();
    track3.pause();
    track4.pause();
    track5.pause();
    cp5.get(Matrix.class, "matriz").pause();
  }

  //if (cp5.get(Matrix.class, "matriz").isPlaying()==false) {
  //  cp5.get(Matrix.class, "matriz").play();
  //} else {
  //  cp5.get(Matrix.class, "matriz").pause();
  //}
}





// TODO BANGS

public void trackSelect1() {
  //trackSelect1.setColorForeground(color(180-R, 180-G, 180-B));
  track = 1;
}
public void trackSelect2() {
  //trackSelect1.setColorForeground(color(180-R, 180-G, 180-B));
  track = 2;
}
public void trackSelect3() {
  //trackSelect1.setColorForeground(color(180-R, 180-G, 180-B));
  track = 3;
}
public void trackSelect4() {
  //trackSelect1.setColorForeground(color(180-R, 180-G, 180-B));
  track = 4;
}
public void trackSelect5() {
  //trackSelect1.setColorForeground(color(180-R, 180-G, 180-B));
  track = 5;
}

public void Grabar1() {
  if (recorded == true) { 
    contador_grabacion1+=5;
    recorded = false;
  }
  temp[0] = R;
  temp[1] = G;
  temp[2] = B;
  R = 255;
  G = 5;
  B = 5;
  recorder = minim.createRecorder(in, "track"+contador_grabacion1+".wav");
  File borrar = new File("C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/track"+(contador_grabacion1-5)+".wav");
  borrar.delete();
  recorder.beginRecord();
}
public void Grabar2() {
  if (recorded == true) { 
    contador_grabacion2+=5;
    recorded = false;
  }
  temp[0] = R;
  temp[1] = G;
  temp[2] = B;
  R = 255;
  G = 5;
  B = 5;
  recorder = minim.createRecorder(in, "track"+contador_grabacion2+".wav");
  File borrar = new File("C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/track"+(contador_grabacion2-5)+".wav");
  borrar.delete();
  recorder.beginRecord();
}
public void Grabar3() {
  if (recorded == true) { 
    contador_grabacion3+=5;
    recorded = false;
  }
  temp[0] = R;
  temp[1] = G;
  temp[2] = B;
  R = 255;
  G = 5;
  B = 5;
  recorder = minim.createRecorder(in, "track"+contador_grabacion3+".wav");
  File borrar = new File("C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/track"+(contador_grabacion3-5)+".wav");
  borrar.delete();
  recorder.beginRecord();
}
public void Grabar4() {
  if (recorded == true) { 
    contador_grabacion4+=5;
    recorded = false;
  }
  temp[0] = R;
  temp[1] = G;
  temp[2] = B;
  R = 255;
  G = 5;
  B = 5;
  recorder = minim.createRecorder(in, "track"+contador_grabacion4+".wav");
  File borrar = new File("C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/track"+(contador_grabacion4-5)+".wav");
  borrar.delete();
  recorder.beginRecord();
}
public void Grabar5() {
  if (recorded == true) { 
    contador_grabacion5+=5;
    recorded = false;
  }
  temp[0] = R;
  temp[1] = G;
  temp[2] = B;
  R = 255;
  G = 5;
  B = 5;
  recorder = minim.createRecorder(in, "track"+contador_grabacion5+".wav");
  File borrar = new File("C:/Users/andre/Desktop/Programacion/processing/musica/musica/looperPerron/track"+(contador_grabacion5-5)+".wav");
  borrar.delete();
  recorder.beginRecord();
}

public void Parar1() {
  recorder.endRecord();
  recorder.save();
  recorded = true;
  print("guardado");
  //in.close();
  track1 = new SoundFile(this, "track"+contador_grabacion1+".wav");
  onda1 = new processing.sound.Waveform(this, samples);
  onda1.input(track1);
  R = temp[0];
  G = temp[1];
  B = temp[2];
  track1.loop(); track2.loop(); track3.loop(); track4.loop(); track5.loop();
}
public void Parar2() {
  recorder.endRecord();
  recorder.save();
  recorded = true;
  print("guardado");
  //in.close();
  track2 = new SoundFile(this, "track"+contador_grabacion2+".wav");
  onda2 = new processing.sound.Waveform(this, samples);
  onda2.input(track2);
  R = temp[0];
  G = temp[1];
  B = temp[2];
  track1.loop(); track2.loop(); track3.loop(); track4.loop(); track5.loop();
}
public void Parar3() {
  recorder.endRecord();
  recorder.save();
  recorded = true;
  print("guardado");
  //in.close();
  track3 = new SoundFile(this, "track"+contador_grabacion3+".wav");
  onda3 = new processing.sound.Waveform(this, samples);
  onda3.input(track3);
  R = temp[0];
  G = temp[1];
  B = temp[2];
  track1.loop(); track2.loop(); track3.loop(); track4.loop(); track5.loop();
}
public void Parar4() {
  recorder.endRecord();
  recorder.save();
  recorded = true;
  print("guardado");
  //in.close();
  track4 = new SoundFile(this, "track"+contador_grabacion4+".wav");
  onda4 = new processing.sound.Waveform(this, samples);
  onda4.input(track4);
  R = temp[0];
  G = temp[1];
  B = temp[2];
  track1.loop(); track2.loop(); track3.loop(); track4.loop(); track5.loop();
}
public void Parar5() {
  recorder.endRecord();
  recorder.save();
  recorded = true;
  print("guardado");
  //in.close();
  track5 = new SoundFile(this, "track"+contador_grabacion5+".wav");
  onda5 = new processing.sound.Waveform(this, samples);
  onda5.input(track5);
  R = temp[0];
  G = temp[1];
  B = temp[2];
  track1.loop(); track2.loop(); track3.loop(); track4.loop(); track5.loop();
}


public void Cargar1() {
  selectInput("Seleccione archivo mp3, wav, aiff, aac:", "cargar1");
}

void cargar1(File archivo) {
  if (archivo == null) {
    println("Se canceló la subida de un archivo");
  } else {
    println("Escogió el archivo" + archivo.getAbsolutePath());
    track1 = new SoundFile(this, archivo.getAbsolutePath());
    onda1 = new processing.sound.Waveform(this, samples);
    onda1.input(track1);
  }
}

public void Cargar2() {
  selectInput("Seleccione archivo mp3, wav, aiff, aac:", "cargar2");
}

void cargar2(File archivo) {
  if (archivo == null) {
    println("Se canceló la subida de un archivo");
  } else {
    println("Escogió el archivo" + archivo.getAbsolutePath());
    track2 = new SoundFile(this, archivo.getAbsolutePath());
    onda2 = new processing.sound.Waveform(this, samples);
    onda2.input(track2);
  }
}

public void Cargar3() {
  selectInput("Seleccione archivo mp3, wav, aiff, aac:", "cargar3");
}

void cargar3(File archivo) {
  if (archivo == null) {
    println("Se canceló la subida de un archivo");
  } else {
    println("Escogió el archivo" + archivo.getAbsolutePath());
    track3 = new SoundFile(this, archivo.getAbsolutePath());
    onda3 = new processing.sound.Waveform(this, samples);
    onda3.input(track3);
  }
}

public void Cargar4() {
  selectInput("Seleccione archivo mp3, wav, aiff, aac:", "cargar4");
}

void cargar4(File archivo) {
  if (archivo == null) {
    println("Se canceló la subida de un archivo");
  } else {
    println("Escogió el archivo" + archivo.getAbsolutePath());
    track4 = new SoundFile(this, archivo.getAbsolutePath());
    onda4 = new processing.sound.Waveform(this, samples);
    onda4.input(track4);
  }
}

public void Cargar5() {
  selectInput("Seleccione archivo mp3, wav, aiff, aac:", "cargar5");
}

void cargar5(File archivo) {
  if (archivo == null) {
    println("Se canceló la subida de un archivo");
  } else {
    println("Escogió el archivo" + archivo.getAbsolutePath());
    track5 = new SoundFile(this, archivo.getAbsolutePath());
    onda5 = new processing.sound.Waveform(this, samples);
    onda5.input(track5);
  }
}



public void RandomRGB() {
  R = int(random(255));
  G = int(random(255));
  B = int(random(255));
}













// TODO SAMPLES TRACKS Y ONDAS

void samples_tracks_ondas() {

  stroke(255-R, 255-G, 255-B);
  strokeWeight(3);
  noFill();

  //track 1
  onda1.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 55, 265), //horizontalmente que tanto ocupa
      map(onda1.data[i], -1, 1, 650, 720) //verticalmente que tanto ocupa
      );
  }
  endShape();


  //track 2
  onda2.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 375, 585), //horizontalmente que tanto ocupa
      map(onda2.data[i], -1, 1, 650, 720) //verticalmente que tanto ocupa
      );
  }
  endShape();

  //track 3
  onda3.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 695, 905), //horizontalmente que tanto ocupa
      map(onda3.data[i], -1, 1, 650, 720) //verticalmente que tanto ocupa
      );
  }
  endShape();

  //track 4
  onda4.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 1015, 1225), //horizontalmente que tanto ocupa
      map(onda4.data[i], -1, 1, 650, 720) //verticalmente que tanto ocupa
      );
  }
  endShape();

  //track 5
  onda5.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 1335, 1550), //horizontalmente que tanto ocupa
      map(onda5.data[i], -1, 1, 650, 720) //verticalmente que tanto ocupa
      );
  }
  endShape();
}



// decoraciones

void decoracion() {
  strokeWeight(1);
  stroke(255-R, 255-G, 255-B);
  for ( N = 0; N <= Nmax; N++ ) {
    for ( NN = N+1; NN <= Nmax; NN++ ) {
      L = sqrt(((X[N]-X[NN])*(X[N]-X[NN]))+((Y[N]-Y[NN])*(Y[N]-Y[NN]))) ;
      L = sqrt(((Z[N]-Z[NN])*(Z[N]-Z[NN]))+(L*L)) ;
      if ( L < RR ) {
        X[N] = X[N] - ((X[NN]-X[N])*((RR-L)/(2*L))) ;
        Y[N] = Y[N] - ((Y[NN]-Y[N])*((RR-L)/(2*L))) ;
        Z[N] = Z[N] - ((Z[NN]-Z[N])*((RR-L)/(2*L))) ;
        X[NN] = X[NN] + ((X[NN]-X[N])*((RR-L)/(2*L))) ;
        Y[NN] = Y[NN] + ((Y[NN]-Y[N])*((RR-L)/(2*L))) ;
        Z[NN] = Z[NN] + ((Z[NN]-Z[N])*((RR-L)/(2*L))) ;
        dV[N] = dV[N] + ((V[NN]-V[N])/M) ;
        dV[NN] = dV[NN] - ((V[NN]-V[N])/M) ;
        stroke(255-R, 125+(Z[N]/2), 125+(Z[N]/2)) ; 
        //stroke(255-R, 150-G, 200-B);
        line(X[N]*1.2*(200+V[N])/200+800, Y[N]*1.2*(200+V[N])/200+400, X[NN]*1.2*(200+V[NN])/200+800, Y[NN]*1.2*(200+V[NN])/200+400) ;
      }
      if ( Z[N] > Z[NN] ) {
        KX = X[N] ; 
        KY = Y[N] ; 
        KZ = Z[N] ; 
        KV = V[N] ; 
        KdV = dV[N] ; 
        X[N] = X[NN] ; 
        Y[N] = Y[NN] ; 
        Z[N] = Z[NN] ; 
        V[N] = V[NN] ; 
        dV[N] = dV[NN] ;  
        X[NN] = KX ; 
        Y[NN] = KY ; 
        Z[NN] = KZ ; 
        V[NN] = KV ; 
        dV[NN] = KdV ;
      }
    }
    L = sqrt((X[N]*X[N])+(Y[N]*Y[N])) ;
    L = sqrt((Z[N]*Z[N])+(L*L)) ;
    X[N] = X[N] + (X[N]*(200-L)/(2*L)) ;
    Y[N] = Y[N] + (Y[N]*(200-L)/(2*L)) ;
    Z[N] = Z[N] + (Z[N]*(200-L)/(2*L)) ;
    KZ = Z[N] ; 
    KX = X[N] ;
    Z[N] = (KZ*cos(float(300-mouseX)/1000000))-(KX*sin(float(300-mouseX)/1000000)) ;
    X[N] = (KZ*sin(float(300-mouseX)/1000000))+(KX*cos(float(300-mouseX)/1000000)) ;
    KZ = Z[N] ; 
    KY = Y[N] ;
    Z[N] = (KZ*cos(float(300-mouseY)/1000000))-(KY*sin(float(300-mouseY)/1000000)) ;
    Y[N] = (KZ*sin(float(300-mouseY)/1000000))+(KY*cos(float(300-mouseY)/1000000)) ;
    dV[N] = dV[N] - (V[N]*HH) ; 
    V[N] = V[N] + dV[N] ; 
    dV[N] = dV[N] * H ;
  }

  float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing;

  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;
  noStroke();
  fill(color(255-R, 255-G, 255-B));
  //stroke(255-R, 255-G, 255-B,255);
  ellipse(x, y, 33, 33);
}

void mousePressed() {
  //Lmin = 600 ; 
  //NN = 0 ;
  //for ( N = 0; N <= Nmax; N++ ) {
  //  L = sqrt(((mouseX-(300+X[N]))*(mouseX-(300+X[N])))+((mouseY-(300+Y[N]))*(mouseY-(300+Y[N])))) ;
  //  if ( Z[N] > 0 && L < Lmin ) { 
  //    NN = N ; 
  //    Lmin = L ;
  //  }
  //}
  //if ( K == 0 ) { 
  //  dV[NN] = -200 ; 
  //  K = 1 ;
  //} else { 
  //  dV[NN] = +200 ; 
  //  K = 0 ;
  //}

  if (mouseButton==RIGHT) {
    if (grabando == false) {
      switch(track) {
        case(1):
        Grabar1();
        grabando = true;
        break;
        case(2):
        Grabar2();
        grabando = true;
        break;
        case(3):
        Grabar3();
        grabando = true;
        break;
        case(4):
        Grabar4();
        grabando = true;
        break;
        case(5):
        Grabar5();
        grabando = true;
        break;
      }
    } else {
      switch(track) {
        case(1):
        Parar1();
        grabando = false;
        track1.loop();
        break;
        case(2):
        Parar2();
        grabando = false;
        track2.loop();
        break;
        case(3):
        Parar3();
        grabando = false;
        track3.loop();
        break;
        case(4):
        Parar4();
        grabando = false;
        track4.loop();
        break;
        case(5):
        Parar5();
        grabando = false;
        track5.loop();
        break;
      }
    }
  }
}

void bangsTrack() {
  switch(track) {
    case(1):
    trackSelect1.setColorForeground(color(185, 30, 30));
    break;
    case(2):
    trackSelect2.setColorForeground(color(185, 30, 30));
    break;
    case(3):
    trackSelect3.setColorForeground(color(185, 30, 30));
    break;
    case(4):
    trackSelect4.setColorForeground(color(185, 30, 30));
    break;
    case(5):
    trackSelect5.setColorForeground(color(185, 30, 30));
    break;
  }
}

void keyPressed() {
  if (key == '1') {
    track = 1;
  }
  if (key == '2') {
    track = 2;
  }
  if (key == '3') {
    track = 3;
  }
  if (key == '4') {
    track = 4;
  }
  if (key == '5') {
    track = 5;
  }
  if (key=='p') {
    switch(track) {
    case 1:
      PlayPausa1();
      break;
    case 2:
      PlayPausa2();
      break;
    case 3:
      PlayPausa3();
      break;
    case 4:
      PlayPausa4();
      break;
    case 5:
      PlayPausa5();
      break;
    }
  }
  if (key=='l') {
    switch(track) {
    case 1:
      loop1();
      break;
    case 2:
      loop2();
      break;
    case 3:
      loop3();
      break;
    case 4:
      loop4();
      break;
    case 5:
      loop5();
      break;
    }
  }
  if (key=='o') {
    PlayPausaTotal();
  }
  
  if (key=='i') {
    LoopTotal();
  }

  if (key == 'm') {
    if (cp5.get(Matrix.class, "matriz").isPlaying()) {
      cp5.get(Matrix.class, "matriz").pause();
    } else {
      cp5.get(Matrix.class, "matriz").play();
    }
  } 
  if (key=='0') {
    cp5.get(Matrix.class, "matriz").clear();
  }
}

// matriz

void matriz(int theX, int theY) {
  //println("got it: "+theX+", "+theY);
  d[theX][theY].update();

  if (theY==0) {
    hiHat1.play();
  }
  if (theY==1) {
    hiHat2.play();
  }
  if (theY==2) {
    hiHat3.play();
  }
  if (theY==3) {
    snare.play();
  }
  if (theY==4) {
    snare2.play();
  }
  if (theY==5) {
    bass1.play();
  }
  if (theY==6) {
    bass2.play();
  }
  if (theY==7) {
    tom1.play();
  }
  if (theY==8) {
    tom2.play();
  }
  if (theY==9) {
    tom3.play();
  }
}

class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 700);
    y = sin(f)*random(100, 600);
    s0 = random(2, 10);
  }

  void display() {
    //stroke(255-R,255-G,255-B,0);
    s1 += (s0-s1)*0.1;
    ellipse(x, y, s1, s1);
    ellipse(x+4, y+15, s1, s1);
    ellipse(x+10, y+22, s1, s1);
    ellipse(x+44, y+12, s1, s1);
    ellipse(x+43, y+33, s1, s1);
    ellipse(x+13, y+36, s1, s1);
    ellipse(x+18, y+17, s1, s1);
    ellipse(x+21, y+54, s1, s1);
    ellipse(x+45, y+33, s1, s1);
  }

  void update() {
    s1 = 50;
  }
}


void matriz_drums() {
  int xx = int(bateriaxy.getValue());
  if (tempXX!= xx) {
    nx = xx;
    Matriz.setGrid(nx, ny);
  }

  tempXX = xx;
  pushMatrix();

  //int xx = int(bateriaxy.getValue());
  //nx = xx;
  translate(width/2, height/2);
  rotate(frameCount*0.001);
  for (int x = 0; x<nx; x++) {
    for (int y = 0; y<ny; y++) {
      d[x][y].display();
    }
  }
  ritmo = int(volumenRitmo.getArrayValue(1));
  Matriz.setInterval(ritmo);
  bpmI = 60000/ritmo;
  bpm.setText(bpmI+" BPM");
  bpm.setColorValue(color(255-R, 255-G, 255-B));
  volumenP = volumenRitmo.getArrayValue(0);
  bass1.amp(volumenP/10);
  bass2.amp(volumenP/10);
  hiHat1.amp(volumenP/10);
  hiHat2.amp(volumenP/10);
  hiHat3.amp(volumenP/10);
  snare.amp(volumenP/10);
  snare2.amp(volumenP/10);
  tom1.amp(volumenP/10);
  tom2.amp(volumenP/10);
  tom3.amp(volumenP/10);



  popMatrix();
}
