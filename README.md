# DataViz
## About DataViz
Welcome to DataViz! DataViz is a data visualization app built on Shiny Dashboard (and other libraries). This app aims to help R users for in-depth data analysis without having to leave R. And the best part is, you can freely control multiple graphs!

## App Simulation
### 1. Upload your CSV file
Upload your CSV file in the given upload page. For this simulation we use Video Game Sales dataset acquired from Kaggle. Here's the link: https://www.kaggle.com/gregorut/videogamesales

upload page gif here

### 2. Make your first graph
Hover to the Graphs tab and click the Graph1 tab for your first plot (or graph, whatever you want to say it lol).

click graph

In the sidebar of the plot there are a few dropdown panels used for creating the plot. The X-Axis and Y-Axis automatically filled with column names of your uploaded CSV whereas the calculation methods and plot types are given from the app. Pick the plot properties according to your will starting from the X-Axis.

create plot gif
or sidebar plot gif

### 3. Don't be shy! Plot some more!
If you need to plot more variables from the dataset, you can hover to the Graph Options tab to add it!

click graph opt png

Insert your desired graph name, in this example i use Graph2, then click add. And yes, you can't put the same graph name, it won't let you do it.

insert graph name

If you decided not to create the plot, you can simply delete it.

delete graph gif

I'm going to use four graphs in this example to show how each plot type looks like.

### 4. "Zoom" your dataset
Look at the example plot below, it's really hard to look at the X-Axis values isn't it? Well, you can simply click or multiple select on the curves on the plot and DataViz will show you which entries are selected!

select gif
multiple select gif

Unfortunately, the piechart only support for single selection for now. I'll get to that on the later updates ;)

piechart select gif

### 5. Plot away!
Utilize DataViz for your data analyzing process! Plot as many as you want as your heart desires. Here are some tips to decide which plot type you should choose depending on what you're looking from the dataset:

a. Proportion of values of a variable -> PieChart or BarPlot
b. Value movements depending on time progression -> LineChart
c. Correlation between two sets of values -> ScatterPlot

## Side Notes
DataViz is still in development, so expect some glitches/errors. Nevertheless, I hope you enjoy using this app as much as I do making it. For any feedbacks/improvements/error reports, feel free to open an issue below. -N.S.
