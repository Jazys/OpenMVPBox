FROM jupyter/datascience-notebook

COPY requirements.txt /home

RUN pip install --no-cache-dir -r /home/requirements.txt
RUN conda install -c conda-forge nodejs
RUN jupyter lab build

