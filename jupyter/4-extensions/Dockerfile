FROM minidocks/jupyter:4
LABEL maintainer="Martin Hasoň <martin.hason@gmail.com>"

RUN apk add --update py3-psutil \
    && pip install jupyter_nbextensions_configurator jupyter_contrib_nbextensions ipywidgets \
    && jupyter nbextensions_configurator enable \
    && jupyter nbextension enable --py widgetsnbextension \
    && rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip && pyclean
