from typing import Optional, List
import pandas as pd
from pydantic import BaseModel, Field, validator
import datetime as dt

from fastapi import FastAPI

app = FastAPI()


class PenguinsBase(BaseModel):
    @validator('*')
    def change_nan_to_none(cls, v, field):
        if field.outer_type_ is float and pd.isna(v):
            return None
        return v


class Penguin(PenguinsBase):
    species: Optional[str]
    island: Optional[str]
    bill_length_mm: Optional[float]
    bill_depth_mm: Optional[float]
    flipper_length_mm: Optional[float]
    body_mass_g: Optional[float]
    sex: Optional[str]
    year: Optional[int]


class PenguinRaw(PenguinsBase):
    study_name: str = Field(alias="studyName")
    sample_number: int = Field(alias="Sample Number")
    species: str = Field(alias="Species")
    region: str = Field(alias="Region")
    island: str = Field(alias="Island")
    stage: str = Field(alias="Stage")
    individual_id: str = Field(alias="Individual ID")
    clutch_completion: str = Field(alias="Clutch Completion")
    date_egg: Optional[dt.date] = Field(alias="Date Egg")
    culmen_length_mm: Optional[float] = Field(alias="Culmen Length (mm)")
    culmen_depth_mm: Optional[float] = Field(alias="Culmen Depth (mm)")
    flipper_length_mm: Optional[float] = Field(alias="Flipper Length (mm)")
    body_mass_g: Optional[float] = Field(alias="Body Mass (g)")
    sex: str = Field(alias="Sex")
    delta_15_n_o_oo: Optional[float] = Field(alias="Delta 15 N (o/oo)")
    delta_13_c_o_oo: Optional[float] = Field(alias="Delta 13 C (o/oo)")


@app.get("/penguins", response_model=List[Penguin])
def penguins(sample_size: Optional[int] = None):
    url = "https://github.com/allisonhorst/palmerpenguins/raw/master/inst/extdata/penguins.csv"
    penguins_df = pd.read_csv(url)
    if sample_size:
        penguins_df = penguins_df.sample(sample_size)
    penguins_response = [Penguin(**i) for i in penguins_df.to_dict(orient="records")]
    return penguins_response


@app.get("/raw_penguins", response_model=List[PenguinRaw])
def raw_penguins(sample_size: Optional[int] = None):
    url = "https://github.com/allisonhorst/palmerpenguins/raw/master/inst/extdata/penguins_raw.csv"
    penguins_raw_df = pd.read_csv(url)
    if sample_size:
        penguins_raw_df = penguins_raw_df.sample(sample_size)
    penguins_raw_response = [PenguinRaw(**i) for i in penguins_raw_df.to_dict(orient="records")]
    return penguins_raw_response