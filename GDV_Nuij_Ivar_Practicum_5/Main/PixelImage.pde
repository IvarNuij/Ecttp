class PixelImage {

  PImage currentImage;
  int xPos;
  int yPos;
  int imageWidthResolution;
  int imageHeightResolution;
  int pixelSize;

  int[][] pixelList;
  int[][] resizedPixelList;

  color currentColor;

  int xDraw;
  int yDraw;

  PixelImage() {
  }

  void Add(PImage _currentImage, int _xPos, int _yPos, int _imageWidthResolution, int _imageHeightResolution, int _pixelSize) {
    currentImage = _currentImage;
    xPos = _xPos;
    yPos = _yPos;
    imageWidthResolution = _imageWidthResolution;
    imageHeightResolution = _imageHeightResolution;
    pixelSize = _pixelSize;

    //Convert Image to a grayScale array
    pixelList = new int[currentImage.width][currentImage.height];
    resizedPixelList = new int[imageWidthResolution][imageHeightResolution];

    currentImage.loadPixels();

    //make PixelList
    for (int x=0; x < currentImage.width; x += 1) {
      for (int y=0; y < currentImage.height; y += 1) {
        currentColor = currentImage.get(x, y);

        int grayScale;
        float red;
        float green;
        float blue;

        red = red(currentColor);
        green = green(currentColor);
        blue = blue(currentColor);

        grayScale = int((red + green + blue) / 2);
        pixelList[x][y] = grayScale;
      }
    }

    int xResize = currentImage.width / imageWidthResolution;
    int yResize = currentImage.height / imageHeightResolution;

    //Resize pixelList
    for (int x=0; x < imageWidthResolution; x += 1) {
      for (int y=0; y < imageHeightResolution; y += 1) {

        resizedPixelList[x][y] = pixelList[x * xResize][y * yResize];
      }
    }
  }

  void Update() {
    //Draw PixelImage
    int x;
    int y;
    for (y=0; y < imageHeightResolution; y += 1) {
      for (x=0; x < imageWidthResolution; x += 1) {
        noStroke();
        fill(resizedPixelList[x][y], 255);
        rect(xDraw, yDraw, pixelSize, pixelSize);
        stroke(1);
        xDraw += pixelSize;
      }
      yDraw += pixelSize;
      xDraw = xPos;
    }
    xDraw = xPos;
    yDraw = yPos;
  }
}
