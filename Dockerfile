FROM pytorch/pytorch:2.5.1-cuda11.8-cudnn9-runtime

# 減少層數，合併步驟以縮小映像大小
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1 \
    libgtk2.0-dev \
    ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 使用多階段構建，安裝必要的 Python 套件
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm -rf /tmp/requirements.txt && \
    pip install --no-cache-dir notebook jupyterlab matplotlib

# 設定工作目錄
WORKDIR /workspace

# 複製專案文件
COPY . .

# 檢查 CUDA 支援，並根據執行環境選擇執行模式
CMD python3 -c "import torch; print('Using GPU' if torch.cuda.is_available() else 'Using CPU');" && \
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
