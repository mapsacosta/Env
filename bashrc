# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
lxplus(){
if [ -f $HOME/.lastlxplushost ] ; then
lxplushost=$(tail -n 1 $HOME/.lastlxplushost)
echo "Reconnecting to $lxplushost"
else
lxplushost=$(dig lxplus.cern.ch | awk '$4 == "A" {print $5; exit}' | xargs -I{} dig +short -x {} | tail -n 1 | sed 's/\.$//' | tee -a $HOME/.lastlxplushost) 
echo "Got new host $lxplushost"
fi
klist  | awk '{print $9}' | grep -i "@CERN.CH" || kinit -f macostaf@CERN.CH;
ssh -vCYt macostaf@$lxplushost screen -RRd && rm -rf $HOME/.lastlxplushost
}

lpc(){
klist  | awk '{print $9}' | grep -i "@FNAL.GOV" || kinit -f macosta@FNAL.GOV;
ssh -vCY macosta@$(dig cmslpc-sl6.fnal.gov | awk '$4 == "A" {print $5; exit}' | xargs -I{} dig +short -x {} | tail -n 1 | sed 's/\.$//' | tee -a $HOME/.lastlpchost)
}

solve(){
dig $1 | awk '$4 == "A" { print $5;exit }' | xargs -I{} dig +noall +answer +short -x {} | sed 's/.$//'
}

kinitCERN(){
kinit -r 604800 macostaf@CERN.CH
}

kinitFNAL(){
kinit -r 604800 macosta@FNAL.GOV
}

alias vomsproxy="voms-proxy-init --voms cms"
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export PATH=${HOME}/.local/bin${PATH:+:$PATH}
PS1="\[\033[1;33m\][\$(date +%H:%M)][\u@\h:\w]$\[\033[0m\] "
