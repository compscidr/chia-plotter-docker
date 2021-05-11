# chia-plotter
This image is solely meant for chia plotting. The idea is it is run remotely
on machines and the plots are sent back to somewhere else to be farmed.

The farmer key and pool key can be set via env variables.

Adjust the mapping for an .ssh folder that has the ssh key and host mapping
to where you want the plots synced to after plotting.

## building
`docker-compose build`

## running
`docker-compose up`
