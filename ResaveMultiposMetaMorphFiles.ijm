//User dialog to get folder location, number of positions and channels and also downsampling option
ds_opt = newArray("None", "2", "4", "8");
Dialog.create("Timelapse parameters");
Dialog.addDirectory("Directory of nd files:", File.directory)
Dialog.addNumber("Number of positions:", 1);
Dialog.addNumber("Number of channels:", 1);
Dialog.addChoice("Downsampling factor:", ds_opt);
Dialog.show();
dir1 = Dialog.getString();
npos = Dialog.getNumber();
nch = Dialog.getNumber();;
ds = Dialog.getChoice();

list = getFileList(dir1);
ffdir = dir1 + File.separator + "CombinedTiffs" + File.separator;
File.makeDirectory(ffdir);

ChStr = "";

for (i=1; i<=npos; i++) {
	File.openSequence(dir1, "filter=(...s" + i + "_...)");
	title = getTitle;
	if (nch>1) {
		run("Stack Splitter", "number=" + nch);
		for (j=1; j<=nch;j++){
			singleChStr = "c" + j + "=[stk_000" + j + "_" + title + "]";
			ChStr = ChStr + " " + singleChStr;
			//print(ChStr);
		}
//	//run("Merge Channels...", "c1=[stk_0003_" + title + "] c2=[stk_0002_" + title + "] c4=[stk_0001_" + title + "] create");
		run("Merge Channels...", ChStr + " create");
	}
	run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	for (j=1; j<=nch;j++){
		Stack.setPosition(j, 1, 1);
		chj_title = getInfo("slice.label");
		if (matches(chj_title, ".*(Brightfield).*|.*(BF).*")) {
			run("Grays");;
		}
		if (matches(chj_title, ".*(GFP).*")) {
			run("Green");
		}
		if (matches(chj_title, ".*(mCherry).*|.*(mCHERRY).*|.*(Cherry).*")) {
			run("Red");;
		}
		if (matches(chj_title, ".*(DAPI).*|.*(Dapi).*|.*(CFP).*")) {
			run("Blue");
		}
	}
	if (ds != "None") {
		run("Bin...", "x=" + ds + " y=" + ds + " bin=Average");
	}
	saveAs("Tiff", ffdir + "/s" + i + ".tif");
	run("Close All");
}

