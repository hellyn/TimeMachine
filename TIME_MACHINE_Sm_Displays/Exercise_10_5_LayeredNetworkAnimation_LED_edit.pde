// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An animated drawing of a Neural Network

Network network;

void setup() {
  size(25, 5); 
  // Create the Network object
  network = new Network(0,0);

  int layers = 4;
  int inputs = 2;

  Neuron output = new Neuron(25, 2);
  for (int i = 0; i < layers; i++) {
    for (int j = 0; j < inputs; j++) {
      float x = map(i, 0, layers, 0, 24);
      float y = map(j, 0, inputs-1, 0, 4);
      Neuron n = new Neuron(x, y);
      if (i > 0) {
        for (int k = 0; k < inputs; k++) {
          Neuron prev = network.neurons.get(network.neurons.size()-inputs+k-j); 
          network.connect(prev, n, random(1));
        }
      }
      if (i == layers-1) {
        network.connect(n, output, random(1));
      }
      network.addNeuron(n);
    }
  } 
  network.addNeuron(output);
}

void draw() {
  background(0);
  // Update and display the Network
  network.update();
  network.display();

  // Every 30 frames feed in an input
  if (frameCount % 30 == 0) {
    network.feedforward(random(1),random(1));
  }
}

