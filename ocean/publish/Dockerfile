FROM python:3.10-slim-bullseye

COPY ./src/* app/

WORKDIR /app

RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "main.py"]
