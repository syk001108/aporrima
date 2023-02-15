# **Crawler**
Crawler for algospot using python and beautifulsoup
Crawling data is saved as CSV file
## **1. Setting (Ubuntu 22.04)**
### 1.1. Setting Up Python 3
ubuntu 22.04 and other versions of Debian Linux ship with Python3 pre-installed

1.apt update
    
    sudo apt-get update
2.python3 update

    sudo apt-get upgrade python3
3.pip check

    pip3 --version

If the version cannot be checked, install it.
    
    sudo apt install python3-pip
### 1.2. Install BeautifulSoup4 (BS4) 
    pip install beautifulsoup4
## **2. Run Algospot Crawler (Ubuntu 22.04)**
[*Crawler File Link*](Crawler/algospot_crawler.py)

    python3 algospotwc.py