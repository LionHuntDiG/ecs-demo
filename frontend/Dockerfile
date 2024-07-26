# Build stage
FROM python:3.8-slim as builder
WORKDIR /app
COPY app.py /app
COPY templates /app/templates
RUN pip install Flask requests

# Final stage
FROM python:3.8-slim
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 80
CMD ["python", "app.py"]
