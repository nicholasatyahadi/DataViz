# DataViz
## About DataViz
Welcome to DataViz! DataViz is a data visualization app built on Shiny Dashboard (and other libraries). This app aims to help R users for in-depth data analysis without having to leave R. And the best part is, you can freely control multiple graphs!

## How to use the app
Simply clone the repository then run the datavizApp.R file. Don't forget the CSV file you want to use and install the package needed for the app (it's in the code)! :)

## App Simulation
### 1. Upload your CSV file
Upload your CSV file in the given upload page. For this simulation we use Video Game Sales dataset acquired from Kaggle. Here's the link: https://www.kaggle.com/gregorut/videogamesales

Click on the tab shown below

<img width="179" alt="create firstplot" src="https://user-images.githubusercontent.com/53423050/85917215-6fd96980-b882-11ea-9ff0-00e815d09c9b.png">

![upload page](https://user-images.githubusercontent.com/53423050/85917063-13c21580-b881-11ea-8e80-6df9152f8946.gif)  

### 2. Make your first graph
Hover to the Graphs tab and click the Graph1 tab for your first plot (or graph, whatever you want to say it lol).

<img width="179" alt="create firstplot" src="https://user-images.githubusercontent.com/53423050/85917074-3b18e280-b881-11ea-94d8-39e22291d645.png">

In the sidebar of the plot there are a few dropdown panels used for creating the plot. The X-Axis and Y-Axis automatically filled with column names of your uploaded CSV whereas the calculation methods and plot types are given from the app. Pick the plot properties according to your will starting from the X-Axis.

![axisplotfill](https://user-images.githubusercontent.com/53423050/85917077-4835d180-b881-11ea-9071-1b1e8b946a13.gif)

Here's an example using BarPlot:
![graph1plot](https://user-images.githubusercontent.com/53423050/85917084-5edc2880-b881-11ea-985b-95fd32e83e34.gif)

### 3. Don't be shy! Plot some more!
If you need to plot more variables from the dataset, you can hover to the Graph Options tab to add it!

<img width="179" alt="graphoption" src="https://user-images.githubusercontent.com/53423050/85917090-75827f80-b881-11ea-8150-f06da93d796d.png">

Insert your desired graph name, in this example i use Graph2, then click add. And yes, you can't put the same graph name, it won't let you do it.

![addgraph2](https://user-images.githubusercontent.com/53423050/85917096-829f6e80-b881-11ea-85db-8d90c0e6c3e0.gif)

If you decided not to create the plot, you can simply delete it.

![graph2delete](https://user-images.githubusercontent.com/53423050/85917099-8d5a0380-b881-11ea-8608-cb8853220898.gif)

I'm going to use four graphs in this example to show how each plot type looks like

#### LineChart
<img width="745" alt="linechart" src="https://user-images.githubusercontent.com/53423050/85917117-c7c3a080-b881-11ea-9bc1-19def3dae9bb.png">

#### PieChart
<img width="746" alt="piechart" src="https://user-images.githubusercontent.com/53423050/85917112-c1352900-b881-11ea-8302-cc1866c0cc31.png">

#### ScatterPlot
<img width="743" alt="scatterplot" src="https://user-images.githubusercontent.com/53423050/85917125-d316cc00-b881-11ea-9898-7274addabf6b.png">

### 4. "Zoom" your dataset
Look at the example plot below, it's really hard to look at the X-Axis values isn't it? Well, you can simply click or multiple select on the curves on the plot and DataViz will show you which entries are selected!

#### Single select:
![clickshow](https://user-images.githubusercontent.com/53423050/85917170-1b35ee80-b882-11ea-8c21-9115fed9c604.gif)

#### Multiple select:
![boxselect](https://user-images.githubusercontent.com/53423050/85917171-20933900-b882-11ea-9103-f050f816bb38.gif)

Unfortunately, the piechart only support for single selection for now. I'll get to that on the later updates ;)

![pieclick](https://user-images.githubusercontent.com/53423050/85917181-2721b080-b882-11ea-97ac-fb094d767e36.gif)

To remove the selection, simply double click on the plot area besides the curve, just like this:
![deletefil](https://user-images.githubusercontent.com/53423050/85917197-50dad780-b882-11ea-88ca-1b75634bb55e.gif)

### 5. Plot away!
Utilize DataViz for your data analyzing process! Plot as many as you want as your heart desires. Here are some tips to decide which plot type you should choose depending on what you're looking from the dataset:

a. Proportion of values of a variable -> PieChart or BarPlot

b. Value movements depending on time progression -> LineChart

c. Correlation between two sets of values -> ScatterPlot

## Side Notes
DataViz is still in development, so expect some glitches/errors. Nevertheless, I hope you enjoy using this app as much as I do making it. For any feedbacks/improvements/error reports, feel free to open an issue. -N.S.
