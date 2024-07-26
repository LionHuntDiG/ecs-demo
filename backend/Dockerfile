# Build stage
FROM python:3.8-slim as builder
WORKDIR /app
COPY app.py /app
RUN pip install Flask boto3

# Final stage
FROM python:3.8-slim
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 5000
CMD ["python", "app.py"]
