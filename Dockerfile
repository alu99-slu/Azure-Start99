# Python sample app container
FROM python:3.10-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app
ENV FLASK_ENV=production
EXPOSE 5000

CMD ["python", "app.py"]