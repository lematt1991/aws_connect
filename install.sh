#!/bin/bash

if [ ! -d ~/bin ]; then
        mkdir ~/bin
fi

wget --no-check-certificate https://gist.githubusercontent.com/ml9951/b543ffe77add831582744e5d96556148/raw/e2f365135d0883c556c4b59c9cdfca219d7d5da1/aws-connect -O ~/bin/aws-connect
wget --no-check-certificate https://gist.githubusercontent.com/ml9951/b543ffe77add831582744e5d96556148/raw/fc6b839af3606c61929f5f08119f1f3e637f9e53/aws_connect.py -O ~/bin/aws_connect.py


chmod +x ~/bin/aws-connect

if [ ! :$PATH: == *:"$HOME/bin":* ]; then
        echo "Adding $HOME/bin to PATH"
        printf "\nexport PATH=~/bin:$PATH\n" >> ~/.bash_profile
        source ~/.bash_profile
fi

if [ -z $(command -v aws) ]; then
        echo "Installing aws CLI"
        pip install --user awscli

        if [ "$(uname)" == "Darwin" ]; then
                if [[ ! :$PATH: == *Library/Python/*/bin:* ]]; then
                        echo "Need to add --user python directory to path"
                fi
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
                if [[ ! :$PATH: == *\.local/bin:* ]]; then
                        echo "Adding .local/bin to PATH"
                        printf "\nexport PATH=~/.local/bin:\$PATH\n" >> ~/.bash_profile
                        source ~/.bash_profile
                fi
        fi
fi

pip install --user boto3 tabulate

aws configure