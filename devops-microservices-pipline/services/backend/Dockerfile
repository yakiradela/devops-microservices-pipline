FROM python:3.9
COPY server.py .
RUN pip install fastapi uvicorn
CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "80"]
