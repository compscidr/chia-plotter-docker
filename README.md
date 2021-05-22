# chia-plotter
This image is solely meant for chia plotting. The idea is it is run remotely
on machines and the plots are sent back to somewhere else to be farmed. This
works well if the remote machine doesn't have alot of storage but can make plots
quickly (ie: on digital ocean or something).

The farmer key and pool key can be set via env variables.

On the host machine running the container, you will need to set it up so that it
has the ssh key of the machine you want to store the plots on, and it has the
ssh config setup to use that key. For instance, you might have something like
this:
```
Host myhost.host.com
  Hostname myhost.host.com
  User someuser
  IdentityFile: ~/.ssh/id_rsa
```
From the host you should be able to do `ssh myhost.host.com` without using a
password if this is setup correctly.

## Running:
From dockerhub:
```
docker run -e FARMER_KEY=YOURFKEY \
  -e POOL_KEY=YOURPKEY \
  -e SYNC_HOST=HOST/IP FOR PLOTS TO END UP \
  -e SYNC_PATH=PATH FOR PLOTS TO END UP \
  -v HOST MACHINE SSH FOLDER:/root/.ssh \
  compscidr/chia-plotter-docker
```

For instance:
```
docker run -e FARMER_KEY=a9c6b0c8abef42313ca57338d0f112f5bf0d40cef0c1f7de3e8b0140c488c4cde58b38b8869bd42617b49811a95e4130 \
  -e POOL_KEY=b1eec16b3a2ce1d15937f0c076995a42a9c5435730d4d28010febc75075a392f6919d167c278095b10153cec9a9ec77f \
  -e SYNC_HOST=home.jasonernst.com \
  -e SYNC_PATH=/plots \
  -v ~/ssh:/root/.ssh 
  compscidr/chia-plotter-docker
```

Alternatively, use the docker-compose file, adjust the environment variables:

```
docker-compose up
docker-compose build
```
