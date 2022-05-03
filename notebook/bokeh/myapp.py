import numpy as np
from bokeh.io import curdoc
from bokeh.layouts import row, column
from bokeh.models import ColumnDataSource
from bokeh.models.widgets import Slider, TextInput
from bokeh.plotting import figure
N = 200
x = np.linspace(0, 4*np.pi, N)
y = np.sin(x)
source = ColumnDataSource(data = dict(x = x, y = y))
plot = figure(plot_height = 400, plot_width = 400, title = "sine wave")
plot.line('x', 'y', source = source, line_width = 3, line_alpha = 0.6)
freq = Slider(title = "frequency", value = 1.0, start = 0.1, end = 5.1, step = 0.1)
def update_data(attrname, old, new):
   a = 1
   b = 0
   w = 0
   k = freq.value
   x = np.linspace(0, 4*np.pi, N)
   y = a*np.sin(k*x + w) + b
   source.data = dict(x = x, y = y)
freq.on_change('value', update_data)
curdoc().add_root(row(freq, plot, width = 500))
curdoc().title = "Sliders"




