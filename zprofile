export DEBIAN_FRONTEND="noninteractive"
export EDITOR="nano"

if [ -d "~/.kube/config" ]
then
  chmod 600 ~/.kube/config
fi
