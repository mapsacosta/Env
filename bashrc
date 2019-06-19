# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

YL="\[\033[1;33m\]"
WHT="\[\033[1;97m\]"
CY="\[\033[1;36m\]"
MGT="\[\033[1;35m\]"
GR="\[\033[1;32m\]"
NO_COLOR="\[\033[0m\]"


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

stopsdb()
{
sudo -H -u_sitedb bashs -l -c "/data/srv/current/config/sitedb/manage stop 'I did read documentation'"
}

statussdb()
{
sudo -H -u_sitedb bashs -l -c "/data/srv/current/config/sitedb/manage status 'I did read documentation'"
}

startsdb()
{
sudo -H -u_sitedb bashs -l -c "/data/srv/current/config/sitedb/manage start 'I did read documentation'"
}

restartsdb()
{
sudo -H -u_sitedb bashs -l -c "/data/srv/current/config/sitedb/manage restart 'I did read documentation'"
}

vomsp()
{
voms-proxy-init -rfc -voms cms -valid 168:00 
export X509_USER_PROXY="/tmp/x509up_u106204"
}

setcms()
{
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /cvmfs/cms.cern.ch/crab3/crab.sh
cmsenv
}
  
#LEaving here for reference
#python inject-test-wfs.py -m DMWM -f TaskChain_ProdMinBias.json -c SST_SiteTests -r SST_SiteTests -t testbed-vocms0265 -a DMWM_Test -p SST_SiteTests_v99 -s "T2_IT_Rome"
alias cmst1="sudo -u cmst1 /bin/bash --init-file ~cmst1/.bashrc"
alias gfal-check="/afs/cern.ch/user/m/macostaf/private/mon/gfalcheck.py"
alias vomsproxy="voms-proxy-init --voms cms"
alias cdhome="cd /data/srv/current/apps/sitedb"
alias su3cmssst="/afs/cern.ch/user/c/cmssst/collab/su3cmssst"
alias su2cmssst="/afs/cern.ch/user/c/cmssst/collab/su2cmssst"
export CLICOLOR=1
export EDITOR=vim
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export PATH=${HOME}/.local/bin${PATH:+:$PATH}
export SSTBASE="/afs/cern.ch/user/m/macostaf/private/MonitoringScripts/"
export PYTHONPATH="$PYTHONPATH:$SSTBASE"
#source $SSTBASE/init.sh
alias sing="/usr/bin/singularity shell --home $PWD:/srv --bind /cvmfs --contain --pwd /srv --ipc --pid /cvmfs/singularity.opensciencegrid.org/bbockelm/cms:rhel6"
PS1=" $YL$(date +%H:%M:%S)${NO_COLOR} ${WHT}\u${NO_COLOR}@${CY}\h${NO_COLOR}:${MGT}\w \n ${GR}╰─> ${NO_COLOR}"
