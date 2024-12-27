
# Deep Learning Training Platform using Docker

1. This project sets up a deep learning training platform using Docker. 
2. The platform is configured for Brain Tumor Image Dataset: Semantic Segmentation
3. [Brain Tumor Image Dataset - Semantic Segmentation](https://www.kaggle.com/datasets/pkdarabi/brain-tumor-image-dataset-semantic-segmentation).
4. The following libraries are required for this project:

```
numpy
opencv-python
matplotlib
torch
torchvision
```

---

## 1. Installing Python 3.10.6

### macOS
1. Download Python 3.10.6 from the [official Python website](https://www.python.org/downloads/release/python-3106/).
2. Open the downloaded `.pkg` file and follow the installation steps.
3. Verify the installation by running:
   ```bash
   python3 --version
   ```
   You should see `Python 3.10.6`.

### Windows
1. Download Python 3.10.6 from the [official Python website](https://www.python.org/downloads/release/python-3106/).
2. Run the installer and check the option to `Add Python 3.10 to PATH`.
3. Follow the installation instructions and select `Install Now`.
4. Verify the installation by running in `cmd`:
   ```bash
   python --version
   ```
   You should see `Python 3.10.6`.

---

## 2. Checking Graphics Card Driver Version

### macOS
1. macOS does not natively support CUDA. You must use Docker Desktop with GPU passthrough (requires macOS 11+ on Apple Silicon).
2. Check for GPU support using the terminal:
   ```bash
   system_profiler SPDisplaysDataType
   ```
   Note: For macOS, this step is informational as macOS does not directly support NVIDIA CUDA.

### Windows
1. Open `Device Manager`:
   - Press `Win + X` and select `Device Manager`.
   - Expand `Display adapters` to find your NVIDIA GPU.
2. Check the driver version:
   - Right-click on your NVIDIA GPU, then select `Properties` > `Driver` tab.
   - Note the driver version.
3. Verify compatibility with CUDA using NVIDIA’s [CUDA Toolkit Compatibility Chart](https://developer.nvidia.com/cuda-toolkit-archive).

---

## 3. Installing the Required NVIDIA Driver

### macOS
- macOS does not require NVIDIA drivers. Skip this step.

### Windows
1. Download the latest compatible driver for your GPU from the [NVIDIA Drivers Download](https://www.nvidia.com/Download/index.aspx).
2. Install the driver by following the on-screen instructions.
3. Restart your computer after installation.

---

## 4. Installing CUDA Toolkit

### macOS
- macOS does not support native CUDA installation. Proceed directly to Docker installation.

### Windows
1. Download the CUDA Toolkit from NVIDIA’s [CUDA Downloads Page](https://developer.nvidia.com/cuda-downloads).
2. During installation:
   - Select `Express` for default components.
   - Verify installation by running the following in `cmd`:
     ```bash
     nvcc --version
     ```
   - You should see the installed CUDA version.

---

## 5. Installing Docker

### Installing WSL (Windows Subsystem for Linux)
1. Open PowerShell as Administrator and install WSL with the following command:
   ```bash
   wsl --install -d Ubuntu-20.04
   ```
   This will install WSL 2 and the Ubuntu 20.04 distribution.
2. Once the installation is complete, restart your computer if prompted.
3. Verify the installation by running:
   ```bash
   wsl --list --verbose
   ```
   Ensure Ubuntu-20.04 is listed and running WSL version 2.

### macOS
1. Download Docker Desktop for macOS from the [Docker website](https://www.docker.com/products/docker-desktop).
2. Install Docker Desktop:
   - Open the `.dmg` file and drag Docker to `Applications`.
   - Open Docker Desktop and follow the onboarding steps.
3. Enable GPU support (Apple Silicon):
   - Use GPU passthrough via Virtualization framework.

### Windows
1. Download Docker Desktop for Windows from the [Docker website](https://www.docker.com/products/docker-desktop).
2. Install Docker Desktop:
   - Run the installer and follow the instructions.
   - Ensure you enable `Use WSL 2 instead of Hyper-V` if prompted.
3. Configure GPU Support:
   - Open Docker Desktop settings (Gear icon).
   - Navigate to "Resources > WSL integration" and ensure your distribution is enabled.

### Installing NVIDIA Container Toolkit

#### macOS
- macOS does not natively support NVIDIA Container Toolkit.
- Skip this step if you are using macOS.

#### Windows
1. Open the Ubuntu terminal in WSL 2.
     ```bash
     wsl
     ```
2. Add the NVIDIA package repository:
   ```bash
   curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
   distribution=$(lsb_release -cs)
   echo "deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/ubuntu/$distribution/$(arch) /" | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null
   ```
3. Update the package list and install the NVIDIA Container Toolkit:
   ```bash
   sudo apt-get update
   sudo apt-get install -y nvidia-container-toolkit
   sudo systemctl restart docker
   ```

---

## 6. Building and Running the Docker Project

### Building the Docker Image
1. Navigate to your project directory:
   ```bash
   cd <path_to_your_project>
   ```
   Replace `<path_to_your_project>` with the actual path to your project directory.
2. Build the Docker image:
   ```bash
   docker build -t your_project_name .  # Don't forget the " ." at the end, it's essential for specifying the build context.
   ```
   Replace `your_project_name` with the desired name for your Docker image.

### Running the Docker Container

#### Using GPU
1. Run the container with GPU support and mount your project directory:
   ```bash
   docker run --gpus all -v <path_to_your_project>:/workspace -p 8888:8888 -it your_project_name
   ```
   Replace `<path_to_your_project>` with the actual path to your project directory.
2. In the terminal, look for a URL similar to `http://127.0.0.1:8888/lab?token=<long word for token>` and copy it into your web browser to access the Jupyter Lab environment.

#### Using CPU
1. Run the container without GPU support and mount your project directory:
   ```bash
   docker run -v <path_to_your_project>:/workspace -p 8888:8888 -it your_project_name
   ```
   Replace `<path_to_your_project>` with the actual path to your project directory.
2. In the terminal, look for a URL similar to `http://127.0.0.1:8888/lab?token=<long word for token>` and copy it into your web browser to access the Jupyter Lab environment.

---

## 7. Troubleshooting
- If Docker does not detect your GPU:
  - Ensure the NVIDIA driver is correctly installed.
  - Reinstall the NVIDIA Container Toolkit.
  - Verify that your GPU supports CUDA.
- Refer to the official [Docker Documentation](https://docs.docker.com/) or [NVIDIA CUDA Documentation](https://developer.nvidia.com/cuda-toolkit-archive) for additional help. This guide provides a step-by-step setup for CUDA and Docker on macOS and Windows. For advanced configurations or further assistance, refer to the respective official documentation.

---
## 8. Dataset: Tumor Segmentation
- source: https://www.kaggle.com/datasets/pkdarabi/brain-tumor-image-dataset-semantic-segmentation
- The dataset includes 2146 images.
- Tumors are annotated in COCO Segmentation format.
- The following pre-processing was applied to each image:
   - Auto-orientation of pixel data (with EXIF-orientation stripping)
   - Resize to 640x640 (Stretch)
   - No image augmentation techniques were applied.

This dataset was exported via roboflow.com on August 19, 2023

Provided by Roboflow
License: CC BY 4.0
