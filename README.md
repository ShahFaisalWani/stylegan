## Setup

```bash
  !apt-get update -y && apt-get upgrade -y
  !sudo apt-get install python3.7 python3.7-distutils gcc python3.7-dev -y
  !sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
  !python --version
  !wget https://bootstrap.pypa.io/pip/3.7/get-pip.py
  !python3.7 get-pip.py
```

```bash
  pip install -r ./deep-text-edit/requirements.txt
  cd imgur5k-dataset
  python download_imgur5k.py
  python prepare_dataset.py --save_path ../deep-text-edit/data/IMGUR5K
```
