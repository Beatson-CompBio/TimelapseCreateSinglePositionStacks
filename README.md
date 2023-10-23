# TimelapseCreateSinglePositionStacks
An ImageJ macro to open MetaMorph .nd multiposition file and save each postion as a multi-channel timelapse.

## Introduction
The BAIR timelapse microscopes use MetaMorph to capture image data. Commonly users wish to collect multiposition timelapse images in 1-4 channels. MetaMorph collects each image individually which can be addressed using a .nd file. If the file is very big though the .nd file is not easy to open so it is preferable to have each position saved as it's own stack. This macro works inside ImageJ/Fiji to open each file and save into separate tiff stacks.

## Installation and Usage
1. Download the .ijm macro and open in ImageJ/Fiji. 
2. Run the macro (bottom left of the macro window).
3. When the GUI pops up, navigate to the desired folder containing the images, enter the number of positions, channels and also whether downsampling is required (downsampling can help to reduce image size if full resolution is not needed).
5. The program will then run through the images, opening each individual position and saving as a single multidimensional tiff per position in the sub-folder "CombinedTiffs".
6. If the Brightfield, GFP, mCherry and DAPI channels are used, the program should colour them correctly automatically.
7. Leave to run, might take a while as opening the original image sequences a very slow, suggest leaving overnight to process.
