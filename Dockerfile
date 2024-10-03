FROM python:3.9

RUN apt-get update && apt-get install -y vim
WORKDIR /app

# ENV PATH=/usr/app:/root/.local/bin

# 필요한 라이브러리 설치
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
# 파이프라인 코드 복사
COPY . /app

CMD ["python", "/app/main.py"]

