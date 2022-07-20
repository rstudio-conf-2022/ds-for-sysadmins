# app/app.py

from textwrap import dedent

import dash_bootstrap_components as dbc
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from dash import Dash, dcc, html

app = Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])
url = "https://github.com/allisonhorst/palmerpenguins/raw/master/inst/extdata/penguins.csv"
data = pd.read_csv(url)

def plot_histogram():
    fig = go.Figure()
    for i in data["species"].unique():
        fig.add_trace(
            go.Histogram(
                x=data.loc[data["species"] == i, "flipper_length_mm"],
                name=i
            )
        )
    fig.update_traces(opacity=0.75)
    fig.update_layout(
        title="Distribution of Flipper Length",
        barmode='overlay',
        showlegend=False
    )
    return fig


def plot_scatter():
    fig = go.Figure()
    for i in data["species"].unique():
        fig.add_trace(
            go.Scatter(
                x=data.loc[data["species"] == i, "flipper_length_mm"],
                y=data.loc[data["species"] == i, "bill_length_mm"],
                name=i,
                mode="markers"
            )
        )
    fig.update_traces(opacity=0.75)
    fig.update_layout(
        title="Bill Length vs. Flipper Length",
    )
    return fig


app.layout = dbc.Container([
    html.H1('Meet the penguins!', style={'margin-top': '10pt'}),
    dbc.Row(children=[
        dbc.Col(
            style={"display": "flex"},
            children=[
                html.Div(
                    style={'margin': 'auto'}, 
                    children=dedent(
                        """
                        The data was collected and made available by Dr. Kristen Gorman and the Palmer 
                        Station, Antarctica LTER, a member of the Long Term Ecological Research Network.
                        """
                    ).strip()
                )
            ]
        ),
        dbc.Col([
            html.Img(
                src="https://allisonhorst.github.io/palmerpenguins/reference/figures/lter_penguins.png",
                width=200
            )
        ], style={'text-align': 'center'}),
    ]),
    dbc.Row([
        dbc.Col(
            dcc.Graph(figure=plot_histogram())
        ),
        dbc.Col(
            dcc.Graph(figure=plot_scatter())
        ),
    ]),
])

if __name__ == '__main__':
    app.run_server(debug=False)