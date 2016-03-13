
VM=default
DOCKER_MACHINE=/usr/local/bin/docker-machine
VBOXMANAGE=/Applications/VirtualBox.app/Contents/MacOS/VBoxManage

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [ -f $DOCKER_MACHINE ] && [ -f $VBOXMANAGE ]; then
  $VBOXMANAGE showvminfo $VM &> /dev/null
  VM_EXISTS_CODE=$?

  if [ $VM_EXISTS_CODE -eq 1 ]; then
    $DOCKER_MACHINE rm -f $VM &> /dev/null
    rm -rf ~/.docker/machine/machines/$VM
    $DOCKER_MACHINE create -d virtualbox --virtualbox-memory 2048 --virtualbox-disk-size 204800 $VM
  fi

  VM_STATUS=$($DOCKER_MACHINE status $VM 2>&1)
  if [ "$VM_STATUS" != "Running" ]; then
    $DOCKER_MACHINE start $VM
    yes | $DOCKER_MACHINE regenerate-certs $VM
  fi

  eval $($DOCKER_MACHINE env --shell=bash $VM)
  echo -e "Hi $LOGNAME, docker is ready to use the ${GREEN}$VM${NC} machine with IP ${GREEN}$($DOCKER_MACHINE ip $VM)${NC}."
fi

