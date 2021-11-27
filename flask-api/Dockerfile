FROM python:3.6-alpine

WORKDIR /app

COPY requirements.txt /app/

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev libffi-dev

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 5000

ENV FLASK_ENV=development

ENV PORT=5000

CMD sh run.sh
