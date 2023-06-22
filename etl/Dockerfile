# Start from a core stack version
FROM python:3.11.4-alpine3.18

WORKDIR /app

# Install dependencies
COPY ./requirements.txt /app
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY . .

CMD ["python3","app.py"]